return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "delve", "goimports", "golangci-lint" })
    end,
  },

  -- goimports runs first (adds/removes imports), gofmt normalises formatting
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        go = { "goimports", "gofmt" },
      })
    end,
  },

  -- gopls tuning on top of what LazyVim's go extra provides
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true, shadow = true },
              staticcheck = true,
              gofumpt = true,
              hints = {
                assignVariableTypes    = true,
                compositeLiteralFields = true,
                functionTypeParameters = true,
                parameterNames         = true,
                rangeVariableTypes     = true,
              },
            },
          },
          keys = {
            { "<leader>Gb", function() Snacks.terminal("go build ./...", { id = "go:build", cwd = vim.fn.getcwd() }) end, desc = "Go: Build" },
            { "<leader>Gr", function() Snacks.terminal("go run .",      { id = "go:run",   cwd = vim.fn.getcwd() }) end, desc = "Go: Run" },
            { "<leader>Gt", function() Snacks.terminal("go test ./...", { id = "go:test",  cwd = vim.fn.getcwd() }) end, desc = "Go: Test All" },
            { "<leader>Gi", function() vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } }) end, desc = "Go: Organize Imports" },
          },
        },
      },
    },
  },

  -- delve DAP — nvim-dap-go wraps delve with goroutine-aware UI
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap", "mason-org/mason.nvim" },
    config = function()
      local ok, registry = pcall(require, "mason-registry")
      local delve_path = (ok and registry.is_installed("delve"))
        and registry.get_package("delve"):get_install_path() .. "/bin/dlv"
        or "dlv"

      require("dap-go").setup({
        delve = { path = delve_path },
        dap_configurations = {
          {
            type = "go",
            name = "Debug file",
            request = "launch",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug package",
            request = "launch",
            program = "${workspaceFolder}",
          },
          {
            type = "go",
            name = "Attach to process",
            mode = "local",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },
        },
      })
    end,
    keys = {
      { "<leader>Gd", function() require("dap-go").debug_test() end, desc = "Go: Debug Test Under Cursor", ft = "go" },
      { "<leader>Gl", function() require("dap-go").debug_last() end, desc = "Go: Debug Last Test",         ft = "go" },
    },
  },
}
