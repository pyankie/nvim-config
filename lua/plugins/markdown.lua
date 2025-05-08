return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "copilot-chat" },
    config = function()
      require("render-markdown").setup({})
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
