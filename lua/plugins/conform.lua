return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettier" },
            yaml = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            go = { "goimports", "gofumpt" },
            java = { "google-java-format" },
            tex = { "latexindent" },
            latex = { "latexindent" },
            bib = { "bibtex-tidy" },
        },
        -- Uncomment to enable format on save
        -- format_on_save = {
        --     timeout_ms = 500,
        --     lsp_format = "fallback",
        -- },
    },
}
