local M = {}

--const
M.LIENS_PATH = '/Users/max/code/aguila/billing/liens/liens.csv'

--const
M.SIOYEK_BINARY_PATH = "/Applications/sioyek.app/Contents/MacOS/sioyek"

--bool: psstate
M.is_sioyek_running = function ()
  local start = os.time()
  local ps = vim.system({'ps'}):wait()
  local m = ps.stdout:match(M.SIOYEK_BINARY_PATH)
  if m then
    return true
  end
  local finish = os.time()
end

--bool: nvimstate
M.is_in_liens = function ()
  if vim.api.nvim_buf_get_name(0) ~= M.LIENS_PATH then
    print("Not the right file to run this in.")
    return false
  else
    return true
  end
end

--{string, string}: nvimcurrentline
M.get_pdf_fields = function()
  local line = vim.api.nvim_get_current_line()
  local path = os.getenv("SCANS").."/"..line:match("^%d+,([%d%-]+),")..".pdf"
  local page = line:match(",(%d+)$")
  return path, page
end

--const: useropts
M.PAGER = false

--const: useropts
M.OIL_PAGER = false

--const: 
M.LAST_PDF = {
  update = function(dos_pdf)
    -- print('updating: ', dos_pdf)
    local file = assert(io.open('/tmp/last_pdf', "w+"))
    file:write(dos_pdf)
    file:close()
  end,
  read = function ()
    -- print('reading:', s)
    local file = assert(io.open('/tmp/last_pdf', 'r'))
    local s = file:read()
    file:close()
    return s
  end
}

M.sioyek = {
  open_document = function (path, async)
    if async then
      vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', path,}, { stdout = false })
    else
      vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', path,}, { stdout = false }):wait()
    end
    M.LAST_PDF.update(path)
    vim.system({'sioyek', '--execute-command', 'fit_to_page_height'}, { stdout = false })
  end,
  goto_page_with_page_number = function (page)
    vim.system({'sioyek', '--execute-command', 'goto_page_with_page_number', '--execute-command-data', page}, { stdout = false })
  end
}

M.sioyek_open_pdf = function(path)
    vim.system({'sioyek', '--execute-command', 'open_document', '--execute-command-data', path,}, { stdout = false }):wait()
    M.LAST_PDF.update(path)
    vim.system({'sioyek', '--execute-command', 'fit_to_page_height'}, { stdout = false })
end

M.lookup_page = function ()
  coroutine.wrap(function ()
    assert(M.is_in_liens(), 'This is not the right file to run this in')
    local dos_pdf, page = M.get_pdf_fields()
    if M.LAST_PDF.read() ~= dos_pdf then
      M.sioyek_open_pdf(dos_pdf)
    end
      M.sioyek.goto_page_with_page_number(page)
  end)()
end

vim.api.nvim_create_user_command("LookupPage", function (args)
  M.lookup_page()
end, {desc=""})

vim.api.nvim_create_user_command("PageNext", function ()
  coroutine.wrap(function ()
    vim.system({'sioyek', '--execute-command', 'next_page'}, { stdout = false })
  end)()
end, {desc="Go to the next page"})

vim.api.nvim_create_user_command("PagePrevious", function ()
  coroutine.wrap(function ()
    vim.system({'sioyek', '--execute-command', 'previous_page'}, { stdout = false })
  end)()
end, {desc="Go to the previous page"})

vim.api.nvim_create_user_command("PagerToggle", function ()
  coroutine.wrap(function ()
    assert(M.is_in_liens(), "This is not the right file to do this in.")
    M.PAGER = not M.PAGER
    if M.PAGER then
      -- TODO: figure out a way to hide cmd from showing :/
      vim.cmd [[nnoremap <silent> <buffer> j j:LookupPage<CR>]]
      vim.cmd [[nnoremap <silent> <buffer> k k:LookupPage<CR>]]
      vim.cmd [[nmap <silent> <buffer> n n:LookupPage<CR>]]
      vim.cmd [[nmap <silent> <buffer> N N:LookupPage<CR>]]
    else
      vim.api.nvim_buf_del_keymap(0, 'n', 'j')
      vim.api.nvim_buf_del_keymap(0, 'n', 'k')
      vim.api.nvim_buf_del_keymap(0, 'n', 'n')
      vim.api.nvim_buf_del_keymap(0, 'n', 'N')
    end
  end)()
end, {desc="Easily page through records"})

vim.api.nvim_create_user_command("CheckLien", function (args)
  local a = args['args']
  assert(M.is_in_liens(), "Not the right file to run this in.")
  local dos_pdf, page = M.get_pdf_fields()
  -- can we skip this if it's redundant?
  if not M.is_sioyek_running() then
    vim.system({'sioyek'}, { stdout = false })
  end
  -- maybe do something with M.DOS_PDF, like checking if we need to change the file
  if M.LAST_PDF.read() ~= dos_pdf then
    M.sioyek_open_pdf(dos_pdf)
  else
    vim.system({'sioyek', '--execute-command', 'goto_page_with_page_number', '--execute-command-data', page}, { stdout = false })
  end
end, {desc="Open record in `sioyek`"})

vim.keymap.set('n', '<leader>alc', ':CheckLien<cr>', {desc = "[C]heck highlighted [L]ien"})
vim.keymap.set('n', '<leader>alp', ':PagerToggle<cr>', {desc = "Toggle [l]ien [p]ager"})

vim.api.nvim_create_user_command("OilLookup", function (args)
  local pdf = vim.api.nvim_get_current_line():match("[%w%-%_%d]+%.pdf")
  M.sioyek.open_document(pdf, true)
end, {desc="Open pdf in `sioyek`"})

vim.keymap.set('n', '<leader>O', function ()
  if vim.o.filetype == "oil" then
    vim.cmd("OilLookup")
  end
end)

vim.api.nvim_create_user_command("OilPagerToggle", function ()
  coroutine.wrap(function ()
    M.OIL_PAGER = not M.OIL_PAGER
    if M.OIL_PAGER then
      vim.cmd [[nnoremap <silent> <buffer> j j:OilLookup<CR>]]
      vim.cmd [[nnoremap <silent> <buffer> k k:OilLookup<CR>]]
    else
      vim.api.nvim_buf_del_keymap(0, 'n', 'j')
      vim.api.nvim_buf_del_keymap(0, 'n', 'k')
    end
  end)()
end, {desc="Easily page through records"})

return M
