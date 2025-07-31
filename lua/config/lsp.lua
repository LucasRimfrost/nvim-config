-- Global LSP configuration (applies to ALL servers)
vim.lsp.config("*", {
    root_markers = { ".git" }, -- Fallback root marker
})

-- Essential LspAttach autocmd
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(event)
        -- Helper function for easier keymap definition
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Basic LSP keymaps
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        -- Rename the variable under your cursor
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        -- Execute a code action
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        -- Find references for the word under your cursor
        map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
        -- Jump to the implementation of the word under your cursor
        map("gri", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
        -- Jump to the definition of the word under your cursor
        map("grd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
        -- Goto Declaration (e.g., header files in C)
        map("grD", require("fzf-lua").lsp_declarations, "[G]oto [D]eclaration")
        -- Fuzzy find all symbols in your current document
        map("gO", require("fzf-lua").lsp_document_symbols, "Open Document Symbols")
        -- Fuzzy find all symbols in your current workspace
        map("gW", require("fzf-lua").lsp_live_workspace_symbols, "Open Workspace Symbols")
        -- Jump to the type definition
        map("grt", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")
    end,
})

-- Set up transparent diagnostic highlights with better colors
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#d63031", bg = "NONE" }) -- Darker red
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#e67e22", bg = "NONE" }) -- Orange
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#3498db", bg = "NONE" }) -- Blue
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#27ae60", bg = "NONE" }) -- Green

-- Configure diagnostics (virtual_text is now opt-in)
vim.diagnostic.config({
    virtual_lines = false, -- Disable virtual lines (new feature)
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
    virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})

-- Enable LSP servers (configs loaded from lsp/ directory)
vim.lsp.enable({ "lua_ls", "clangd", "pyright", "tsserver", "texlab", "ltex" })
