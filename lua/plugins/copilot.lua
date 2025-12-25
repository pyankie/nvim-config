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
    opts = {
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
      copilot_node_command = "node",
      filetypes = {
        ["*"] = true,
        dotenv = false,
        [".env"] = false,
        ["secrets"] = false,
        TelescopePrompt = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        [".env*"] = false,
      },
      should_attach = function(_, bufname)
        -- Don't attach to files with 'env' in the name
        if string.match(bufname, "env") then
          return false
        end
        return true
      end,
    }
  },
}
