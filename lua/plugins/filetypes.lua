return {
  -- Extra filetype & language registrations

  -- Register MDX as a filetype
  vim.filetype.add({
    extension = {
      mdx = "mdx",
    },
  }),

  -- Use markdown parser for mdx in treesitter
  pcall(function()
    vim.treesitter.language.register("markdown", "mdx")
  end),
}
