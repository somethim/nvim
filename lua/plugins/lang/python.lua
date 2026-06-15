return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "debugpy", "black", "mypy" })
    end,
  },

  -- black as formatter (overrides ruff_format from LazyVim python extra)
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        python = { "black" },
      })
    end,
  },

  -- mypy type-checking via nvim-lint
  -- global config lives at ~/.config/mypy/config (mypy reads it automatically)
  -- any local mypy.ini / pyproject.toml [mypy] / setup.cfg takes precedence
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "mypy" },
      },
    },
  },

  -- Python DAP via debugpy
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local ok, registry = pcall(require, "mason-registry")
      if not ok then return end
      require("dap-python").setup(
        registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      )
    end,
    keys = {
      { "<leader>Pt", function() require("dap-python").test_method() end,     desc = "Py: Debug Test Method", ft = "python" },
      { "<leader>PC", function() require("dap-python").test_class() end,      desc = "Py: Debug Test Class",  ft = "python" },
      { "<leader>Ps", function() require("dap-python").debug_selection() end, desc = "Py: Debug Selection",   mode = "v", ft = "python" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          keys = {
            { "<leader>Po", function() vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } }) end, desc = "Py: Organize Imports" },
            { "<leader>Pr", "<cmd>PyrightRestartServer<cr>", desc = "Py: Restart Pyright" },
          },
        },
      },
    },
  },
}
