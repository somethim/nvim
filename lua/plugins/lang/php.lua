return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- intelephense: PHP LSP with Laravel stubs support
      -- pint: Laravel's opinionated code style fixer (built on php-cs-fixer).
      --       Installed globally as a fallback; a project's vendor/bin/pint is
      --       preferred automatically when present.
      vim.list_extend(opts.ensure_installed, { "intelephense", "pint" })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        php = { "pint" },
        blade = { "blade-formatter" },
      })
      -- Pint uses the Laravel preset by default and automatically picks up a
      -- pint.json from the project root when one exists. Run it from the
      -- composer/pint root so the project-local pint.json and vendor/bin/pint
      -- resolve correctly (falls back to the global pint + Laravel preset).
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        pint = {
          cwd = require("conform.util").root_file({ "composer.json", "pint.json" }),
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- The LazyVim php extra also starts phpactor, which would attach to PHP
        -- buffers alongside intelephense and double up diagnostics. intelephense
        -- has the stricter analysis (undefined symbols, type checks, unused code,
        -- Laravel stubs), so keep it and turn phpactor off.
        phpactor = { enabled = false },
        intelephense = {
          settings = {
            intelephense = {
              stubs = {
                "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba",
                "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "gettext",
                "hash", "iconv", "imap", "intl", "json", "ldap", "libxml",
                "mbstring", "mcrypt", "memcache", "memcached", "mhash", "mysql",
                "mysqli", "openssl", "pcntl", "pcre", "PDO", "pdo_mysql",
                "Phar", "readline", "redis", "Reflection", "regex", "session",
                "SimpleXML", "soap", "sockets", "sodium", "SPL", "sqlite3",
                "standard", "tokenizer", "xml", "xmlreader", "xmlwriter",
                "zip", "zlib",
                -- Laravel stubs
                "wordpress", "phpunit", "laravel",
              },
              files = { maxSize = 5000000 },
            },
          },
          keys = {
            { "<leader>La", function() vim.lsp.buf.code_action() end, desc = "PHP: Code Actions" },
          },
        },
      },
    },
  },
}
