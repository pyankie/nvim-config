---@module 'config.lazy'
--- Lazy.nvim plugin manager configuration
--- Bootstraps and configures the plugin manager for optimal performance

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================
-- Automatically install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugin Specification
-- ============================================================================
require("lazy").setup({
  spec = {
    -- LazyVim base configuration
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "solarized-osaka", -- Default colorscheme
      },
    },

    -- Import LazyVim extra modules for enhanced functionality
    { import = "lazyvim.plugins.extras.linting.eslint" },       -- ESLint integration
    { import = "lazyvim.plugins.extras.coding.blink" },         -- Blink completion
    { import = "lazyvim.plugins.extras.formatting.prettier" },  -- Prettier formatting
    { import = "lazyvim.plugins.extras.lang.typescript" },      -- TypeScript support
    { import = "lazyvim.plugins.extras.lang.json" },            -- JSON support
    { import = "lazyvim.plugins.extras.lang.java" },            -- Java support
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- Color highlighting

    -- Import custom plugin configurations from lua/plugins/
    { import = "plugins" },
  },

  -- ============================================================================
  -- Plugin Loading Defaults
  -- ============================================================================
  defaults = {
    lazy = false,    -- Load plugins on startup (set true for lazy-loading by default)
    version = false, -- Use latest git commit (recommended for most plugins)
    -- version = "*", -- Uncomment to use latest stable versions with semver
  },

  -- ============================================================================
  -- Installation Settings
  -- ============================================================================
  install = {
    colorscheme = { "solarized-osaka", "habamax" }, -- Fallback colorschemes during install
  },

  -- ============================================================================
  -- Update Checker
  -- ============================================================================
  checker = {
    enabled = true, -- Check for plugin updates periodically
    notify = false, -- Don't notify about updates (check manually with :Lazy)
  },

  -- ============================================================================
  -- Performance Optimizations
  -- ============================================================================
  performance = {
    rtp = {
      -- Disable unused builtin plugins for faster startup
      disabled_plugins = {
        "gzip",      -- Gzip file support
        "tarPlugin", -- Tar archive support
        "tohtml",    -- Convert buffer to HTML
        "tutor",     -- Neovim tutor
        "zipPlugin", -- Zip archive support
        -- Keep these enabled for core functionality:
        -- "matchit",    -- Extended % matching
        -- "matchparen", -- Highlight matching parentheses
        -- "netrwPlugin", -- Network file explorer
      },
    },
  },
})
