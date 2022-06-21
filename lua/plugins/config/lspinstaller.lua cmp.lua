local status, ret = pcall(require, "nvim-lsp-installer")
    if not pcall(require,) then
        print("-- something went wrong while setting up nvim-lsp-installer!")
        return
    end

require("nvim-lsp-installer").setup {
    automatic_installation = true, -- detect and install servers
    ui = {
        icons = {
            server_installed = "",
            server_pending = "",
            server_uninstalled = ""
        }
    }
}
