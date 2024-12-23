-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------------- General Keymaps -------------------

local opts = { silent = true }

-- use jj to exit insert mode
opts.desc = "Exit insert mode with jj"
keymap.set("i", "jj", "<ESC>", opts)

-- clear search highlights
opts.desc = "Clear search highlights"
keymap.set("n", "<leader>h", ":nohl<CR>", opts)

-- clear search highlights
opts.desc = "Save changes"
keymap.set("n", "<leader>w", ":w<CR>", opts)

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')
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

-- Bufferline
opts.desc = "Close current buffer"
keymap.set("n", "<leader>x", ":bdelete<CR>", opts)
opts.desc = "Move to Previous Buffer"
keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
opts.desc = "Move to Next Buffer"
keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)


-- NeoTree
opts.desc = "Open file explorer"
keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", opts)

-- GitSigns
opts.desc = "Togle current line blame"
keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", opts)
