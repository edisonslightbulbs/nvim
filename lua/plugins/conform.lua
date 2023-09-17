local status, conform = pcall(require, "conform")
if not status then
	print("-- something went wrong while setting up conform!")
	return
end

conform.setup({
	formatters_by_ft = {
		python = { "isort", "autopep8" },
		lua = { "stylua" },
		cmake = { "cmake_format" },
		cpp = { "clang_format" },
		latex = { "latexindent" },
		yaml = { "yamlfmt" },
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
	conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<leader>i", ":Format<CR>", opts)
map("x", "<leader>i", ":Format<CR>", opts)

local util = require("conform.util")
---@type conform.FileFormatterConfig
return {
	meta = {
		url = "https://github.com/psf/black",
		description = "The uncompromising Python code formatter.",
	},
	command = "black",
	args = {
		"--stdin-filename",
		"$FILENAME",
		"--quiet",
		"-",
	},
	cwd = util.root_file({
		-- https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#configuration-via-a-file
		"pyproject.toml",
	}),
}
