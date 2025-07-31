return {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            transparent = true,
            overrides = function(colors)
                return {
                    SignColumn = { bg = "NONE" },
                    LineNr = { bg = "NONE" },
                    CursorLineNr = { bg = "NONE" },
                    SpecialKey = { fg = "#333333" }, -- Controls listchars color
                    Whitespace = { fg = "#333333" }, -- For newer Neovim versions

                    ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
                    ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
                    ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
                    ["@markup.raw.markdown_inline"] = { link = "String" }, --  `code`
                    ["@markup.list.markdown"] = { link = "Function" }, -- + list
                    ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
                    ["@markup.list.check.markdown"] = { link = "WarningMsg" }, -- [X] checked list item

                    -- Blink.cmp custom colors using your pywal theme
                    BlinkCmpMenu = { bg = "NONE", fg = "#aab0c3" },
                    BlinkCmpMenuBorder = { bg = "NONE", fg = "#AAB0C3" }, -- Golden border
                    BlinkCmpMenuSelection = { bg = "#AAB0C3", fg = "#0B172B" }, -- Orange selection
                    BlinkCmpLabel = { bg = "NONE", fg = "#aab0c3" }, -- Transparent item backgrounds
                    BlinkCmpKind = { bg = "NONE", fg = "#F7A748" }, -- Transparent kind backgrounds
                    BlinkCmpDoc = { bg = "NONE", fg = "#aab0c3" }, -- Transparent doc background
                    BlinkCmpDocBorder = { fg = "#F7A748" },

                    -- Signature help transparency
                    BlinkCmpSignatureHelp = { bg = "NONE", fg = "#aab0c3" }, -- Transparent signature window
                    BlinkCmpSignatureHelpBorder = { bg = "NONE", fg = "#AAB0C3" }, -- Transparent border with your golden color

                    -- ADD THESE LUALINE OVERRIDES:
                    StatusLine = { bg = "NONE" },
                    StatusLineNC = { bg = "NONE" },

                    -- OIL FLOATING WINDOW TRANSPARENCY:
                    NormalFloat = { bg = "NONE", fg = "#aab0c3" }, -- Main floating window background
                    FloatBorder = { bg = "NONE", fg = "#AAB0C3" }, -- Floating window border
                    FloatTitle = { bg = "NONE", fg = "#F7A748" }, -- Floating window title (if any)
                }
            end,
        })
        vim.cmd("colorscheme kanagawa")
    end,
}
