-- The vim treesitter highlights query has an upstream bug (mixed node/string
-- list containing `unknown_command_name` that the parser rejects). Disable
-- highlights for the vim filetype until nvim-treesitter fixes it.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = { "vim" },
      },
    },
  },
}
