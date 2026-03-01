-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy relative path:line to clipboard (for gemini-cli context)
vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand('%:.')
  local line = vim.fn.line('.')
  local result = path .. ':' .. line
  vim.fn.setreg('+', result)
  vim.api.nvim_echo({{ 'Copied: ' .. result, 'None' }}, false, {})
end, { desc = 'Copy file:line to clipboard' })
