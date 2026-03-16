-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear search highlight
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Quick line navigation
vim.keymap.set("n", "gh", "^", { silent = true })
vim.keymap.set("n", "gl", "$", { silent = true })
vim.keymap.set("v", "gh", "^", { silent = true })
vim.keymap.set("v", "gl", "$", { silent = true })

-- Don't yank on delete char
vim.keymap.set("n", "x", '"_x', { silent = true })
vim.keymap.set("n", "X", '"_X', { silent = true })
vim.keymap.set("v", "x", '"_x', { silent = true })
vim.keymap.set("v", "X", '"_X', { silent = true })

-- Don't yank on visual paste
vim.keymap.set("v", "p", '"_dP', { silent = true })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>t+", "<cmd>tabmove+<CR>", { desc = "Move tab to the right" })
vim.keymap.set("n", "<leader>t-", "<cmd>tabmove-<CR>", { desc = "Move tab to the left" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | terminal<CR>", { desc = "Open new terminal tab" })

-- Format buffer
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Git management
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
vim.keymap.set("n", "<leader>ld", "<cmd>CodeDiff<CR>", { desc = "Open CodeDiff" })
vim.keymap.set("n", "<leader>lb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle current line blame" })

-- Search
vim.keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>sg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>sb", function()
	require("telescope.builtin").buffers()
end, { desc = "Search buffers" })
vim.keymap.set("n", "<leader><leader>", function()
	require("telescope.builtin").buffers()
end, { desc = "Search buffers" })

-- File explorer
vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>es", function()
	require("nvim-tree.api").tree.toggle({
		focus = false,
	})
end, { desc = "Open file tree" })

-- Diagnostic keymap
vim.keymap.set("n", "gn", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "gN", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })
