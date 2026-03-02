return {
    {
        'mhartington/formatter.nvim',
        event = { "BufWritePre" },
        cmd = { "Format", "FormatWrite" },
        config = function()
            require("formatter").setup({
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                    },
                    python = {
                        require("formatter.filetypes.python").black,
                    },
                },
            })
            vim.api.nvim_create_user_command("W", "FormatWrite", {})
        end,
    },
    {
        'mfussenegger/nvim-lint',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            if (vim.env.VIRTUAL_ENV ~= nil) then
                require('lint').linters.pylint.cmd = vim.env.VIRTUAL_ENV .. "/bin/pylint"
            end
            require('lint').linters_by_ft = {
                python = { 'pylint' }
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                check_ts = true,
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
    {
        "Pocco81/auto-save.nvim",
        event = { "InsertLeave", "TextChanged" },
        config = function()
            require("auto-save").setup({
                condition = function(buf)
                    -- Don't close harpoon quick menu
                    if vim.bo[buf].filetype == "harpoon" then
                        return false
                    end
                    return true
                end
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "TodoTelescope", "TodoQuickFix", "TodoLocList" },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("todo-comments").setup {
                -- TODO: Here's todo
                -- FIX: Here's fix
                -- HACK: Here's hack
                -- WARN: Here's warn
                -- PERF: Here's perf
                -- NOTE: Here's note
                -- TEST: Here's test
                -- MAYBE: Here's maybe
                signs = true,
                sign_priority = 8,
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "OPTIMISE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                    MAYBE = { icon = " ", color = "info", alt = { "PERHAPS" } },
                    DIRT = { icon = " ", color = "dirt", alt = { "DIRTY" } },
                },
                gui_style = {
                    fg = "NONE",
                    bg = "BOLD",
                },
                merge_keywords = true,
                highlight = {
                    multiline = true,
                    multiline_pattern = "^.",
                    multiline_context = 10,
                    before = "",
                    keyword = "wide",
                    after = "fg",
                    pattern = [[.*<(KEYWORDS)\s*:]],
                    comments_only = true,
                    max_line_len = 400,
                    exclude = {},
                },
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test = { "Identifier", "#FF00FF" },
                    dirt = { "#6F4E37" }
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    pattern = [[\b(KEYWORDS):]],
                },
            }
        end,
    },
}
