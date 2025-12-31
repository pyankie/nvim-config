---@module 'plugins.copilot'
--- GitHub Copilot AI code completion
--- Provides intelligent code suggestions powered by GitHub Copilot
---
--- Keymaps (in insert mode):
--- - <C-s>: Accept suggestion
--- - <M-]>: Next suggestion
--- - <M-[>: Previous suggestion
--- - <C-]>: Dismiss suggestion

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      model = "gpt-5",
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-s>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
        copilot_node_command = "node", -- Adjust if Node.js is not in PATH
        filetypes = {
          ["*"] = true,
          dotenv = false,
          [".env"] = false,
          [".env.*"] = false,
          ["secrets"] = false,
          TelescopePrompt = false,
        },
        should_attach = function(_, bufname)
          if string.match(bufname, "env") then
            return false
          end
          return true
        end,
      })

      -- Integrate Copilot with blink.cmp
      local blink_cmp = require("blink.cmp")
      blink_cmp.setup({
        sources = {
          providers = {
            copilot = {
              name = "copilot",
              score_offset = 1,
              module = "blink-cmp-copilot",
              enabled = false,
              async = true,
              after = function(_, done)
                require("copilot.suggestion").fetch_suggestions(done)
              end,
            },
            -- Ensure other sources from completion.lua are included
            lsp = { name = "LSP", score_offset = 2 },
            path = { name = "Path", score_offset = 1 },
            buffer = { name = "Buffer" },
            snippets = {
              name = "Snippets",
              score_offset = -1,
              backend = "luasnip",
            },
          },
        },
        config = function()
          -- hide copilot on suggestion
          vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
              require("copilot.suggestion").dismiss()
              vim.b.copilot_suggestion_hidden = true
            end,
          })

          vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
              vim.b.copilot_suggestion_hidden = false
            end,
          })
          --
        end,
      })
    end,
  },
}
