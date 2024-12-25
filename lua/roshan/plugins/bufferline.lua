return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>x", ":bdelete<CR>", opts)
        vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
        vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
        require("bufferline").setup {
          highlights = require("catppuccin.groups.integrations.bufferline").get()
        }
    end,
    opts = {
      options = {
        mode = "buffer",
        -- separator_style = "slant",
      },
    },
  }
  
