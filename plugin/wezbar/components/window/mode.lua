local M = {}

function M.update(window)
	local mode = M.get(window):gsub("_mode", "")
	mode = mode:upper()
	return mode
end

function M.get(window)
	local mode = "normal_mode"
	if not window then
		return mode
	end

	if window:leader_is_active() then
		mode = "leader_mode"
		return mode
	end

	local active_key = window:active_key_table() or ""
	if active_key:find("_mode$") then
		mode = active_key
		return mode
	end

	return mode
end

return M
