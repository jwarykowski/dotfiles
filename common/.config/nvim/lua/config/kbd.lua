-- moonlander layer for the statusline: polls kbd-layer (empty on the base
-- layer or without keymapp) and redraws only when it changes
local M = { layer = "" }

function M.start()
	if vim.fn.executable("kbd-layer") == 0 then
		return
	end
	local timer = vim.uv.new_timer()
	timer:start(0, 1000, function()
		vim.system({ "kbd-layer" }, { text = true }, function(res)
			local layer = vim.trim(res.stdout or "")
			if layer ~= M.layer then
				M.layer = layer
				vim.schedule(function()
					vim.cmd.redrawstatus()
				end)
			end
		end)
	end)
end

function M.status()
	return M.layer ~= "" and ("⌨ " .. M.layer) or ""
end

return M
