return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            menu = {
                border = "rounded", -- Add rounded borders
                winblend = 0,
                scrolloff = 1,
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon" },
                        { "kind" },
                    },
                },
            },
            ghost_text = {
                enabled = true,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,

                window = {
                    border = "rounded", -- Rounded borders for docs too
                    desired_min_width = 30,
                },
            },
        },

        signature = { enabled = true },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = {
            implementation = "prefer_rust_with_warning",
            -- Better sorting (this helps with relevance)
            sorts = {
                "score",
                "sort_text",
            },
        },
    },
    opts_extend = { "sources.default" },
}
