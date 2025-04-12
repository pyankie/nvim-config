return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local status_ok, toggleterm = pcall(require, "toggleterm")
      if not status_ok then
        return
      end

      toggleterm.setup({
        size = 15,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Set terminal-specific keymaps using `vim.keymap.set`
      function _G.set_terminal_keymaps()
        local opts = { noremap = true, silent = true, buffer = 0 } -- `buffer = 0` applies only to the current terminal buffer
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      local Terminal = require("toggleterm.terminal").Terminal

      -- Custom terminals
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new({ cmd = "node", hidden = true })
      function _NODE_TOGGLE()
        node:toggle()
      end

      local python = Terminal:new({ cmd = "python3", hidden = true })
      function _PYTHON_TOGGLE()
        python:toggle()
      end

      -- Define terminals for different directions
      local horizontal_term = Terminal:new({ direction = "horizontal" })
      local vertical_term = Terminal:new({ direction = "vertical" })
      local float_term = Terminal:new({ direction = "float" })

      -- Keybindings
      vim.keymap.set("n", "<leader>th", function()
        horizontal_term:toggle()
      end, { desc = "Horizontal Terminal" })

      vim.keymap.set("n", "<leader>tv", function()
        vertical_term:toggle()
      end, { desc = "Vertical Terminal" })

      vim.keymap.set("n", "<leader>tf", function()
        float_term:toggle()
      end, { desc = "Floating Terminal" })

      vim.keymap.set("n", "<leader>tn", _NODE_TOGGLE, { desc = "Node.js Terminal" })
      vim.keymap.set("n", "<leader>tp", _PYTHON_TOGGLE, { desc = "Python Terminal" })
    end,
  },
}
