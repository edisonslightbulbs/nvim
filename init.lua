-- config table to organize global variables while avoiding reserved lua key words 
_G.config = {}

require('utilities')
require('settings')
require('keybinds')
require('plugins')

-- print global functions and variables to inspect _G.config
-- lua for k, v in pairs(_G) do print(k .. ':', v) end
