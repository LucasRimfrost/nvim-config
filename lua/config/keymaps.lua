local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-------------------
-- Basic Remaps --
-------------------
-- Open Oil
map("n", "-", "<cmd>Oil --float<CR>", vim.tbl_extend("force", opts, { desc = "[-] Open Parent Directory in Oil" }))

-- Disable spacebar's default behavior (only silent, no noremap)
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "[Space] Disable Spacebar" })

-- Delete single character without copying into register
map("n", "x", '"_x', vim.tbl_extend("force", opts, { desc = "[x] Delete Without Register" }))

-- Keep cursor centered when navigating search results
map("n", "n", "nzzzv", vim.tbl_extend("force", opts, { desc = "[n] Next Search (Centered)" }))
map("n", "N", "Nzzzv", vim.tbl_extend("force", opts, { desc = "[N] Previous Search (Centered)" }))

----------------------
-- Copy & Paste --
----------------------
-- Keep last yanked item when pasting in visual mode
map("v", "p", '"_dP', vim.tbl_extend("force", opts, { desc = "[p] Paste Keep Yanked" }))

-- Copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], vim.tbl_extend("force", opts, { desc = "[y] Copy to Clipboard" }))
map("n", "<leader>Y", [["+Y]], vim.tbl_extend("force", opts, { desc = "[Y] Copy Line to Clipboard" }))

----------------------
-- Indentation --
----------------------
-- Stay in visual mode while indenting
map("v", "<", "<gv", vim.tbl_extend("force", opts, { desc = "[<] Indent Left (Stay Visual)" }))
map("v", ">", ">gv", vim.tbl_extend("force", opts, { desc = "[>] Indent Right (Stay Visual)" }))

----------------------
-- Moving Lines --
----------------------
-- Move selected lines up and down
-- map("v", "J", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "[J] Move Lines Down" }))
-- map("v", "K", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "[K] Move Lines Up" }))

-- Try this version (without the =gv auto-indent):
map("v", "J", ":m '>+1<CR>gv", opts)
map("v", "K", ":m '<-2<CR>gv", opts)

----------------------
-- Navigation --
----------------------
-- Navigate through quickfix list
map("n", "<C-k>", "<cmd>cnext<CR>zz", vim.tbl_extend("force", opts, { desc = "[Ctrl-k] Next Quickfix Item" }))
map("n", "<C-j>", "<cmd>cprev<CR>zz", vim.tbl_extend("force", opts, { desc = "[Ctrl+j] Prev Quickfix Item" }))

-- Exit insert mode (no noremap or silent needed)
map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

map("n", ".", "<Nop>", opts)

map("n", "gl", function()
    vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

map("n", "<leader>cf", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "[C]ode [F]ormat" })

----------------------
-- File Operations --
----------------------

-- Make current file executable
map("n", "<leader>x", function()
    vim.cmd("!chmod +x %")
    vim.notify("Made file executable", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Make file executable" })
