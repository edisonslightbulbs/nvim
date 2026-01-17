-- print("-- setting up toggleterm")

local status, toggleterm = pcall(require, "toggleterm")
if not status then
	print("-- something went wrong while setting up toggleterm!")
	return
end


local function ensure_toggleterm_cursor_shape()
  local gc = vim.o.guicursor
  if not gc or gc == "" then
    -- If cursor styling is disabled globally, don't override it.
    return
  end

  -- Remove any existing terminal-mode cursor setting, then enforce a bar.
  gc = gc:gsub(",?t:[^,]*", "")
  vim.o.guicursor = gc .. ",t:ver25"
end

ensure_toggleterm_cursor_shape()

local function is_windows()
	return vim.loop.os_uname().sysname == "Windows_NT"
end

local function zsh_term()
	if is_windows() then
		return vim.o.shell
	end

	if vim.fn.executable("zsh") == 1 then
		return "zsh"
	end

	return vim.o.shell
end

local function sh_quote_posix(s)
	-- safe single-quote for POSIX shells
	return "'" .. tostring(s):gsub("'", [['"'"']]) .. "'"
end

local function ps_quote(s)
	-- single-quote for PowerShell; escape embedded single quotes
	return "'" .. tostring(s):gsub("'", "''") .. "'"
end

local function detect_target_conda_env()
	-- 1) If Neovim itself already has an active conda env, reuse it.
	local env = vim.env.CONDA_DEFAULT_ENV
	if env and env ~= "" then
		return env
	end

	-- 2) If `python` resolves to a conda env interpreter, infer env name from path.
	local py = vim.fn.exepath("python")
	if not py or py == "" then
		py = vim.fn.exepath("python3")
	end
	if py and py ~= "" then
		local from_envs = py:match("[/\\]envs[/\\]([^/\\]+)[/\\]")
		if from_envs and from_envs ~= "" then
			return from_envs
		end
	end

	-- 3) Convention-over-configuration fallback: env name = current working dir name.
	--    (No external files; matches common "repo name == env name" workflows.)
	local cwd = config.path.cwd()
	return vim.fn.fnamemodify(cwd, ":t")
end

local function find_conda_exe()
	-- Prefer CONDA_EXE if present (most reliable on Windows)
	local conda_exe = vim.env.CONDA_EXE
	if conda_exe and conda_exe ~= "" and vim.loop.fs_stat(conda_exe) then
		return conda_exe
	end

	-- Next: search PATH
	local p = vim.fn.exepath("conda")
	if p and p ~= "" and vim.loop.fs_stat(p) then
		return p
	end

	-- Optional: accept mamba/micromamba as a fallback
	p = vim.fn.exepath("mamba")
	if p and p ~= "" and vim.loop.fs_stat(p) then
		return p
	end
	p = vim.fn.exepath("micromamba")
	if p and p ~= "" and vim.loop.fs_stat(p) then
		return p
	end

	-- Windows: try common default install locations (still no external files)
	if is_windows() then
		local home = vim.env.USERPROFILE or ""
		local candidates = {
			home .. "\\miniconda3\\Scripts\\conda.exe",
			home .. "\\miniconda3\\condabin\\conda.bat",
			home .. "\\anaconda3\\Scripts\\conda.exe",
			home .. "\\anaconda3\\condabin\\conda.bat",
			"C:\\ProgramData\\Miniconda3\\Scripts\\conda.exe",
			"C:\\ProgramData\\Miniconda3\\condabin\\conda.bat",
			"C:\\ProgramData\\Anaconda3\\Scripts\\conda.exe",
			"C:\\ProgramData\\Anaconda3\\condabin\\conda.bat",
		}
		for _, c in ipairs(candidates) do
			if vim.loop.fs_stat(c) then
				return c
			end
		end
	end

	return nil
end

local function current_shell_kind()
	if not is_windows() then
		local sh = zsh_term():lower()
		if sh:find("zsh", 1, true) then
			return "zsh"
		end
		return "bash"
	end

	local sh = (vim.o.shell or ""):lower()
	if sh:find("pwsh", 1, true) or sh:find("powershell", 1, true) then
		return "powershell"
	end
	return "cmd"
end

local function build_conda_activate_cmd(conda_exe, env_name, cwd)
	local shell_kind = current_shell_kind()

	if shell_kind == "zsh" or shell_kind == "bash" then
		local conda_q = sh_quote_posix(conda_exe)
		local env_q = sh_quote_posix(env_name)
		local cwd_q = sh_quote_posix(cwd)
		local shell_key = (shell_kind == "zsh") and "zsh" or "bash"

		-- conda shell.<key> activate prints shell code; we eval it. :contentReference[oaicite:1]{index=1}
		return table.concat({
			"cd " .. cwd_q,
			"if " .. conda_q .. " env list | awk '{print $1}' | grep -Fxq -- " .. env_q .. "; then",
			"  eval \"$(" .. conda_q .. " shell." .. shell_key .. " activate " .. env_q .. ")\"",
			"else",
			"  eval \"$(" .. conda_q .. " shell." .. shell_key .. " activate base)\"",
			"fi",
		}, "\n")
	end

	if shell_kind == "powershell" then
		local conda_q = ps_quote(conda_exe)
		local env_q = ps_quote(env_name)
		local cwd_q = ps_quote(cwd)

		-- Use conda's PowerShell activator output and Invoke-Expression pattern. :contentReference[oaicite:2]{index=2}
		return table.concat({
			"Set-Location -LiteralPath " .. cwd_q,
			"$__tt_conda = " .. conda_q,
			"$__tt_env = " .. env_q,
			"$__tt_re = '^' + [regex]::Escape($__tt_env) + '\\s'",
			"$__tt_has = (& $__tt_conda env list) | Select-String -Pattern $__tt_re",
			"if ($__tt_has) {",
			"  (& $__tt_conda shell.powershell activate $__tt_env) | Out-String | Invoke-Expression",
			"} else {",
			"  (& $__tt_conda shell.powershell activate base) | Out-String | Invoke-Expression",
			"}",
		}, "\n")
	end

	-- cmd.exe
	do
		-- For cmd.exe we write the activator output to a temp .bat and call it,
		-- matching conda's “temp script is written and ... called” behavior. :contentReference[oaicite:3]{index=3}
		local conda_q = '"' .. conda_exe .. '"'
		local env_q = '"' .. env_name .. '"'
		local cwd_q = '"' .. cwd .. '"'

		return table.concat({
			"cd /d " .. cwd_q,
			"set \"__TT_CONDA=" .. conda_exe .. "\"",
			"set \"__TT_ENV=" .. env_name .. "\"",
			"\"%__TT_CONDA%\" env list | findstr /R \"^%__TT_ENV%[ ]\" >nul",
			"if errorlevel 1 set \"__TT_ENV=base\"",
			"set \"__TT_TMP=%TEMP%\\toggleterm_conda_activate.bat\"",
			"\"%__TT_CONDA%\" shell.cmd.exe activate \"%__TT_ENV%\" > \"%__TT_TMP%\"",
			"call \"%__TT_TMP%\"",
			"del \"%__TT_TMP%\"",
		}, "\r\n")
	end
end

toggleterm.setup({
	shell = zsh_term(),
	direction = "float",
	hide_numbers = false,
	close_on_exit = false,
	start_in_insert = true,
	-- We own the <C-o> mapping so behavior is identical everywhere.
	insert_mappings = false,
	terminal_mappings = false,
	autochdir = false,
	auto_scroll = false,
	float_opts = {
		border = "curved",
		width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
	},
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

local augroup_keymaps = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup_keymaps,
	pattern = "term://*",
	callback = function()
		_G.set_terminal_keymaps()
	end,
})

-- Ctrl-O toggles open/close in both normal and terminal mode
function _G.toggle_toggleterm_float()
	local cwd = config.path.cwd()
	vim.cmd("ToggleTerm dir=" .. vim.fn.fnameescape(cwd) .. " direction=float")
end

vim.keymap.set("n", "<c-o>", _G.toggle_toggleterm_float, { noremap = true, silent = true })
vim.keymap.set("t", "<c-o>", [[<C-\><C-n><cmd>lua toggle_toggleterm_float()<CR>]], { noremap = true, silent = true })

-- Auto-activate conda env for the main toggleterm terminal (toggle_number == 1) the first time it spawns
local augroup_conda = vim.api.nvim_create_augroup("ToggleTermCondaAutoActivate", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup_conda,
	pattern = "term://*toggleterm#*",
	callback = function(args)
		local bufnr = args.buf

		-- Only initialize once per terminal buffer
		if vim.b[bufnr].__toggleterm_conda_initialized then
			return
		end

		-- Only target the main terminal (avoid messing with custom terminals like lazygit/htop)
		if vim.b[bufnr].toggle_number ~= 1 then
			return
		end

		local conda_exe = find_conda_exe()
		if not conda_exe then
			vim.notify("toggleterm: conda/miniconda not found (CONDA_EXE/PATH/common locations). Opening terminal without activation.", vim.log.levels.WARN)
			vim.b[bufnr].__toggleterm_conda_initialized = true
			return
		end

		local env_name = detect_target_conda_env()
		local cwd = config.path.cwd()
		local cmd = build_conda_activate_cmd(conda_exe, env_name, cwd)

		local chan = vim.b[bufnr].terminal_job_id
		if not chan then
			vim.notify("toggleterm: terminal_job_id missing; cannot auto-activate conda env.", vim.log.levels.WARN)
			vim.b[bufnr].__toggleterm_conda_initialized = true
			return
		end

		-- Send the activation script into the terminal so the environment persists for the session
		vim.api.nvim_chan_send(chan, cmd .. (is_windows() and "\r\n" or "\n"))
		vim.b[bufnr].__toggleterm_conda_initialized = true
	end,
})
