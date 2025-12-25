---@module 'zpyankie.lsp'
--- Custom LSP utilities and helpers
--- Provides additional LSP functionality beyond default configuration

local M = {}

--- Toggle LSP inlay hints on/off for the current buffer
--- Inlay hints show additional type information inline in your code
--- Useful for TypeScript, Rust, and other strongly-typed languages
---@return nil
function M.toggleInlayHints()
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = 0 })

  -- Provide user feedback
  if is_enabled then
    vim.notify("Inlay hints disabled", vim.log.levels.INFO)
  else
    vim.notify("Inlay hints enabled", vim.log.levels.INFO)
  end
end

return M
