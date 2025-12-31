---@module 'plugins.lsp'
--- LSP (Language Server Protocol) configuration
--- Manages language servers, formatters, and linters
--- Optimized for low memory usage

return {
  -- Mason tool installer - optimized for performance
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "emmet-ls",
        "cpptools",
        "eslint_d", -- Fast ESLint daemon (replaces eslint-lsp)
        "vtsls", -- Optimized TypeScript server (replaces typescript-language-server)
        "rust-analyzer",
        "tailwindcss-language-server",
        "css-lsp",
        "clangd",
        "clang-format",
        "gopls",
        "pyright",
      })
    end,
  },

  -- Configure vtsls (memory-optimized TypeScript server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- Disable inlay hints to save memory
      servers = {
        -- Disable default TypeScript servers - we use vtsls instead
        tsserver = { enabled = false },
        ts_ls = { enabled = false },

        -- Use vtsls for TypeScript/JavaScript (much more memory efficient)
        vtsls = {
          enabled = true,
          single_file_support = false,
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "never" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
              -- Memory optimization settings
              tsserver = {
                maxTsServerMemory = 2048, -- Limit to 2GB per instance
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "never" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
            vtsls = {
              -- Enable takeover mode for better performance
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = false, -- Reduce CPU/memory
                },
              },
            },
          },
        },

        -- CSS Language Server
        cssls = {},

        -- Emmet for HTML/CSS abbreviations
        emmet_ls = {
          filetypes = {
            "html",
            "css",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
          },
          init_options = {
            html = { options = { ["bem.enabled"] = true } },
          },
        },

        -- Tailwind CSS
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },

        -- HTML Language Server
        html = {},

        -- YAML Language Server with memory optimizations
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              format = { enable = false }, -- Disable formatting to save memory
              validate = true,
              hover = true,
              completion = true,
            },
          },
        },

        -- Lua Language Server with memory optimizations
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                maxPreload = 2000, -- Limit workspace preload
                preloadFileSize = 1000, -- Skip large files
              },
              completion = {
                workspaceWord = false, -- Disable to save memory
                callSnippet = "Replace",
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false, -- Use stylua instead
              },
              hint = {
                enable = false, -- Disable hints to save memory
              },
            },
          },
        },
      },
    },
  },

  -- Use eslint_d for fast, memory-efficient linting
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.diagnostics.eslint_d)
      table.insert(opts.sources, nls.builtins.code_actions.eslint_d)
    end,
  },

  -- Global LSP settings for memory optimization
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Reduce logging overhead
      vim.lsp.set_log_level("warn")
    end,
  },
}
