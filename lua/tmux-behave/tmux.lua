Tmux = {}

Tmux.send_command = function(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  return s
end

Tmux.tmux_panes = function()
    local panes = Tmux.send_tmux_command("list-panes")
    print(panes)
    local split_panes = vim.split(panes, "\n")
    P(split_panes)
    return split_panes
end

Tmux.send_command_to_runner = function(cmd)
    os.execute("tmux send-keys -t " .. Tmux["pane"] .. " \"".. cmd .. "\" Enter")
end

Tmux.prompt_for_pane_to_attach = function()
    os.execute("tmux display-panes")
end

Tmux.send_tmux_command = function(command)
    return Tmux.send_command("tmux " .. command)
end

Tmux.attach_pane = function()
    local numb_panes = tonumber(Tmux.send_command("tmux display-message -p '#{window_panes}'"))
    if numb_panes == 1 then
        print("create new pane")
    elseif numb_panes == 2 then
        -- TODO auto attach_pane
        Tmux.prompt_for_pane_to_attach()
        local pane_to_attach = tonumber(vim.fn.input('Enter pane number: '))
        Tmux["pane"] = pane_to_attach
    else
        Tmux.prompt_for_pane_to_attach()
        local pane_to_attach = tonumber(vim.fn.input('Enter pane number: '))
        Tmux["pane"] = pane_to_attach
    end
end

return Tmux
