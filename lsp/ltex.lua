return {
    cmd = { "ltex-ls" },
    filetypes = { "tex", "plaintex", "bib", "markdown" },
    settings = {
        ltex = {
            language = "en-US",
            enabled = { "tex", "latex", "plaintex", "bib", "markdown" }, -- CHANGE THIS LINE
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "sv",
            },
            checkFrequency = "save",
            dictionary = {
                ["en-US"] = {},
                ["sv"] = {},
            },
            disabledRules = {
                ["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
            },
        },
    },
}
