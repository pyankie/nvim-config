return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup({
      enable = true, -- Enable this plugin
      max_lines = 0, -- No limit for the number of lines shown
      trim_scope = "outer", -- Show outer context, trimming inner details
      mode = "cursor", -- Display based on cursor position
      -- separator = "-", -- Add a separator line between context and code
      separator = "", -- Add a separator line between context and code
    })
  end,
}
