return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        filetype = {
          go = "go run $file",
          rust = "cargo run",
        },
      })
    end,
  },
}
