return {
  {
    "oxfist/night-owl.nvim",
    lazy = false, -- Ensure it loads during startup as the main colorscheme
    priority = 1000, -- Load before all other start plugins
    config = function()
      -- Load the colorscheme
    end,
  },
}
-- return {
--   {
--     "oxfist/night-owl.nvim",
--     lazy = false, -- Ensure it loads during startup as the main colorscheme
--     priority = 1000, -- Load before all other start plugins
--     config = function()
--       require("night-owl").setup({
--         styles = {
--           comments = "true", -- Disable italics for comments
--           keywords = "false", -- Disable italics for keywords
--           functions = "false", -- Disable italics for functions
--           strings = "false", -- Adjust as needed for other styles
--           variables = "false",
--         },
--       })
--       -- Load the colorscheme
--       -- vim.cmd("colorscheme night-owl")
--     end,
--   },
-- }
