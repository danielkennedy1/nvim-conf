return {
  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<c-\\>", desc = "Toggle Terminal" },
    },
    cmd = { "ToggleTerm", "TermExec" }, -- Load on these commands
    config = function()
        local HEIGHT_RATIO = 0.8 -- You can change this
        local WIDTH_RATIO = 0.8  -- You can change this too
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

        local term = require("toggleterm")
        term.setup {
            active = true,
            on_config_done = nil,

            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            terminal_mappings = true,
            persist_size = false,
            -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
            direction = "float",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = nil, -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
                border = "curved",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,

                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            }
        }
        -- Giving myself 3 terminals
        vim.keymap.set({"n", "t"}, "<M-1>", "<cmd>lua require('toggleterm').toggle(1)<CR>", { noremap = true, silent = true })
        vim.keymap.set({"n", "t"}, "<M-2>", "<cmd>lua require('toggleterm').toggle(2)<CR>", { noremap = true, silent = true })
        vim.keymap.set({"n", "t"}, "<M-3>", "<cmd>lua require('toggleterm').toggle(3)<CR>", { noremap = true, silent = true })

    end,
},
}
