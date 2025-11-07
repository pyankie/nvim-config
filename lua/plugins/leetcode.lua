return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("leetcode").setup({
      lang = "typescript",
    })
  end,
}
