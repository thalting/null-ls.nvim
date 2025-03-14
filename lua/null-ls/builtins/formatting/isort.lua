local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
    name = "isort",
    meta = {
        url = "https://github.com/PyCQA/isort",
        description = "Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.",
    },
    method = FORMATTING,
    filetypes = { "python" },
    generator_opts = {
        command = "isort",
        args = {
            "--stdout",
            "--filename",
            "$FILENAME",
            "-",
        },
        to_stdin = true,
        cwd = h.cache.by_bufnr(function(params)
            return u.root_pattern(
                -- https://pycqa.github.io/isort/docs/configuration/config_files.html
                "setup.cfg",
                ".isort.cfg",
                "pyproject.toml",
                "tox.ini",
                ".editorconfig"
            )(params.bufname)
        end),
    },
    factory = h.formatter_factory,
})
