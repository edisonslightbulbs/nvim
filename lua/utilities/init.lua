-- string empty?
_G.is_empty = function(str)
	return str == nil or str == ''
end

-- strips white spaces
_G.strip = function(str)
	local stripped = string.gsub(str, '%s+', '')
	return stripped
end

require('utilities.path')
require('utilities.buffer')
