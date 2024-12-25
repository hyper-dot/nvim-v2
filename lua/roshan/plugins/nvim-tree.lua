return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local function on_attach(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Use x for cut node
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut Node"))

			-- Use r for rename node
			vim.keymap.set("n", "r", api.fs.rename, opts("Rename Node"))

			-- Use a to create a new file or directory
			vim.keymap.set("n", "a", api.fs.create, opts("Create File/Directory"))

			-- Use y to yank node path to clipboard
			vim.keymap.set("n", "y", function()
				local node = api.tree.get_node_under_cursor()
				if node then
					vim.fn.setreg("+", node.absolute_path)
					print("Yanked " .. node.absolute_path .. " to clipboard")
				end
			end, opts("Yank Node Path"))

			-- Use d to delete node with confirmation
			vim.keymap.set("n", "d", function()
				local node = api.tree.get_node_under_cursor()
				if node then
					api.fs.remove()
				end
			end, opts("Delete Node"))

			-- Use p to paste node
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste Node"))

			-- Create menu function
			local function show_tree_menu()
				local selection = vim.ui.select(tree_actions, {
					prompt = "Choose action:",
					format_item = function(item)
						return item.name
					end,
				}, function(choice)
					if choice then
						choice.handler()
					end
				end)
			end

			-- Use h to close directory or go to parent directory
			vim.keymap.set("n", "h", function()
				api.node.navigate.parent_close()
			end, opts("Close Directory"))

			-- Use l to open file/directory
			vim.keymap.set("n", "l", function()
				local node = api.tree.get_node_under_cursor()
				if node.type == "directory" then
					api.node.open.edit()
				else
					api.node.open.edit()
				end
			end, opts("Open"))

			-- Add menu mapping (using 'm' key for menu)
			vim.keymap.set("n", "m", show_tree_menu, opts("Show Tree Menu"))
		end

		-- For Opening NvimTree
		vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { silent = true, noremap = true })
		require("nvim-tree").setup({
			on_attach = on_attach, -- Set the on_attach function
			experimental = {},
			auto_reload_on_write = false,
			disable_netrw = false,
			hijack_cursor = false,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = false,
			sort = {
				sorter = "name",
				folders_first = true,
				files_first = false,
			},
			root_dirs = {},
			prefer_startup_root = false,
			sync_root_with_cwd = true,
			reload_on_bufenter = false,
			respect_buf_cwd = false,
			select_prompts = false,
			view = {
				adaptive_size = false,
				centralize_selection = true,
				width = 30,
				cursorline = true,
				debounce_delay = 15,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 30,
						height = 30,
						row = 1,
						col = 1,
					},
				},
			},
			renderer = {
				add_trailing = false,
				group_empty = false,
				highlight_git = "name",
				highlight_opened_files = "none",
				root_folder_label = ":t",
				full_name = false,
				indent_width = 2,
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				symlink_destination = true,
				highlight_diagnostics = "none",
				highlight_modified = "none",
				highlight_bookmarks = "none",
				highlight_clipboard = "name",
				indent_markers = {
					enable = false,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					git_placement = "before",
					padding = " ",
					symlink_arrow = " ➛ ",
					modified_placement = "after",
					diagnostics_placement = "signcolumn",
					bookmarks_placement = "signcolumn",
					-- glyphs = {
					-- 	git = {
					-- 		unstaged = "✗",
					-- 		staged = "✓",
					-- 		unmerged = "",
					-- 		renamed = "➜",
					-- 		untracked = "♦",
					-- 		deleted = "",
					-- 		ignored = "◌",
					-- 	},
					-- },
				},
			},
			hijack_directories = {
				enable = false,
				auto_open = true,
			},
			update_focused_file = {
				enable = true,
				update_root = {
					enable = true,
					ignore_list = {},
				},
				exclude = false,
			},
			diagnostics = {
				show_on_dirs = false,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
			},
			filters = {
				enable = true,
				dotfiles = false,
				git_clean = false,
				git_ignored = false,
				no_bookmark = false,
				no_buffer = false,
				custom = { "node_modules", "\\.cache" },
				exclude = {},
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
				ignore_dirs = {},
			},
			git = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
				disable_for_dirs = {},
				timeout = 400,
				cygwin_support = false,
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				expand_all = {
					max_folder_discovery = 300,
					exclude = {},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "shadow",
						style = "minimal",
					},
				},
				open_file = {
					quit_on_open = false,
					eject = true,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			trash = {
				cmd = "gio trash",
			},
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
			notify = {
				threshold = vim.log.levels.INFO,
				absolute_path = true,
			},
			ui = {
				confirm = {
					remove = true,
					trash = true,
					default_yes = false,
				},
			},
			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			help = {
				sort_by = "key",
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
			system_open = {
				cmd = nil,
				args = {},
			},
		})
	end,
}
