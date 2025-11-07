return {
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "osaka",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    -- install ayu theme
    "Shatur/neovim-ayu",
    name = "ayu", -- Optional, but good practice
    lazy = true,
    -- priority = 1000,
    opts = {
      mirage = true,
      overrides = {
        NormalFloat = { bg = "#0c0c0c" },
        FloatBorder = { bg = "#0c0c0c", fg = "#0c0c0c" },
      },
    },
    config = function(_, opts)
      require("ayu").setup(opts)
      vim.o.background = "mirage" -- Or "mirage", or "light"
      vim.cmd.colorscheme("ayu")
    end,
  },
}
