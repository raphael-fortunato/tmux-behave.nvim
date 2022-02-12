local tmux = require("lua.tmux")
local vim = vim
local M = {
}

P = function(v)
    print(vim.inspect(v))
    return v
end

M.setup = function(opts)
end

M.send_command = function(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  return s
end

M.run_behave = function()
    print("Hello world")
end

M.debug_behave = function()
    print("Hello world")
end

-- M.attach_pane()
tmux.tmux_panes()
return M
