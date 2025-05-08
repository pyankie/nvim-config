return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "cmake",
        "c",
        "bash",
        "javascript",
        "typescript",
        "cpp",
        "html",
        "css",
        "gitignore",
        "http",
        "java",
        "php",
        "rust",
        "sql",
        "lua",
        "printf",
        "go",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
