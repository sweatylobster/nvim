local M = {
  -- Returns stdout of a command as a string.
  to_string = function(cmd, raw)
    local choice = assert(io.popen(cmd, "r"))
    local s = assert(choice:read("*all"))
    choice:close()
    if raw then
      return s
    end
    s = s:gsub("^%s+", "")
    s = s:gsub("%s+$", "")
    s = s:gsub("[\n\r]+", "")
    return s
  end,
  -- Return a table with lines of stdout.
  ---@param command string
  ---@return table stdout-lines
  to_table = function(command)
    local a = {}
    local f = assert(io.popen(command, "r"))
    assert(f:lines("a"))
    for l in f:lines() do
      table.insert(a, l)
    end
    return a
  end,
}

return M
