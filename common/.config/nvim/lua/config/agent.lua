-- send code to an agent in this herdr workspace without leaving nvim:
-- your instruction plus file:line (or the selected lines in a fenced block)
-- goes through `herdr agent prompt`
local M = {}

local function agents_here()
	local workspace = vim.env.HERDR_WORKSPACE_ID
	if not workspace then
		return nil, "not running inside herdr"
	end
	local res = vim.system({ "herdr", "agent", "list" }, { text = true }):wait()
	local ok, data = pcall(vim.json.decode, res.stdout or "")
	if res.code ~= 0 or not ok then
		return nil, "herdr agent list failed"
	end
	local found = {}
	for _, agent in ipairs(data.result.agents) do
		if agent.workspace_id == workspace and agent.pane_id ~= vim.env.HERDR_PANE_ID then
			table.insert(found, agent)
		end
	end
	return found
end

local function context(range)
	local file = vim.fn.expand("%:.")
	if not range then
		return ("%s:%d"):format(file, vim.fn.line("."))
	end
	local lines = vim.api.nvim_buf_get_lines(0, range[1] - 1, range[2], false)
	return ("%s:%d-%d\n```%s\n%s\n```"):format(file, range[1], range[2], vim.bo.filetype, table.concat(lines, "\n"))
end

local function submit(agent, prompt)
	vim.system({ "herdr", "agent", "prompt", agent.pane_id, prompt }, { text = true }, function(res)
		vim.schedule(function()
			if res.code == 0 then
				vim.notify("sent to " .. agent.agent)
			else
				local msg = res.stderr ~= "" and res.stderr or res.stdout
				vim.notify("herdr: " .. vim.trim(msg or ""), vim.log.levels.ERROR)
			end
		end)
	end)
end

-- range: { first_line, last_line } for a selection, nil for the cursor line
function M.send(range)
	local agents, err = agents_here()
	if not agents then
		return vim.notify(err, vim.log.levels.WARN)
	end
	if #agents == 0 then
		return vim.notify("no agent in this herdr workspace", vim.log.levels.WARN)
	end
	local ctx = context(range)
	local function ask(agent)
		vim.ui.input({ prompt = agent.agent .. "> " }, function(text)
			if text and text ~= "" then
				submit(agent, text .. "\n\n" .. ctx)
			end
		end)
	end
	if #agents == 1 then
		return ask(agents[1])
	end
	vim.ui.select(agents, {
		prompt = "send to agent",
		format_item = function(agent)
			return ("%s  %s"):format(agent.agent, agent.terminal_title_stripped or agent.pane_id)
		end,
	}, function(agent)
		if agent then
			ask(agent)
		end
	end)
end

return M
