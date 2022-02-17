local tmux = require("tmux")
local vim = vim
local M = {
}

P = function(v)
    print(vim.inspect(v))
    return v
end

M.setup = function(opts)
end

M.get_scenario = function()
    local scenario = vim.api.nvim_get_current_line()
    if not scenario:find("Scenario") then
        print("Line is not a Scenario or Scenario Outline")
        return nil
    else
        scenario = string.gsub(scenario, '^%s+', '')
        scenario = string.gsub(scenario, '%s+$', '')
        return scenario
    end


end

M.run_behave = function()
    local scenario = M.get_scenario()
    if scenario ~= nil then
        if not tmux["pane"] then
            tmux.attach_pane()
        end
        local command = "behave -n \'" .. scenario .. "\' -k --color"
        tmux.send_command_to_runner(command)
    end
end

M.debug_behave = function()
    local scenario = M.get_scenario()
    if scenario ~= nil then
        if not tmux["pane"] then
            tmux.attach_pane()
        end
        local command = "behave -n \'" .. scenario .. "\' -k --color --no-capture"
        tmux.send_command_to_runner(command)
    end
end


return M
