-- VimTeX Configuration for Academic Writing
-- Place this in ~/.config/nvim/lua/plugins/vimtex.lua (if using lazy.nvim)
-- Or in ~/.config/nvim/after/plugin/vimtex.lua

-- Additional keymaps (optional - add these if you want custom mappings)
-- Place in your main keymaps configuration or here
local function setup_vimtex_keymaps()
    -- Compilation
    vim.keymap.set("n", "<localleader>ll", "<cmd>VimtexCompile<cr>", { desc = "Compile LaTeX" })
    vim.keymap.set("n", "<localleader>lk", "<cmd>VimtexStop<cr>", { desc = "Stop compilation" })
    vim.keymap.set("n", "<localleader>lK", "<cmd>VimtexStopAll<cr>", { desc = "Stop all compilation" })
    vim.keymap.set("n", "<localleader>le", "<cmd>VimtexErrors<cr>", { desc = "Show LaTeX errors" })
    vim.keymap.set("n", "<localleader>lo", "<cmd>VimtexCompileOutput<cr>", { desc = "Show compile output" })
    vim.keymap.set("n", "<localleader>lg", "<cmd>VimtexStatus<cr>", { desc = "Show LaTeX status" })
    vim.keymap.set("n", "<localleader>lG", "<cmd>VimtexStatusAll<cr>", { desc = "Show all LaTeX status" })
    vim.keymap.set("n", "<localleader>lc", "<cmd>VimtexClean<cr>", { desc = "Clean auxiliary files" })
    vim.keymap.set("n", "<localleader>lC", "<cmd>VimtexClean!<cr>", { desc = "Clean all files" })

    -- Viewing
    vim.keymap.set("n", "<localleader>lv", "<cmd>VimtexView<cr>", { desc = "View PDF" })
    vim.keymap.set("n", "<localleader>lr", "<cmd>VimtexReload<cr>", { desc = "Reload VimTeX" })
    vim.keymap.set("n", "<localleader>lR", "<cmd>VimtexReloadState<cr>", { desc = "Reload VimTeX state" })

    -- Table of contents and navigation
    vim.keymap.set("n", "<localleader>lt", "<cmd>VimtexTocOpen<cr>", { desc = "Open table of contents" })
    vim.keymap.set("n", "<localleader>lT", "<cmd>VimtexTocToggle<cr>", { desc = "Toggle table of contents" })

    -- Documentation
    vim.keymap.set("n", "<localleader>li", "<cmd>VimtexInfo<cr>", { desc = "Show VimTeX info" })
    vim.keymap.set("n", "<localleader>lI", "<cmd>VimtexInfoFull<cr>", { desc = "Show full VimTeX info" })

    -- Word count
    vim.keymap.set("n", "<localleader>lw", "<cmd>VimtexCountWords<cr>", { desc = "Count words" })
    vim.keymap.set("n", "<localleader>lW", "<cmd>VimtexCountLetters<cr>", { desc = "Count letters" })
end

-- Auto-run keymap setup when VimTeX loads
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventInitPost",
    callback = setup_vimtex_keymaps,
    desc = "Setup VimTeX keymaps after initialization",
})

return {
    "lervag/vimtex",
    lazy = false, -- Don't lazy load VimTeX
    init = function()
        -- PDF Viewer Configuration
        vim.g.vimtex_view_method = "zathura"

        -- Compiler Configuration
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "build", -- Put auxiliary files in build/ directory
            out_dir = "build", -- Put output files in build/ directory
            callback = 1, -- Enable callbacks for better error handling
            continuous = 1, -- Enable continuous compilation
            executable = "latexmk",
            options = {
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-shell-escape", -- Needed for minted package
            },
        }

        -- Quickfix window behavior
        vim.g.vimtex_quickfix_mode = 0 -- Don't auto-open quickfix on warnings
        vim.g.vimtex_quickfix_open_on_warning = 0

        -- Completion settings
        vim.g.vimtex_complete_enabled = 1
        vim.g.vimtex_complete_close_braces = 1

        -- Table of contents configuration
        vim.g.vimtex_toc_config = {
            name = "TOC",
            layers = { "content", "todo", "include" },
            split_width = 30,
            todo_sorted = 0,
            show_help = 1,
            show_numbers = 1,
        }

        -- Syntax highlighting improvements
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_syntax_conceal = {
            accents = 1,
            ligatures = 1,
            cites = 1,
            fancy = 1,
            spacing = 1,
            greek = 1,
            math_bounds = 1,
            math_delimiters = 1,
            math_fracs = 1,
            math_super_sub = 1,
            math_symbols = 1,
            sections = 0, -- Don't conceal section titles
            styles = 1,
        }

        -- Disable some default mappings if you prefer custom ones
        vim.g.vimtex_mappings_enabled = 1
        vim.g.vimtex_imaps_enabled = 1 -- Enable insert mode mappings

        -- Folding configuration (disabled by default)
        vim.g.vimtex_fold_enabled = 0 -- Set to 1 if you want folding

        -- Format configuration (disabled by default)
        vim.g.vimtex_format_enabled = 0 -- Set to 1 if you want auto-formatting

        -- Error handling
        vim.g.vimtex_log_ignore = {
            "Underfull",
            "Overfull",
            "specifier changed to",
            "Token not allowed in a PDF string",
        }

        -- Context menu configuration
        vim.g.vimtex_context_pdf_viewer = "zathura"

        -- Multi-file project support
        vim.g.vimtex_subfile_start_local = 1

        -- Bibliography completion
        vim.g.vimtex_parser_bib_backend = "bibtex" -- or "biblatex"

        -- Disable some features you might not need
        vim.g.vimtex_doc_enabled = 1
        vim.g.vimtex_motion_enabled = 1
        vim.g.vimtex_textidote_executable = "textidote" -- Grammar checker (if installed)
    end,
}
