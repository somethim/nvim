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
  -- (LazyVim's nvim-lint core already wires the lint autocmd)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
        yaml       = { "yamllint" },
        ansible    = { "ansible_lint" },
        terraform  = { "tflint" },
      },
    },
  },

  -- Terraform keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {
          keys = {
            { "<leader>Tf", "<cmd>!terraform fmt %<cr>",    desc = "TF: Format File" },
            { "<leader>Ti", "<cmd>!terraform init<cr>",     desc = "TF: Init" },
            { "<leader>Tv", "<cmd>!terraform validate<cr>", desc = "TF: Validate" },
            { "<leader>Tp", "<cmd>!terraform plan<cr>",     desc = "TF: Plan" },
          },
        },
      },
    },
  },
}
