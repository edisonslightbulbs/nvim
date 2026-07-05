-- print("-- setting up conform")

local sep = (vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1) and ";" or ":"
local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
	vim.env.PATH = mason_bin .. sep .. (vim.env.PATH or "")
end

local status, conform = pcall(require, "conform")
if not status then
	print("-- something went wrong while setting up conform!")
	return
end

conform.setup({
	lazy = true,
	formatters_by_ft = {
		python = { "autopep8"},
		lua = { "stylua" },
		cpp = { "clang_format" },
		h = { "clang_format" },
		cmake = { "cmake_format" },
		clangd = { "clang_format" },
		latex = { "latexindent" },
		yaml = { "yamlfmt" },
		json = { "jq" },
		jsonc = { "jq" },
	},

	formatters = {
		autopep8 = {
			command = "autopep8",
			args = { "--in-place", "--aggressive", "--aggressive", "--max-line-length=120", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		clang_format = {
			command = "clang-format",
			-- If config.clang.path is a file path to a .clang-format config, clang-format supports:
			-- -style=file:<format_file_path>
			args = { "-style=file:" .. config.clang.path, "-i", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		cmake_format = {
			command = "cmake-format",
			args = { "-c", config.cmake.path, "-i", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		latexindent = {
			command = "latexindent",
			args = { "-wd", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		jq = {
			command = "jq",
			-- jq needs a filter; "." means identity + pretty print.
			-- -S sorts keys for stable formatting.
			args = { "-S", "." },
			stdin = true,
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
	conform.format({ async = false, lsp_format = "fallback", range = range })
end, { range = true })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<leader>i", ":Format<CR>", opts)
map("x", "<leader>i", ":Format<CR>", opts)
