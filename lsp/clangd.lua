return {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".clangd",
        ".git",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}
