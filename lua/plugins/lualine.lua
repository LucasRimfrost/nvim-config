-- Pywal colors matching tmux theme
local colors = {
    bg = "none", -- Transparent background
    fg = "#aab0c3", -- Foreground
    accent1 = "#E56537", -- Orange - primary accent
    accent2 = "#F49E51", -- Orange-yellow - secondary accent
    accent3 = "#A23B30", -- Dark red - warnings/errors
    accent4 = "#DB694C", -- Red-orange - active elements
    muted = "#767b88", -- Muted gray - inactive elements
    dark_bg = "#0B172B", -- Dark background for contrast
}

-- At which column count start to make the elements smaller or hide certain elements?
local lualine_trunc_margin = 80

local function truncateCondition()
    return vim.o.columns >= lualine_trunc_margin
end

-- Used for shortening Mode in smaller terminals
local mode_map = {
    ["NORMAL"] = "N",
    ["INSERT"] = "I",
    ["VISUAL"] = "V",
    ["V-LINE"] = "VL",
    ["V-BLOCK"] = "VB",
    ["COMMAND"] = "C",
    ["TERMINAL"] = "T",
    ["REPLACE"] = "R",
}

local function formatMode(str)
    if vim.o.columns < lualine_trunc_margin then
        return mode_map[str] or str
    end
    return str
end

local function getColumnPosition()
    local col = "%v"
    local max_col = "%{virtcol('$')-1}"
    if not truncateCondition() then
        return string.format("%s", col)
    else
        return string.format("%s\u{23ae}%s", col, max_col)
    end
end

local function getRowPosition()
    local row = "%l"
    local max_row = "%L"
    if not truncateCondition() then
        return string.format("%s", row)
    else
        return string.format("%s\u{23ae}%s", row, max_row)
    end
end

local function getWindowNumber()
    return vim.api.nvim_win_get_number(0)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Disable any conflicting statuslines
        vim.cmd("set laststatus=2") -- Enable statusline
        vim.cmd("set noshowmode") -- Hide default mode display

        -- "Primary" accent color to be used for inactive statusline cells
        local inactive_primary_color = {
            fg = colors.dark_bg,
            bg = colors.muted,
        }

        require("lualine").setup({
            options = {
                theme = function()
                    -- Custom theme with pywal colors
                    local theme_colors = {
                        normal = colors.accent1, -- Orange
                        insert = colors.accent2, -- Orange-yellow
                        visual = colors.accent4, -- Red-orange
                        replace = colors.accent3, -- Dark red
                        command = colors.accent2, -- Orange-yellow
                        bg = colors.bg, -- Transparent
                    }

                    local base = require("lualine.themes.auto")
                    base.normal.a = { fg = colors.dark_bg, bg = theme_colors.normal, gui = "bold" }
                    base.insert.a = { fg = colors.dark_bg, bg = theme_colors.insert, gui = "bold" }
                    base.visual.a = { fg = colors.dark_bg, bg = theme_colors.visual, gui = "bold" }
                    base.replace.a = { fg = colors.dark_bg, bg = theme_colors.replace, gui = "bold" }
                    base.command.a = { fg = colors.dark_bg, bg = theme_colors.command, gui = "bold" }

                    -- Set transparent backgrounds for other sections
                    base.normal.b = { fg = colors.fg, bg = colors.bg }
                    base.normal.c = { fg = colors.fg, bg = colors.bg }
                    base.insert.b = { fg = colors.fg, bg = colors.bg }
                    base.insert.c = { fg = colors.fg, bg = colors.bg }
                    base.visual.b = { fg = colors.fg, bg = colors.bg }
                    base.visual.c = { fg = colors.fg, bg = colors.bg }
                    base.replace.b = { fg = colors.fg, bg = colors.bg }
                    base.replace.c = { fg = colors.fg, bg = colors.bg }
                    base.command.b = { fg = colors.fg, bg = colors.bg }
                    base.command.c = { fg = colors.fg, bg = colors.bg }

                    return base
                end,
                section_separators = {
                    -- Full diagonal dividers bottom left to top right
                    left = "\u{e0bc}",
                    right = "\u{e0ba}",
                },
                component_separators = {
                    -- Hairline diagonal dividers bottom left to top right
                    left = "\u{e0bd}",
                    right = "\u{e0bb}",
                },
                globalstatus = true, -- Single statusline
                icons_enabled = true,
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = formatMode,
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                        diagnostics_color = {
                            error = { fg = colors.accent3 },
                            warn = { fg = colors.accent4 },
                            info = { fg = colors.accent2 },
                            hint = { fg = colors.muted },
                        },
                        cond = truncateCondition,
                        separator = "",
                    },
                    {
                        -- Center filename section
                        function()
                            return "%="
                        end,
                        separator = "",
                    },
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = {
                            left = 1,
                            right = 0,
                        },
                        color = { fg = colors.fg },
                    },
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        shorting_target = 40,
                        symbols = {
                            modified = "󰐖 ", -- Show when file is modified
                            readonly = " ", -- Show when file is readonly
                            unnamed = "[No Name]", -- Show when Buffer has no name
                            newfile = "[New]", -- Show when file hasn't been saved yet
                        },
                        color = { fg = colors.fg },
                    },
                },
                lualine_x = {},
                lualine_y = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.accent1 },
                        cond = truncateCondition,
                    },
                },
                lualine_z = {
                    {
                        getColumnPosition,
                        color = { fg = colors.dark_bg, bg = colors.accent1 },
                    },
                    {
                        getRowPosition,
                        color = { fg = colors.dark_bg, bg = colors.accent1 },
                    },
                },
            },
            inactive_sections = {
                lualine_a = {
                    {
                        getWindowNumber,
                        color = inactive_primary_color,
                        separator = {
                            -- The base configuration is ignored here for some reason I don't
                            -- know. However this fixes the right diagonal separator
                            right = "\u{e0bc}",
                        },
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        -- Center filename section
                        function()
                            return "%="
                        end,
                        separator = "",
                    },
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        shorting_target = 40,
                        symbols = {
                            modified = "󰐖 ", -- Show when file is modified
                            readonly = " ", -- Show when file is readonly
                            unnamed = "[No Name]", -- Show when Buffer has no name
                            newfile = "[New]", -- Show when file hasn't been saved yet
                        },
                        color = { fg = colors.muted },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    {
                        getColumnPosition,
                        color = inactive_primary_color,
                    },
                    {
                        getRowPosition,
                        color = inactive_primary_color,
                    },
                },
            },
            extensions = {
                "oil",
                "nvim-tree",
                "lazy",
                "mason",
                "trouble",
                "toggleterm",
                "quickfix",
            },
        })
    end,
}
