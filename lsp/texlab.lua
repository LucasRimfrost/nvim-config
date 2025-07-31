return {
    cmd = { "texlab" },
    filetypes = { "tex", "plaintex", "bib" },
    settings = {
        texlab = {
            auxDirectory = "build",
            bibtexFormatter = "texlab",
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                forwardSearchAfter = false,
                onSave = false,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
}
