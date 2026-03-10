return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  enabled = true,
  opts = {
    map_cr = true, -- allow <CR> to break pairs and insert newline between them
    check_ts = true, -- use treesitter to avoid pairing in comments/strings
    enable_check_bracket_line = false,
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}
