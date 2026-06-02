-- GCC + clangd: clangd is the language server and works with any compiler.
-- It reads compile_commands.json — generate it with:
--   CMake:  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
--   Make:   bear -- make
-- GDB is the debugger for GCC-compiled binaries (GDB 17.2 native DAP).

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        c   = { "clang_format" },
        cpp = { "clang_format" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          on_attach = function(_, bufnr)
            local map = function(keys, cmd, desc)
              vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
            end
            map("<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", "C: Switch Header/Source")
            map("<leader>ci", "<cmd>ClangdSymbolInfo<cr>",          "C: Symbol Info")
            map("<leader>ct", "<cmd>ClangdTypeHierarchy<cr>",       "C: Type Hierarchy")
          end,
        },
      },
    },
  },

  -- GDB DAP (native mode, GDB 14+)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require("dap")

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      local gdb_config = {
        {
          name = "Launch (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Attach to process (GDB)",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      dap.configurations.c   = gdb_config
      dap.configurations.cpp = gdb_config
    end,
  },
}
