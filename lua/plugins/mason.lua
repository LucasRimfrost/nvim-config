return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            ensure_installed = {
                -- LSP Servers
                "lua-language-server",
                "clangd",
                "gopls",
                "pyright",
                "typescript-language-server",
                "jdtls",
                "texlab",
                "ltex-ls",

                -- Formatters
                "stylua", -- Lua
                "black", -- Python
                "isort", -- Python imports
                "prettier", -- JS/TS/CSS/HTML/JSON/YAML
                "prettierd", -- Faster prettier
                "clang-format", -- C/C++
                "gofumpt", -- Go (better than gofmt)
                "goimports", -- Go imports
                "google-java-format", -- Java
                "latexindent", -- LaTeX
                "bibtex-tidy", -- Bibtex
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            -- Auto install ensure_installed tools
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        vim.notify("Mason: Installing " .. tool .. "...", vim.log.levels.INFO)
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
