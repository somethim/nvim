return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "codelldb" })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        rust = { "rustfmt" },
      })
      -- conform's builtin rustfmt defaults to edition 2015, which fails to parse
      -- modern syntax (async, etc.) and silently aborts formatting. Pin the edition.
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        rustfmt = {
          prepend_args = { "--edition=2021" },
        },
      })
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      local ok, registry = pcall(require, "mason-registry")
      if ok and registry.is_installed("codelldb") then
        local ext = registry.get_package("codelldb"):get_install_path() .. "/extension/"
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(
            ext .. "adapter/codelldb",
            ext .. "lldb/lib/liblldb.so"
          ),
        }
      end

      opts.server = vim.tbl_deep_extend("force", opts.server or {}, {
        cmd = (vim.fn.exepath("rust-analyzer") ~= "" and { vim.fn.exepath("rust-analyzer") }) or nil,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              buildScripts = { enable = true },
            },
            checkOnSave = {
              command = "clippy",
              -- run pedantic + nursery lints on top of the defaults
              extraArgs = { "--", "-W", "clippy::pedantic" },
            },
            diagnostics = {
              experimental = { enable = true },
            },
            inlayHints = {
              bindingModeHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              parameterHints = { enable = true },
            },
          },
        },
        on_attach = function(_, bufnr)
          local map = function(keys, cmd, desc)
            vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
          end
          map("<leader>rr", function() vim.cmd.RustLsp("runnables") end,           "Rust: Runnables")
          map("<leader>rd", function() vim.cmd.RustLsp("debuggables") end,          "Rust: Debuggables")
          map("<leader>rt", function() vim.cmd.RustLsp("testables") end,            "Rust: Testables")
          map("<leader>re", function() vim.cmd.RustLsp("expandMacro") end,          "Rust: Expand Macro")
          map("<leader>rc", function() vim.cmd.RustLsp("openCargo") end,            "Rust: Open Cargo.toml")
          map("<leader>rp", function() vim.cmd.RustLsp("parentModule") end,         "Rust: Parent Module")
          map("<leader>rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Rust: Hover Actions")
          map("K",          function() vim.cmd.RustLsp({ "hover", "range" }) end,   "Rust: Hover Docs")
        end,
      })

      return opts
    end,
  },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {},
  },
}
