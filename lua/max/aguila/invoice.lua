vim.keymap.set('n', '<leader>ali', function()
  coroutine.wrap(
    function ()
      local lines = require('fzf').fzf("bat $AGUILA/billing/liens/liens.csv -p -f", "--ansi --header-lines=1 --multi")
      for i=1,#lines do
        local fields = {}
        for field in lines[i]:gmatch(",?([%w%s%-%.#]+),?") do
          table.insert(fields, field)
        end
        local invoice = fields[1]
        local dos = fields[2]
        local name = fields[4]
        if invoice then
          if name then
            if dos then
              lines[i] = name .. ';' .. invoice .. ';' .. dos
            end
          end
        else
            lines[i] = invoice
        end
      end
      if vim.api.nvim_buf_get_name(0) == os.getenv('AGUILA').."/accounting/by_invoice.csv" then
        vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
      else
        -- print('opening by_invoice.csv and doing things')
      end
    end)()
end, {desc='Aguila lien invoice'})
