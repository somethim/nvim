return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- bacon-ls: fast clippy diagnostics LSP. Its cargo backend runs cargo
      -- itself, so the standalone `bacon` binary is NOT required.
      vim.list_extend(opts.ensure_installed, { "codelldb", "bacon-ls" })
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
        -- rustaceanvim reads rust-analyzer settings from `default_settings`
        -- (its `settings` field is a function that loads/merges these). The
        -- LazyVim rust extra also writes here, so a force-merge lets ours win.
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              buildScripts = { enable = true },
            },
            -- Diagnostics are delegated to bacon-ls (see the nvim-lspconfig spec
            -- below). rust-analyzer must have BOTH its flycheck (checkOnSave) and
            -- its native diagnostics off, or they duplicate/fight bacon-ls.
            -- rust-analyzer still drives completion / hover / refactor / inlay hints.
            -- The clippy pedantic+nursery lints now live in bacon_ls cargo.extraArgs.
            -- boolean form, matching the rust extra's default so force-merge replaces it
            checkOnSave = false,
            diagnostics = { enable = false },
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
          -- Rust namespace lives under <leader>R (uppercase) to match the other
          -- languages (TS <leader>T, Python <leader>P, PHP <leader>L) and to avoid
          -- the lowercase <leader>r prefix tripping over the builtin `r` (replace).
          map("<leader>Rr", function() vim.cmd.RustLsp("runnables") end,           "Rust: Runnables")
          map("<leader>Rd", function() vim.cmd.RustLsp("debuggables") end,          "Rust: Debuggables")
          map("<leader>Rt", function() vim.cmd.RustLsp("testables") end,            "Rust: Testables")
          map("<leader>Re", function() vim.cmd.RustLsp("expandMacro") end,          "Rust: Expand Macro")
          map("<leader>Rc", function() vim.cmd.RustLsp("openCargo") end,            "Rust: Open Cargo.toml")
          map("<leader>Rp", function() vim.cmd.RustLsp("parentModule") end,         "Rust: Parent Module")
          map("<leader>Rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Rust: Hover Actions")
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

  -- bacon-ls: real-time clippy diagnostics as a Language Server.
  -- rust-analyzer's diagnostics/flycheck are disabled above; bacon-ls owns the
  -- red squiggles instead. Its `cargo` backend runs cargo itself (no bacon
  -- daemon, no .bacon-locations file, no .bacon.toml job), so the only required
  -- binary is `bacon-ls` (installed via mason). The pedantic+nursery lints
  -- requested via `cargo clippy -- -D clippy::pedantic -D clippy::nursery` live
  -- in cargo.extraArgs below. A per-crate Cargo.toml `[lints.clippy]` block
  -- still takes precedence over these flags, so projects can override.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = {
          enabled = true,
          init_options = {
            -- live diagnostics while typing, not just on save
            cargo = { updateOnInsert = true },
          },
          settings = {
            bacon_ls = {
              backend = "cargo",
              cargo = {
                command = "clippy",
                checkOnSave = true,
                updateOnInsertDebounceMillis = 500,
                -- appended verbatim after `cargo clippy`
                extraArgs = { "--all-targets", "--", "-D", "clippy::pedantic", "-D", "clippy::nursery" },
              },
            },
          },
        },
      },
    },
  },
}
