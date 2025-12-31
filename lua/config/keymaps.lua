---@module 'config.keymaps'
--- Custom keymaps configuration
--- Extends LazyVim's default keymaps with personal workflow optimizations
--- Default LazyVim keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
---
--- Keymaps follow these principles:
--- - Leader key (<Space>) for custom commands
--- - Consistent patterns across similar operations
--- - Vim-like mnemonics where possible
--- - No conflicts with essential Neovim defaults

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Register Operations (Clipboard Management)
-- ============================================================================
-- These keymaps prevent unwanted register pollution during common operations

-- Delete without affecting default register
keymap.set("n", "x", '"_x', opts) -- Delete char under cursor
keymap.set("n", "<Leader>d", '"_d', opts) -- Delete motion
keymap.set("n", "<Leader>D", '"_D', opts) -- Delete to end of line
keymap.set("v", "<Leader>d", '"_d', opts) -- Delete selection
keymap.set("v", "<Leader>D", '"_D', opts)

-- Change without affecting default register
keymap.set("n", "<Leader>c", '"_c', opts) -- Change motion
keymap.set("n", "<Leader>C", '"_C', opts) -- Change to end of line
keymap.set("v", "<Leader>c", '"_c', opts) -- Change selection
keymap.set("v", "<Leader>C", '"_C', opts)

-- Paste from yank register (register "0") instead of default
keymap.set("n", "<Leader>p", '"0p', opts) -- Paste after cursor
keymap.set("n", "<Leader>P", '"0P', opts) -- Paste before cursor
keymap.set("v", "<Leader>p", '"0p', opts) -- Paste in visual mode

-- ============================================================================
-- File Operations
-- ============================================================================

-- Save file quickly
keymap.set("n", "<Leader>w", ":w<CR>", { desc = "Save file" })

-- ============================================================================
-- Line Operations
-- ============================================================================

-- Insert new line without continuing comments
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts) -- Below current line
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts) -- Above current line

-- ============================================================================
-- Search & Highlights
-- ============================================================================

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- ============================================================================
-- Mode Switching
-- ============================================================================

-- Quick escape from insert mode
keymap.set("i", "jk", "<ESC>", opts)

-- ============================================================================
-- Clipboard Integration
-- ============================================================================

-- Paste from system clipboard in insert mode (middle mouse button)
keymap.set("i", "<MiddleMouse>", "<C-R>+", opts)

-- ============================================================================
-- Number Operations
-- ============================================================================

-- Increment/decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- ============================================================================
-- Word Operations
-- ============================================================================

-- Delete word backwards without affecting register
keymap.set("n", "dw", 'vb"_d', { desc = "Delete word backwards" })

-- ============================================================================
-- Text Selection
-- ============================================================================

-- Select all content in buffer
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- ============================================================================
-- Jumplist Navigation
-- ============================================================================

-- Fix Ctrl+M for jumplist (Ctrl+I alternative)
keymap.set("n", "<C-m>", "<C-i>", opts)

-- ============================================================================
-- Tab Management
-- ============================================================================

keymap.set("n", "te", ":tabedit", { desc = "New tab" }) -- Create new tab
keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Next tab
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Previous tab
keymap.set("n", "tq", "<cmd>tabclose<CR>", { desc = "Close tab" }) -- Close tab

-- ============================================================================
-- Window Split Management
-- ============================================================================

-- Create splits
keymap.set("n", "ss", ":split<Return>", { desc = "Split horizontal" })
keymap.set("n", "sv", ":vsplit<Return>", { desc = "Split vertical" })
keymap.set("n", "sq", ":quit<Return>", { desc = "Close split" })

-- Navigate between splits (h/j/k/l pattern)
keymap.set("n", "sh", "<C-w>h", { desc = "Go to left split" })
keymap.set("n", "sk", "<C-w>k", { desc = "Go to upper split" })
keymap.set("n", "sj", "<C-w>j", { desc = "Go to lower split" })
keymap.set("n", "sl", "<C-w>l", { desc = "Go to right split" })

-- ============================================================================
-- Line Movement (Alt + Arrows)
-- ============================================================================

-- Move lines up/down in normal mode
keymap.set("n", "<A-Up>", ":m .-2<CR>==", opts)
keymap.set("n", "<A-Down>", ":m .+1<CR>==", opts)

-- Move lines up/down in insert mode
keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)

-- Move selected lines up/down in visual mode
keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- ============================================================================
-- Window Resizing
-- ============================================================================

keymap.set("n", "<C-w><left>", "<C-w><", { desc = "Decrease width" })
keymap.set("n", "<C-w><right>", "<C-w>>", { desc = "Increase width" })
keymap.set("n", "<C-w><up>", "<C-w>+", { desc = "Increase height" })
keymap.set("n", "<C-w><down>", "<C-w>-", { desc = "Decrease height" })

-- ============================================================================
-- Diagnostics Navigation
-- ============================================================================

-- Jump to next diagnostic (error, warning, etc.)
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic" })

-- ============================================================================
-- Custom Functions
-- ============================================================================

-- Toggle Hex to HSL conversion (custom utility)
keymap.set("n", "<leader>r", function()
  require("zpyankie.hsl").replaceHexWithHSL()
end, { desc = "Replace Hex with HSL" })

-- Toggle LSP inlay hints
keymap.set("n", "<leader>i", function()
  require("zpyankie.lsp").toggleInlayHints()
end, { desc = "Toggle inlay hints" })

-- ============================================================================
-- Copilot Integration
-- ============================================================================

-- Accept Copilot suggestion with Tab
keymap.set("i", "<Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    return "<Tab>"
  end
end, { expr = true, desc = "Accept Copilot suggestion" })
