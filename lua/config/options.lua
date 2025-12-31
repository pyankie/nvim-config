---@module 'config.options'
--- Neovim global options configuration
--- These settings configure the editor behavior, appearance, and defaults
--- Inspired by Takuya Matsuyama's setup with personal customizations

-- ============================================================================
-- Leader Key
-- ============================================================================
-- Set leader key to space for easy access to custom commands
vim.g.mapleader = " "

-- ============================================================================
-- Encoding
-- ============================================================================
vim.opt.encoding = "utf-8" -- Internal character encoding
vim.opt.fileencoding = "utf-8" -- File character encoding

-- ============================================================================
-- Line Numbers
-- ============================================================================
vim.opt.number = true -- Show absolute line numbers

-- ============================================================================
-- LSP Configuration
-- ============================================================================
-- Reduce log noise by setting log level to WARN
-- Change to "DEBUG" or "INFO" for troubleshooting
vim.lsp.set_log_level("WARN")

-- ============================================================================
-- Undo Configuration
-- ============================================================================
-- Persistent undo - survives Neovim restarts
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- ============================================================================
-- Editor Behavior
-- ============================================================================
vim.opt.title = true -- Set terminal title to filename
vim.opt.autoindent = true -- Copy indent from current line when starting new line
vim.opt.smartindent = true -- Smart autoindenting on new lines
vim.opt.hlsearch = true -- Highlight search results
vim.opt.backup = false -- Disable backup file creation
vim.opt.showcmd = true -- Show partial commands in status line
vim.opt.cmdheight = 1 -- Height of command line (0 for minimal)
vim.opt.laststatus = 3 -- Global statusline
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.scrolloff = 10 -- Minimum lines to keep above/below cursor
vim.opt.shell = "zsh" -- Use zsh as shell
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" } -- Skip backup for temp files
vim.opt.inccommand = "split" -- Live preview of substitute command
vim.opt.ignorecase = true -- Case insensitive search...
vim.opt.smartcase = true -- ...unless capital letters are used (implied, should be added)
vim.opt.smarttab = true -- Tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
vim.opt.breakindent = true -- Wrapped lines continue visually indented
vim.opt.shiftwidth = 2 -- Size of indent (spaces)
vim.opt.tabstop = 2 -- Number of spaces per tab
vim.opt.wrap = false -- Disable line wrapping
vim.opt.backspace = { "start", "eol", "indent" } -- Allow backspace over everything

-- ============================================================================
-- File Navigation
-- ============================================================================
vim.opt.path:append({ "**" }) -- Search in subdirectories
vim.opt.wildignore:append({ "*/node_modules/*" }) -- Ignore node_modules in searches

-- ============================================================================
-- Window Splits
-- ============================================================================
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitkeep = "cursor" -- Keep cursor position when splitting

-- ============================================================================
-- Mouse
-- ============================================================================
vim.opt.mouse = "" -- Disable mouse (forces keyboard usage for better workflow)

-- ============================================================================
-- Terminal Settings
-- ============================================================================
-- Enable undercurl support in terminal
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- ============================================================================
-- Format Options
-- ============================================================================
-- Add asterisks in block comments automatically
vim.opt.formatoptions:append({ "r" })

-- ============================================================================
-- Filetype Associations
-- ============================================================================
-- Register custom filetypes
vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- ============================================================================
-- Neovim 0.8+ Features
-- ============================================================================
-- Hide command line when not in use (cleaner UI)
if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end
