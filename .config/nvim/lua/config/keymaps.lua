-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- replace current word with Ctrl+c
map("n", "<C-c>", "<cmd>normal! ciw<cr>a", { desc = "Replace current word" })
map("n", "<leader>ww", "<cmd>:w<cr>", { desc = "Save file" })

vim.cmd([[
" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-n> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-n>'
smap <silent><expr> <C-n> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-n>'
imap <silent><expr> <C-p> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-p>'
smap <silent><expr> <C-p> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-p>'
]])

map("v", "<leader>js", ":w! ~/tmp/jira/issue-summary.txt<cr>", { desc = "Save Jira task summary" })
map("v", "<leader>jd", ":w! ~/tmp/jira/issue-description.md<cr>", { desc = "Save Jira task description" })
map(
  "v",
  "<leader>jc",
  ":w! ~/tmp/jira/convert-in.md | !jira-convert<cr>",
  { desc = "Convert to jira markup and put in clipboard" }
)
