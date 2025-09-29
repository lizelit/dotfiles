local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better up/down
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize window using <ctrl> arrow keys
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Buffers
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "[b", ":bprevious<CR>", opts)
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "<leader>bb", ":e #<CR>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>`", ":e #<CR>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

-- Clear search with <esc>
keymap("n", "<esc>", ":noh<CR><esc>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- New file
keymap("n", "<leader>fn", ":enew<CR>", { desc = "New File" })

-- Quit
keymap("n", "<leader>qq", ":qa<CR>", { desc = "Quit All" })

-- Windows
keymap("n", "<leader>ww", "<C-W>p", { desc = "Other Window" })
keymap("n", "<leader>wd", "<C-W>c", { desc = "Delete Window" })
keymap("n", "<leader>w-", ":split<CR>", { desc = "Split Window Below" })
keymap("n", "<leader>w|", ":vsplit<CR>", { desc = "Split Window Right" })
keymap("n", "<leader>-", ":split<CR>", { desc = "Split Window Below" })
keymap("n", "<leader>|", ":vsplit<CR>", { desc = "Split Window Right" })

-- Tabs
keymap("n", "<leader><tab>l", ":tablast<CR>", { desc = "Last Tab" })
keymap("n", "<leader><tab>f", ":tabfirst<CR>", { desc = "First Tab" })
keymap("n", "<leader><tab><tab>", ":tabnew<CR>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", ":tabnext<CR>", { desc = "Next Tab" })
keymap("n", "<leader><tab>[", ":tabprevious<CR>", { desc = "Previous Tab" })
keymap("n", "<leader><tab>d", ":tabclose<CR>", { desc = "Close Tab" })
