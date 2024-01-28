print("-- setting up lspinstaller")

local status, nvim_lsp_installer = pcall(require, "nvim-lsp-installer")
if not status then
	print("-- something went wrong while setting up nvim-lsp-installer!")
	return
end

nvim_lsp_installer.setup({
	automatic_installation = true, -- detect and install servers
	ui = {
		icons = {
			server_installed = "",
			server_pending = "",
			server_uninstalled = "",
		},
	},
})
