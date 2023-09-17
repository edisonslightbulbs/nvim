-- table for path functions and variables
_G.config.host = {}

-- find target executable
config.host.find = function(exec)
	local sep = vim.fn.has("win32") == 1 and ";" or ":"
	local paths = config.str.split(vim.fn.getenv("PATH"), sep)

	for _, dir in ipairs(paths) do
		local execpath = vim.fn.glob(dir .. "/" .. exec .. (vim.fn.has("win32") == 1 and ".exe" or ""))
		if execpath ~= "" then
			return execpath
		end
	end

	return nil
end

-- designate host executables
if config.os() == "Linux" or config.os() == "macOS" then
	vim.g.python3_host_prog = config.host.find("python3.8")
	vim.g.python_host_prog = config.host.find("python")

elseif config.os() == "Windows" then
	-- iff necessary, specific target hosts
	local specific_rb = "C:\\Ruby30-x64\\bin\\ruby.exe"
	local specific_py2 = "C:\\Users\\zoemthun\\AppData\\Local\\Microsoft\\WindowsApps\\python.exe"
	local specific_py3 = "C:\\Users\\zoemthun\\AppData\\Local\\anaconda3\\envs\\nvim\\python.exe"

	if vim.fn.filereadable(specific_rb) == 1 then
		vim.g.ruby_host_prog = specific_rb
	else
		vim.g.ruby_host_prog = config.host.find("ruby")
	end

	if vim.fn.filereadable(specific_py2) == 1 then
		vim.g.python_host_prog = specific_py2
	else
		vim.g.python_host_prog = config.host.find("python")
	end

	if vim.fn.filereadable(specific_py3) == 1 then
		vim.g.python3_host_prog = specific_py3
	else
		vim.g.python3_host_prog = config.host.find("python")
	end
end
