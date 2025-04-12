return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  enabled = false,
  versio = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- Theme options
    theme = {
      -- normal = { fg = "#c0caf5", bg = "#1f2335" },
      ellipsis = { fg = "#737aa2" },
      separator = { fg = "#737aa2" },
      modified = { fg = "#737aa2" },
    },

    -- Customize symbols
    symbols = {
      -- separator = "›", -- alternatives: → ▸
      separator = "→", -- alternatives:  ▸
      -- ellipsis = "…",
      -- modified = "●",
    },

    -- Show file path
    show_basename = true,
    show_modified = false,
    show_dirname = true,

    -- Update triggers
    attach_navic = true,
    create_autocmd = true,

    -- Context options
    include_buftypes = { "" }, -- only show in normal buffers
    exclude_filetypes = { "netrw", "toggleterm" },
    context_follow_icon_color = false,

    -- Custom symbols for specific languages
    custom_lang = {
      -- rust = "",
      -- python = "",
      -- javascript = "",
    },
  },
  config = function()
    require("barbecue").setup({
      create_autocmd = false, -- prevent barbecue from updating itself automatically
    })

    vim.api.nvim_create_autocmd({
      "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
