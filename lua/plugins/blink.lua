local icons = require("lib.icons")

return {
  "saghen/blink.cmp",
  dependencies = {
    -- {
    --   "L4MON4D3/LuaSnip",
    --   version = "v3.*",
    --   build = "make install_jsregexp",
    -- },
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "neovim/nvim-lspconfig",
    "onsails/lspkind.nvim",
  },

  event = "InsertEnter",
  opts = {
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        --"copilot"
      },
    },
    appearance = {
      highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "Nerd Font Mono",
      kind_icons = icons.kind,
    },

    completion = {

      menu = {
        draw = {
          padding = 1,
          gap = 1,
        },
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+
        winblend = 0,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        scrolloff = 2,
        scrollbar = true,
        direction_priority = { "s", "n" },

        auto_show = true,
        auto_show_delay_ms = 0,

        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        draw = function(opts)
          opts.default_implementation()
        end,
        window = {
          min_width = 10,
          max_width = 80,
          max_height = 20,
          border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+
          winblend = 4,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
          scrollbar = true,
          direction_priority = {
            menu_north = { "e", "w", "n", "s" },
            menu_south = { "e", "w", "s", "n" },
          },
        },
      },
    },

    signature = { enabled = true, window = { border = "rounded" } },
    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
  },
  -- config = function(_, opts)
  --   -- require("luasnip.loaders.from_vscode").lazy_load()
  --   require("blink").setup(opts)
  -- end,
}
