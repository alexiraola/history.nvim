
local function get_shell()
	local shell = vim.api.nvim_call_function('systemlist', { 'echo $SHELL' })
	vim.pretty_print(shell)
end

local function remove_duplicates(list)
	local result = {}
	local hash = {}

	for _, command in pairs(list) do
		if (not hash[command]) then
			table.insert(result, command)
			hash[command] = true
		end
	end

	return result
end

local function get_history()
	get_shell()
	local commands = vim.api.nvim_call_function('systemlist', { 'cat ~/.zsh_history' })
	if #commands == 0 then table.insert(commands, '') end
	for key,value in pairs(commands) do
		local line = vim.split(value, ';', true)
		if line[2] then
			commands[key] = line[2]
		end
	end

	local result = remove_duplicates(commands)

	local reversed = vim.fn.reverse(result)

	vim.pretty_print(reversed)

	return reversed
end

return {
	get_history = get_history,
	get_shell = get_shell
}
