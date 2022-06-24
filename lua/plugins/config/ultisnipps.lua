local status, ret = pcall(require, "cmp_nvim_ultisnips")
if not status then
    print("-- something went wrong while setting up cmp_nvim_ultisnips!")
    return
end

require("cmp_nvim_ultisnips").setup {
    filetype_source = "treesitter",
    show_snippets = "all",
    documentation = function(snippet)
        return snippet.description
    end
}
