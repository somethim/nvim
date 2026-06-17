-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-show the full diagnostic in a float when the cursor rests on a line.
-- Inline virtual text only shows the trimmed headline (see plugins/diagnostics.lua);
-- this surfaces the complete multi-line detail without pressing <leader>cd.
-- Fires after `updatetime` ms of no movement (LazyVim sets it to 200).
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("diagnostic_float_on_hold", { clear = true }),
  callback = function()
    -- don't stack a second float if one is already open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        return
      end
    end
    vim.diagnostic.open_float(nil, {
      scope = "line",
      focusable = false,
      close_events = { "CursorMoved", "InsertEnter", "BufLeave" },
      border = "rounded",
      source = "if_many",
    })
  end,
})
