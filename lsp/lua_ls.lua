return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = { "lua/?.lua", "lua/?/init.lua" },
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                -- This is the key missing piece!
                library = {
                    vim.env.VIMRUNTIME,
                    -- Uncomment the next line if you want plugin completions too
                    -- "${3rd}/luv/library",
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
