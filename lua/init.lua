local vim = vim
local M = {
}

P = function(v)
    print(vim.inspect(v))
    return v
end

M.send_command = function(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  return s
end

M.setup = function(opts)
end

M.tmux_panes = function()
    local panes = M.send_tmux_command("list-panes")
    print(panes)
    local split_panes = vim.split(panes, "\n")
    P(split_panes)
    return split_panes
end

M.prompt_for_pane_to_attach = function()
    os.execute("tmux display-panes")
end

M.send_tmux_command = function(command)
    return M.send_command("tmux " .. command)
end

M.attach_pane = function()
    local numb_panes = tonumber(M.send_command("tmux display-message -p '#{window_panes}'"))
    if numb_panes == 1 then
        print("create new pane")
    elseif numb_panes == 2 then
        -- TODO auto attach_pane
        M.prompt_for_pane_to_attach()
        local pane_to_attach = tonumber(vim.fn.input('Enter pane number: '))
        M["pane"] = pane_to_attach
        P(M)
    else
        M.prompt_for_pane_to_attach()
        local pane_to_attach = tonumber(vim.fn.input('Enter pane number: '))
        M["pane"] = pane_to_attach
        P(M)
    end
end

M.run_behave = function()
    print("Hello world")
end

M.debug_behave = function()
    print("Hello world")
end

-- M.attach_pane()
M.tmux_panes()
return M
