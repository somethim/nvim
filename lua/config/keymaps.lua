-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- JetBrains-style "Alt+Enter": one universal key that opens the context-action
-- menu for whatever is under the cursor -- quick-fixes, imports, refactors,
-- intentions. "Show me what I can do here" is just an LSP code action, so this
-- works for every language with an LSP (rust-analyzer/clippy, vtsls, intelephense,
-- pyright, ...) with zero per-language setup. It is a global, non-buffer-local
-- map, so it never falls through to the builtin r/R (replace).
-- Works in normal (current line), visual (selection) and insert mode.
vim.keymap.set({ "n", "x", "i" }, "<M-CR>", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Action / Intentions (Alt+Enter)" })

-- Leader fallback for terminals that swallow Alt+Enter: auto-applies the single
-- obvious quick-fix for the diagnostic under the cursor (chooser if several).
vim.keymap.set({ "n", "x" }, "<leader>cq", function()
  vim.lsp.buf.code_action({ apply = true, context = { only = { "quickfix" } } })
end, { desc = "Quick Fix (cursor)" })
