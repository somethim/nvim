-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.scrolloff     = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap          = false

-- Disable legacy providers that are not used (suppresses checkhealth warnings)
vim.g.loaded_perl_provider   = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_node_provider   = 0
vim.g.loaded_python3_provider = 0
