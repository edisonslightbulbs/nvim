-- table for clang functions and variables
_G.config.cmake = {}

config.cmake.path = config.path.join(vim.fn.stdpath("config"), "format", ".cmake-format.yaml")

if config.path.exists(config.cmake.path) == false then
    error("Unable to resolve " .. config.cmake.path)
end
