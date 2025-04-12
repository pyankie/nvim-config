-- return {
--   {
--     "williamboman/mason.nvim",
--     opts = function(_, opts)
--       vim.list_extend(opts.ensure_installed, {
--         "shellcheck",
--         -- "emmet_ls",
--         "css-lsp",
--         "luacheck",
--         "cpptools",
--         "eslint-lsp",
--         "tailwindcss-language-server",
--         "typescript-language-server",
--       })
--     end,
--   },
-- }

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "shellcheck",
        "css-lsp",
        "luacheck",
        "cpptools",
        "eslint-lsp",
        "tailwindcss-language-server",
        "typescript-language-server",
        "clangd", -- Add this for C/C++ LSP
        "clang-format", -- Add this for formatting
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Add clangd configuration
        clangd = {
          capabilities = {
            offsetEncoding = "utf-8",
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          },
        },
      },
    },
  },
}
