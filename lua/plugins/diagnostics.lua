-- Tame inline diagnostic virtual text.
--
-- bacon-ls / rustc (and some other servers) put the FULL rendered diagnostic
-- into the message: headline + the source snippet + the `^^^^` underline, all
-- separated by newlines. As inline virtual text those newlines collapse into
-- one giant unreadable line stretched across the screen.
--
-- Show only the first line (the headline, e.g. "mismatched types"), truncated.
-- The complete multi-line detail stays one keystroke away in the float:
--   <leader>cd  -> line diagnostics float
--   ]d / [d     -> jump to next/prev diagnostic (also opens the float)
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {
          format = function(diagnostic)
            local headline = vim.split(diagnostic.message, "\n", { plain = true })[1] or diagnostic.message
            local max = 80
            if #headline > max then
              headline = headline:sub(1, max - 1) .. "…"
            end
            return headline
          end,
        },
      },
    },
  },
}
