-- neotest: run tests inline with pass/fail signs, jump to failures
-- Adapters cover all languages in this config that have test runners
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "marilari88/neotest-vitest",
      "olimorris/neotest-phpunit",
      "rouge8/neotest-rust",
    },
    keys = {
      { "<leader>nt", function() require("neotest").run.run() end,                        desc = "Test: Run Nearest" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "Test: Run File" },
      { "<leader>na", function() require("neotest").run.run(vim.fn.getcwd()) end,         desc = "Test: Run All" },
      { "<leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end,   desc = "Test: Debug Nearest" },
      { "<leader>ns", function() require("neotest").summary.toggle() end,                desc = "Test: Toggle Summary" },
      { "<leader>no", function() require("neotest").output_panel.toggle() end,           desc = "Test: Toggle Output" },
      { "]t",         function() require("neotest").jump.next({ status = "failed" }) end, desc = "Test: Next Failure" },
      { "[t",         function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Test: Prev Failure" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
          require("neotest-python")({ dap = { justMyCode = false } }),
          require("neotest-vitest"),
          require("neotest-phpunit"),
          require("neotest-rust"),
        },
        output = { open_on_run = false },
        status = { virtual_text = true },
      })
    end,
  },
}
