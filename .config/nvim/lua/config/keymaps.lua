-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local M = {}

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.base64(data)
  data = tostring(data)
  local bit = require("bit")
  local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  local b64, len = "", #data
  local rshift, lshift, bor = bit.rshift, bit.lshift, bit.bor

  for i = 1, len, 3 do
    local a, b, c = data:byte(i, i + 2)
    b = b or 0
    c = c or 0

    local buffer = bor(lshift(a, 16), lshift(b, 8), c)
    for j = 0, 3 do
      local index = rshift(buffer, (3 - j) * 6) % 64
      b64 = b64 .. b64chars:sub(index + 1, index + 1)
    end
  end

  local padding = (3 - len % 3) % 3
  b64 = b64:sub(1, -1 - padding) .. ("="):rep(padding)

  return b64
end

function M.set_user_var(key, value)
  io.write(string.format("\027]1337;SetUserVar=%s=%s\a", key, M.base64(value)))
end

M.set_user_var("IS_NVIM", true)

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

local gitlab = require("gitlab")
local gitlab_server = require("gitlab.server")
vim.keymap.set("n", "glr", gitlab.review)
vim.keymap.set("n", "gls", gitlab.summary)
vim.keymap.set("n", "glA", gitlab.approve)
vim.keymap.set("n", "glR", gitlab.revoke)
vim.keymap.set("n", "glc", gitlab.create_comment)
vim.keymap.set("v", "glc", gitlab.create_multiline_comment)
vim.keymap.set("v", "glC", gitlab.create_comment_suggestion)
vim.keymap.set("n", "glO", gitlab.create_mr)
vim.keymap.set("n", "glm", gitlab.move_to_discussion_tree_from_diagnostic)
vim.keymap.set("n", "gln", gitlab.create_note)
vim.keymap.set("n", "gld", gitlab.toggle_discussions)
vim.keymap.set("n", "glaa", gitlab.add_assignee)
vim.keymap.set("n", "glad", gitlab.delete_assignee)
vim.keymap.set("n", "glla", gitlab.add_label)
vim.keymap.set("n", "glld", gitlab.delete_label)
vim.keymap.set("n", "glra", gitlab.add_reviewer)
vim.keymap.set("n", "glrd", gitlab.delete_reviewer)
vim.keymap.set("n", "glp", gitlab.pipeline)
vim.keymap.set("n", "glo", gitlab.open_in_browser)
vim.keymap.set("n", "glM", gitlab.merge)
