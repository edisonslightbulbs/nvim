local status, conform = pcall(require, "conform")
if not status then
	print("-- something went wrong while setting up conform!")
	return
end

_G.clang_config_file_path = config.path.join(vim.fn.stdpath("config"), "formatting", ".clang-format")
_G.cmake_config_file_path = config.path.join(vim.fn.stdpath("config"), "formatting", ".cmake-format.yaml")

if config.path.exists(clang_config_file_path) == false then
    error("Unable to resolve " .. clang_config_file_path)
end

if config.path.exists(cmake_config_file_path) == false then
    error("Unable to resolve " .. cmake_config_file_path)
end


_G.setup_clang_format_file = function()
    local filepath = vim.fn.expand("%:p")
    local target_dir = vim.fn.fnamemodify(filepath, ":h")
    local target_file_path = target_dir .. "/.clang-format"

    local file = io.open(target_file_path, "r")
    if file == nil then
        local source, src_err = io.open(clang_config_file_path, "rb")
        local destination, dest_err = io.open(target_file_path, "wb")

        if source and destination then
            destination:write(source:read("*a"))
            source:close()
            destination:close()

            -- Cross-platform permission handling
            local is_windows = package.config:sub(1,1) == '\\'
            local cmd = ""
            if is_windows then
                cmd = "icacls " .. target_file_path .. " /grant Everyone:R"
            else
                cmd = "chmod 644 " .. target_file_path
            end

            local success, errmsg = pcall(function() os.execute(cmd) end)
            if not success then
                vim.api.nvim_err_writeln("Failed to set permissions: " .. errmsg)
            end
        else
            if not source then
                vim.api.nvim_err_writeln("Failed to open source file: " .. src_err)
            end
            if not destination then
                vim.api.nvim_err_writeln("Failed to open destination file: " .. dest_err)
            end
        end
    else
        file:close()
    end
end

vim.cmd("autocmd BufEnter *.cpp,*.h lua _G.setup_clang_format_file()")


_G.cleanup_clang_format_file = function()
    local filepath = vim.fn.expand("%:p")
    local target_dir = vim.fn.fnamemodify(filepath, ":h")
    local target_file_path = target_dir .. "/.clang-format"

    local file = io.open(target_file_path, "r")
    if file ~= nil then
        file:close()

        local success, errmsg = pcall(vim.loop.fs_unlink, target_file_path)
        if not success then
            vim.api.nvim_err_writeln("Failed to remove " .. target_file_path .. ": " .. errmsg)
        end
    end
end

vim.cmd("autocmd VimLeave,BufUnload *.cpp,*.h lua _G.cleanup_clang_format_file()")



conform.setup({
	lazy = true,
	formatters_by_ft = {
		python = { "autopep8", "isort"},
		lua = { "stylua" },
		cpp = { "clang_format" },
		h = { "clang_format" },
		cmake = { "cmake_format" },
		clangd = { "clang_format" },
		latex = { "latexindent" },
		yaml = { "yamlfmt" },
		json = { "jq" },
	},

	formatters = {
		python = {
			command = "autopep8",
			args = { "--in-place", "--aggressive", "--aggressive", "--max-line-length 120", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		clang_format = {
			command = "clang-format",
			args = { "--style=file", "-i", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		cmake_format = {
			command = "cmake-format",
			args = { "-c", cmake_config_file_path, "-i", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		latexindent = {
			command = "latexindent",
			args = { "-wd", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},
	},
})

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	conform.format({ async = false, lsp_fallback = true, range = range })
end, { range = true })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<leader>i", ":Format<CR>", opts)
map("x", "<leader>i", ":Format<CR>", opts)
