return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
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
          ["*"] = true, -- Enable Copilot for all filetypes by default
          dotenv = false, -- Disable for .env files (if filetype is dotenv)
          [".env"] = false, -- Disable for files named .env (pattern-based)
          -- ["sh"] = false, -- .env is of an .sh extension file type; but this also disables for other bash script files.
          [".env.*"] = false, -- Disable for .env.local, .env.development, etc.
          ["secrets"] = false, -- Disable for files named secrets
        },
        should_attach = function(_, bufname)
          if string.match(bufname, "env") then
            return false
          end
          return true
        end,
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
