return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettierd", "eslint_d" })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft or {}, {
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
      })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                returnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
          on_attach = function(_, bufnr)
            local map = function(keys, cmd, desc)
              vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
            end
            map("<leader>To", function()
              vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
            end, "TS: Organize Imports")
            map("<leader>Tr", function()
              vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused" } } })
            end, "TS: Remove Unused")
          end,
        },
      },
    },
  },
}
