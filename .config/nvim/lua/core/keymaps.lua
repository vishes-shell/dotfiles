-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Leader is space
map("", "<space>", "<nop>")

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Write
map("n", "W", "<cmd>w<cr>")
map("n", "wq", "<cmd>wq<cr>")
-- Close
map("n", "qq", "<cmd>q<cr>")
map("n", "QA", "<cmd>qa!<cr>")
-- Refresh
map("n", "E", "<cmd>e!<cr>")

-- Clear search highlighting with <leader> and c
map("n", "<leader><cr>", "<cmd>nohl<cr>")

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Copy to clipboard
map("v", "<leader>y", "\"+y")
map("n", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+yg")

-- Paste from clipboard
map("n", "<leader>p", "\"+p")
map("n", "<leader>P", "\"+P")
map("v", "<leader>p", "\"+p")
map("v", "<leader>P", "\"+P")

-- Small jumps
map("n", "<C-u>", "kkkkkkkkkkkkkkkkkkkkk")
map("n", "<C-d>", "jjjjjjjjjjjjjjjjjjjjj")

-- Global mark I for last edit
vim.cmd [[autocmd InsertLeave * execute 'normal! mI']]

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Format
map("v", "f", "<cmd>lua vim.lsp.buf.range_formatting()<cr>")

-- Center
map("n", "<c-b>",
    "<cmd>center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>YppVr#kk.<cr>")

-- Telescope
map("n", "<leader>bf", "<cmd>Telescope buffers<cr>")
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>s", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>c", "<cmd>Telescope git_status<cr>")
map("n", "F", "<cmd>Telescope grep_string<cr>")
map("n", "<leader>qf", "<cmd>Telescope quickfix<cr>")
map("n", "<leader>bt", "<cmd>Telescope current_buffer_tags<cr>")
map("n", "<leader>t", "<cmd>Telescope tags<cr>")
map("n", "<leader>l", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
map("n", "<leader><leader>", "<cmd>Telescope<cr>")
map("n", "-", "<cmd>Telescope file_browser path=%:p:h<cr>")

-- LSP Saga
local action = require("lspsaga.codeaction")

map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

vim.keymap.set("n", "<leader>ca", action.code_action, { silent = true })
vim.keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end, { silent = true })

map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
vim.keymap.set("n", "<C-f>", function() action.smart_scroll_with_saga(1) end,
               { silent = true })
vim.keymap.set("n", "<C-b>", function() action.smart_scroll_with_saga(-1) end,
               { silent = true })

map("n", "gs", "<cmd>Lspsaga signature_help<cr>")

map("n", "gr", "<cmd>Lspsaga rename<cr>")

map("n", "gd", "<cmd>Lspsaga preview_definition<cr>")

map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<cr>")
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<cr>")
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>")
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>")

map("n", "<leader>a", "<cmd>LSoutlineToggle<cr>")

vim.keymap
    .set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", "<cmd>Lspsaga open_floaterm lazygit<CR>",
               { silent = true })
vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
               { silent = true })

-- Test
map("n", "tn", "<cmd>TestNearest<cr>")
map("n", "tl", "<cmd>TestLast<cr>")
map("n", "tf", "<cmd>TestFile<cr>")
map("n", "ts", "<cmd>TestSuite<cr>")
map("n", "tv", "<cmd>TestVisit<cr>")

vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>",
               { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>",
               { noremap = true, silent = true })
