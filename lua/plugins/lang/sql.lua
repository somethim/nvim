-- vim-dadbod: SQL client + completion inside Neovim
-- :DB <connection-string> to connect, or set b:db / g:db
-- Connection string examples:
--   postgresql://user:pass@localhost/dbname
--   mysql://user:pass@localhost/dbname
--   sqlite:path/to/file.db
return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI" },
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-ui",
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
        init = function()
          vim.g.db_ui_use_nerd_fonts = 1
          vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
        end,
        keys = {
          { "<leader>Du", "<cmd>DBUIToggle<cr>",        desc = "DB: Toggle UI" },
          { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "DB: Add Connection" },
        },
      },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
  },

  -- Register dadbod as a blink.cmp source for SQL buffers (LazyVim uses blink.cmp)
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          sql = { "dadbod", "snippets", "buffer" },
          mysql = { "dadbod", "snippets", "buffer" },
          plsql = { "dadbod", "snippets", "buffer" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "sqlfmt", "sqlfluff" })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        sql = { "sqlfmt" },
      })
    end,
  },
}
