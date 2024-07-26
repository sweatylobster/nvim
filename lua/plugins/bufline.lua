-- return {
--   'akinsho/bufferline.nvim',
--   version = "*",
--   dependencies = 'nvim-tree/nvim-web-devicons',
--   diagnostics = "nvim_lsp",
--   config = function ()
--     require("bufferline").setup{}
--     --- count is an integer representing total count of errors
--     --- level is a string "error" | "warning"
--     --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
--     --- this should return a string
--     --- Don't get too fancy as this function will be executed a lot
--     diagnostics_indicator = function(count, level, diagnostics_dict, context)
--       local icon = level:match("error") and " " or " "
--       return " " .. icon .. count
--     end
--   end,
-- }
--
return {
    "akinsho/bufferline.nvim",
       dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local bl = require("bufferline")
        local inactive_bg = "#606060"
        local inactive_fg = "#e0e0e0"
        local visible_bg = "#e0e0e0"
        local visible_fg = "#404040"
        local selected_bg = "#c2c2c2"
        local selected_fg = "#000000"
        local background  = "#24283b"
        local inactive_set = { fg = inactive_fg, bg = inactive_bg, }
        local visible_set = { fg = visible_fg, bg = visible_bg, }
        local active_set = { fg = selected_fg, bg = selected_bg, }

        bl.setup({
            highlights = {
                background = inactive_set,
                buffer_visible = visible_set,
                buffer_selected = active_set,

                numbers = inactive_set,
                numbers_visible = visible_set, 
                numbers_selected = active_set,
 
                separator = { fg = background, bg = inactive_bg },
                separator_visible = { fg = background, bg = visible_bg },
                separator_selected = { fg = background, bg = selected_bg },

                modified = { fg = '#ff0000', bg = inactive_bg, },
                modified_visible = { fg = '#ff0000', bg = visible_bg, },
                modified_selected = { fg = '#ff0000', bg = selected_bg, },

                fill = { bg = background, }
            },
            options = {
                themable = true,
                style_preset = {
                    bl.style_preset.no_italic,
                    bl.style_preset.no_bold,
                },
                separator_style = 'slant',
                indicator = { style = 'none'},
                numbers = "buffer_id",
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = false,
                tab_size = 5,
            }
    })
    end,
}
