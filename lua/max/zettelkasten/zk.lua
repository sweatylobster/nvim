local M = {}

function M.new(title, author, date_fmt)
  -- NOTE: api-buffer
  -- make a new buffer
  local b_num = vim.api.nvim_create_buf(true, false)

  local author = author or os.getenv("AUTHOR")
  -- set the contents as a table of lines
  local contents = {
    '---',
    'date: '..os.date(date_fmt or "%Y-%m-%d %H:%M:%S"),
    'author: '..author,
    'title: '..title,
    '---'}
  vim.api.nvim_buf_set_lines(b_num, 0, -1, true, contents)

  -- switch to it 
  vim.cmd('b '..b_num)

end

return M
