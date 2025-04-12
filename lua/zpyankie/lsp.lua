local M = {}

function M.toggleInlayHints()
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end

return M

-- local M = {}
--
-- function M.toggleInlayHints()
--   local is_enabled = vim.lsp.inlay_hint.is_enabled() or false -- Ensure it's a boolean
--   vim.lsp.inlay_hint.enable() -- Pass a proper boolean value
-- end
--
-- return M
