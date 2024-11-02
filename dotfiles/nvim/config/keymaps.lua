-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "[<space>", "m`O<Esc>0D``", { desc = "Insert Line Above" })
vim.keymap.set("n", "]<space>", "m`o<Esc>0D``", { desc = "Insert Line Below" })
