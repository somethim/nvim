return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- intelephense: PHP LSP with Laravel stubs support
      -- php-cs-fixer: formatter (PSR-12 / Laravel style)
      vim.list_extend(opts.ensure_installed, { "intelephense", "php-cs-fixer" })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
          on_attach = function(_, bufnr)
            local map = function(keys, cmd, desc)
              vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
            end
            map("<leader>La", function()
              vim.lsp.buf.code_action()
            end, "PHP: Code Actions")
          end,
        },
      },
    },
  },
}
