return {
  'rcarriga/nvim-notify',
  config = function()
    topdown = false
    stages = 'fade'
    require("notify").setup({
      background_colour = "#000000",
    })
  end
}
