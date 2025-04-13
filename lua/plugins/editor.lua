return {
  -- Formatter
  {
    'mhartington/formatter.nvim',
    event = { "BufWritePre" }, -- Load before writing a buffer
    cmd = { "Format", "FormatWrite" }, -- Load when these commands are used
    config = function()
        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        require("formatter").setup({
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").stylua,
                },
                python = {
                    require("formatter.filetypes.python").black,
                },
            },
        })

        -- Custom format command
        -- Alias :W to :FormatWrite
        vim.api.nvim_create_user_command("W", "FormatWrite", {})
    end,
  },
  
  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = { "BufReadPre", "BufNewFile" }, -- Load when reading or creating files
    config = function()

        -- Set linters
        require('lint').linters_by_ft = {
            python = {'pylint'}
        }

        -- Set running linters on buffer save
        vim.api.nvim_create_autocmd({"BufWritePost"}, {
            callback = function()
                require("lint").try_lint()
            end,
        })

    end,
  },
  
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Load when entering insert mode
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,
        -- Your autopairs config here
      })
      
      -- Setup with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  
  -- Auto save
  {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" }, -- When to load
    config = function()
      require("auto-save").setup({
        -- Your auto-save config here
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
  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTelescope", "TodoQuickFix", "TodoLocList" }, -- Load on these commands
    event = { "BufReadPost", "BufNewFile" }, -- Or load when reading files
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
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
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
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "BOLD", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
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
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        }
    end,
},
}
