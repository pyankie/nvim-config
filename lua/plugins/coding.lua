---@module 'plugins.coding'
--- Coding enhancement tools
--- Plugins that improve the coding experience with smart renaming,
--- better text manipulation, and developer productivity features

return {
  -- Incremental rename with live preview
  -- Shows preview of all rename locations as you type
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename", -- Load only when IncRename command is used
    keys = {
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Incremental rename",
      },
    },
    opts = {
      cmd_name = "IncRename",     -- Command name
      preview_empty_name = false, -- Don't show preview for empty names
    },
  },
}
