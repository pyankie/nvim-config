---@module 'config.autocmds'
--- Autocommands configuration
--- Extends LazyVim's default autocommands with custom behavior
--- Default LazyVim autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- ============================================================================
-- Concealing Configuration
-- ============================================================================
-- LazyVim sets conceallevel=3 by default, which hides markup in certain files
-- This can be confusing for JSON/JSONC files where you want to see quotes

-- Disable concealing in JSON files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.conceallevel = 0 -- Show all text as-is
  end,
  desc = "Disable concealing in JSON files",
})

-- ============================================================================
-- Additional Autocommands
-- ============================================================================
-- Add your custom autocommands below following this pattern:
--
-- vim.api.nvim_create_autocmd({ "Event" }, {
--   pattern = { "pattern" },
--   callback = function()
--     -- Your code here
--   end,
--   desc = "Description of what this does",
-- })

-- Example: Auto-save on focus lost (uncomment to enable)
-- vim.api.nvim_create_autocmd({ "FocusLost" }, {
--   pattern = "*",
--   callback = function()
--     vim.cmd("silent! wa") -- Save all buffers
--   end,
--   desc = "Auto-save all buffers on focus lost",
-- })

-- Example: Remove trailing whitespace on save (uncomment to enable)
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = "*",
--   callback = function()
--     local save_cursor = vim.fn.getpos(".")
--     vim.cmd([[%s/\s\+$//e]])
--     vim.fn.setpos(".", save_cursor)
--   end,
--   desc = "Remove trailing whitespace on save",
-- })
