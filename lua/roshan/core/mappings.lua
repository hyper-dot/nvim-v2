-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------------- General Keymaps -------------------

local opts = { noremap = true, silent = true }

-- for switching between editor and file manager 
keymap.set('n', '<C-h>', '<C-w>h', opts )
keymap.set('n', '<C-l>', '<C-w>l', opts)

-- use jj to exit insert mode
opts.desc = "Exit insert mode with jj"
keymap.set("i", "jj", "<ESC>", opts)

-- clear search highlights
opts.desc = "Clear search highlights"
keymap.set("n", "<leader>h", ":nohl<CR>", opts)

-- clear search highlights
opts.desc = "Save changes"
keymap.set("n", "<leader>w", ":w<CR>", opts)

-- Blackhole
keymap.set("n", "x", '"_x')
keymap.set("n", "c", '"_c')

opts.desc = "Quit Neovim"
keymap.set("n", "<leader>q", ":q<CR>", opts)

-- LazyGit
opts.desc = "LazyGit"
keymap.set("n", "<leader>gg", ":LazyGit <CR>", opts) -- increment

-- increment/decrement numbers
opts.desc = "Increment number"
keymap.set("n", "<leader>+", "<C-a>", opts) -- increment
opts.desc = "Decrement number"
keymap.set("n", "<leader>-", "<C-x>", opts) -- decrement


-- GitSigns
opts.desc = "Togle current line blame"
keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", opts)
