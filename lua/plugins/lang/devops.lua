-- Extra tooling on top of LazyVim's terraform/ansible/docker extras
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Terraform
        "tflint",
        "terraform-ls",
        -- Ansible
        "ansible-language-server",
        "ansible-lint",
        -- Docker
        "hadolint", -- Dockerfile linter
        -- General IaC / config
        "yamllint",
        "prettier", -- formats YAML/JSON/etc via prettierd
      })
    end,
  },

  -- Linting for Dockerfile, Ansible, Terraform, YAML
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft or {}, {
        dockerfile = { "hadolint" },
        yaml       = { "yamllint" },
        ansible    = { "ansible_lint" },
        terraform  = { "tflint" },
      })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },

  -- Terraform keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          on_attach = function(_, bufnr)
            local map = function(keys, cmd, desc)
              vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
            end
            map("<leader>Tf", "<cmd>!terraform fmt %<cr>",       "TF: Format File")
            map("<leader>Ti", "<cmd>!terraform init<cr>",        "TF: Init")
            map("<leader>Tv", "<cmd>!terraform validate<cr>",    "TF: Validate")
            map("<leader>Tp", "<cmd>!terraform plan<cr>",        "TF: Plan")
          end,
        },
      },
    },
  },
}
