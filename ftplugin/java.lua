-- ~/.config/nvim/ftplugin/java.lua

local jdtls = require("jdtls")

-- Determine workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. project_name

local config = {
    cmd = {
        -- Use your specific Java path
        "/usr/lib/jvm/java-21-temurin/bin/java", -- Updated this line
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux",
        "-data",
        workspace_dir,
    },

    root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew" }),

    on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        -- Java refactoring
        vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
        vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
        vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
        vim.keymap.set("v", "<leader>jm", function()
            jdtls.extract_method(true)
        end, opts)

        -- Java testing (if you have nvim-dap setup)
        vim.keymap.set("n", "<leader>jt", jdtls.test_class, opts)
        vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, opts)

        -- Java compilation
        vim.keymap.set("n", "<leader>jb", jdtls.compile, opts)
    end,

    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21", -- Updated this
                        path = "/usr/lib/jvm/java-21-temurin/", -- Updated this
                    },
                },
            },
        },
    },
}

jdtls.start_or_attach(config)
