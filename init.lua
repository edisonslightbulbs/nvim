-- config table for global variables
_G.config = {}

require('utilities')
require('settings')
require('keybinds')
require('plugins')

-- to inspect _G.config: print global functions and variables
-- :lua for k, v in pairs(_G) do print(k .. ':', v) end
