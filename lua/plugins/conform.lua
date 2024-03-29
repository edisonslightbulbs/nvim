print("-- setting up conform")

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
	},

	formatters = {
		python = {
			command = "autopep8",
			args = { "--in-place", "--aggressive", "--aggressive", "--max-line-length=120", "$FILENAME" },
			stdin = false,
			exit_codes = { 0 },
		},

		clang_format = {
            command = config.clang.path,
			args = { "--style=file", "-i", "$FILENAME" },
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
