---@module 'colorschemes'
--- Colorscheme configurations
--- All colorschemes are organized here for easy management and switching
---
--- Active colorscheme is set in lua/config/lazy.lua under LazyVim opts
--- To switch: :colorscheme <name>
---
--- Available themes:
--- - solarized-osaka (default): Modern Solarized variant with excellent contrast
--- - ayu: Clean and elegant theme with three variants (dark, mirage, light)
--- - night-owl: Dark theme optimized for night coding
--- - oh-lucy: Warm and cozy colorscheme
--- - horizon: Vibrant dark theme with vivid colors
--- - retro-theme: Nostalgic theme with retro aesthetics
--- - matrix: Matrix-inspired theme

return {
  -- Solarized Osaka - Default theme
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true, -- Enable transparent background
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Ayu - Clean and elegant
  {
    "Shatur/neovim-ayu",
    name = "ayu",
    lazy = true,
    opts = {
      mirage = true, -- Use mirage variant
      overrides = {
        -- Custom float window styling
        NormalFloat = { bg = "#0c0c0c" },
        FloatBorder = { bg = "#0c0c0c", fg = "#0c0c0c" },
      },
    },
  },

  -- Night Owl - For night owls
  {
    "oxfist/night-owl.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  -- Oh Lucy - Warm and cozy
  {
    "Yazeed1s/oh-lucy.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Horizon - Vibrant colors
  {
    "akinsho/horizon.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Retro Theme - Nostalgic vibes
  {
    "mistweaverco/retro-theme.nvim",
    lazy = true,
    opts = {
      italic_comments = true,
      disable_cache = false,
      hot_reload = false,
    },
  },

  -- Matrix Theme - Matrix-inspired
  {
    "iruzo/matrix-nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.matrix_theme_variant = "dark" -- or "light"
    end,
  },
}
