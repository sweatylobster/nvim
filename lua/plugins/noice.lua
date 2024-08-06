-- lazy.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function ()
    require("noice").setup({
      notify = {
        enabled = false
      },
      messages = {
        enabled = true,
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })

    local function map_noice_cmd(lhs, cmd, mnemonic)
      vim.keymap.set('n', lhs, function ()
        require("noice").cmd(cmd)
      end, {desc=mnemonic})
    end

    map_noice_cmd('<leader>nd', "dismiss", "[N]oice [D]ismiss")

    map_noice_cmd('<leader>nD', "disable", "[N]oice [D]isable")

    map_noice_cmd('<leader>ne', "errors", "[N]oice [E]rrors")

    map_noice_cmd('<leader>nE', "enable", "[N]oice [E]nable")

    map_noice_cmd('<leader>nl', "last", "[N]oice [L]ast")

    map_noice_cmd('<leader>ns', "stats", "[N]oice [S]tats")

    map_noice_cmd('<leader>nt', "telescope", "[N]oice [T]elescope")

    map_noice_cmd('<leader>N', '', "[N]oice")

  end
}
