local M = {}

M.LIENS_FILE = '/Users/max/code/aguila/billing/liens/liens.csv'
M.SIOYEK_BINARY_PATH = "/Applications/sioyek.app/Contents/MacOS/sioyek"
M.SIOYEK_RUNNING = function ()
  local ps = vim.system({'ps'}):wait()
  local m = ps.stdout:match(M.SIOYEK_BINARY_PATH)
  if m then
    return true
  end
end

vim.api.nvim_create_user_command("CheckLien", function (args)
  local a = args['args']
  if vim.api.nvim_buf_get_name(0) ~= M.LIENS_FILE then
    print("Not the right file to run this in.")
    return
  end
  local line = vim.api.nvim_get_current_line()
  local dos_pdf = os.getenv("SCANS").."/"..line:match("^%d+,([%d%-]+),")..".pdf"
  local page = line:match(",(%d+)$")
  -- can we skip this if it's redundant?
  if not M.SIOYEK_RUNNING() then
    vim.system({'sioyek'}, { stdout = false })
  end
  -- vim.system({'sioyek', dos_pdf,}, { stdout = false })
  vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', dos_pdf,}, { stdout = false }):wait()
  vim.system({'sioyek', '--execute-command', 'goto_page_with_page_number', '--execute-command-data', page}, { stdout = false })
end, {desc="Open record in `sioyek`"})

vim.keymap.set('n', '<leader>alc', ':CheckLien<cr>')

-- NOTE: drafts for reading output of async commands, etc
local example = [[42392 ttys003    0:03.33 /Applications/sioyek.app/Contents/MacOS/sioyek /users/max/library/mobile documents/com~apple~clouddocs/scans/2024-06-05.pdf --execute-command goto_page_with_page_number --execute-command-data 14]]

local function read_ps()
  -- really, get all of this back as a table from a function that parses ps
  local pid, tty, dig, bin, dir, file, args = example:match(
    "(%d+)%s+(%w+%d+)%s+([%d:%.]+)%s([%w+%.%/]+)%s([%/%~%/%d%-%w%s]+/)(%d+%-%d+%-%d+%.pdf)%s(.+)$")
  return {
    ['pid']= pid,
    ['tty']= tty,
    ['dig']= dig,
    ['bin']= bin,
    ['dir']= dir,
    ['file']= file,
    ['args']= args,
  }
end

local function handle_args(args)
  for opt, arg in args:gmatch("(--[%w%-]+)%s([%w+%_%d]+)") do
    print('opt', opt)
    print('arg', arg)
  end
end

-- handle_args(args)

-- local function on_exit(obj)
--   print(obj.code)
-- end

return M
