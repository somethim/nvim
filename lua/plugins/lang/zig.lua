return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "zls" })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        zig = { "zigfmt" },
      })
    end,
  },

  -- Zig LSP via zls (no LazyVim extra — configured manually)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {
          settings = {
            zls = {
              enable_inlay_hints = true,
              inlay_hints_show_builtin = true,
              include_at_in_builtins = false,
              warn_style = true,
            },
          },
          -- run build / test / run via terminal (zig has no DAP adapter yet)
          keys = {
            { "<leader>zb", function() Snacks.terminal("zig build",                        { id = "zig:build", cwd = vim.fn.getcwd() }) end, desc = "Zig: Build" },
            { "<leader>zt", function() Snacks.terminal("zig build test",                   { id = "zig:test",  cwd = vim.fn.getcwd() }) end, desc = "Zig: Test" },
            { "<leader>zr", function() Snacks.terminal("zig run " .. vim.fn.expand("%:p"), { id = "zig:run",   cwd = vim.fn.getcwd() }) end, desc = "Zig: Run File" },
            { "<leader>zf", function() Snacks.terminal("zig fmt " .. vim.fn.expand("%:p"), { id = "zig:fmt",   cwd = vim.fn.getcwd() }) end, desc = "Zig: Fmt File" },
          },
        },
      },
    },
  },
}
