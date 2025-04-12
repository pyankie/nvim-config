return {
  "Pocco81/auto-save.nvim",
  enabled = false,
  config = function()
    require("auto-save").setup({
      execution_message = {
        message = "",
        dim = 0.18,
        cleaning_interval = 0,
      },
      trigger_events = { "InsertLeave", "TextChanged" },
      conditions = {
        exists = true,
        filename_is_not = {},
        filetype_is_not = { "*.js", "*.cpp" },
        modifiable = true,
      },
      write_all_buffers = false,
      debounce_delay = 200,
      callbacks = {
        before_saving = function()
          -- Temporarily disable undo recording
          vim.cmd("setlocal undolevels=-1")
        end,
        after_saving = function()
          -- Re-enable undo recording
          vim.cmd("setlocal undolevels=1000") -- Adjust `1000` as per your preferred undo level
        end,
      },
    })

    -- Automatically trigger BrowserSync on file save
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.html", "*.css", "*.js" },
      callback = function()
        vim.fn.jobstart("browser-sync reload")
      end,
    })
  end,
}
