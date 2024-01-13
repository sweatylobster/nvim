return {
  'voldikss/vim-floaterm',
  dependencies = {
    'voldikss/fzf-floaterm',
    {'junegunn/fzf', build = ":call fzf#install()"}},
  config = function()
    -- Switch between floating terminals
    vim.keymap.set('n', "<leader>ff", ":Floaterms <cr>", { desc = "fzf-floaterms" })

    -- Maybe edit to <leader>fsi for ipython
    -- TODO: make this a function to send to an arbitrary buffer with Telescope or fzf-floaterms
    vim.keymap.set('x', '<leader>fs', ":'<,'>FloatermSend --name=ipython <CR>", { desc = "Send visual selection to ipython" })

    local function parse_opts(opts)
      local results = {}
      for k, v in pairs(opts) do
        if k ~= "cmd" then -- do not parse e.g., 'ipython -i my_script.py', as a command-line option
          table.insert(results, '--'..k..'='..v)
        end
      end
      return table.concat(results, " ")
    end

    local function toggle_floaterm(floaterm)
      local floaterm_exists = vim.api.nvim_call_function('floaterm#terminal#get_bufnr', {floaterm.name})
      local parsed = parse_opts(floaterm)
      if tonumber(floaterm_exists) == -1 then
        local command = string.format(':FloatermNew %s %s', parsed, floaterm.cmd)
        vim.print(command)
        vim.cmd(command)
      else
        vim.cmd(string.format(':FloatermToggle %s', floaterm.name))
      end
    end

    local function make_term_and_normal_mappings(t)
      vim.keymap.set({'n', 't'}, t.maps.lhs, function()
        toggle_floaterm(t.floaterm)
      end, {desc = t.maps.desc})
    end

    local main = {
      floaterm = {
        width  = 0.67,
        height = 0.67,
        name   = 'main',
        autoclose = 1,
        cmd    = ' ',
      },
      maps   = {
        lhs  = '<F2>',
        desc = 'Quick terminal browser :) :) :) :)'
      }
    }

    local ipython = {
      floaterm = {
        width     = 0.67,
        height    = 0.67,
        name      = 'ipython',
        autoclose = 1,
        -- wintype   = 'vsplit',
        cmd       = 'ipython --profile="nvim"',
      },
      maps   = {
        lhs  = '<leader>fI',
        desc = 'Floating Ipython repl'
      }
    }

    local lazygit = {
      floaterm = {
        width  = 0.67,
        height = 0.67,
        name   = 'lazygit',
        autoclose = 1,
        cmd    = 'lazygit',
      },
      maps   = {
        lhs  = '<leader>gg',
        desc = 'Lazygit :)'
      }
    }

    local ipython_buffer = {
      floaterm = {
        width     = 0.67,
        height    = 0.67,
        name      = 'pycurrent-buffer',
        position  = 'topright',
        autoclose = 1,
        cmd       = 'ipython -i '..vim.fn.expand("%"),
      },
      maps   = {
        lhs  = '<F4>',
        desc = 'Run the current pyfile in a floaterm'
      }
    }

    local bash = {
      floaterm = {
        width     = 0.80,
        height    = 0.80,
        name      = 'bash-current-buffer',
        position  = 'center',
        autoclose = 0,
        cmd       = './'..vim.fn.expand("%"),
      },
      maps   = {
        lhs  = '<leader>ss',
        desc = 'Run the current bash-script in a floaterm'
      }
    }

    -- local floaterm_configs = {main, lazygit, ipython, ipython_buffer, bash}
    local floaterm_configs = {main, lazygit, ipython, ipython_buffer}

    for _, config in pairs(floaterm_configs) do
      make_term_and_normal_mappings(config)
    end

  end
}
