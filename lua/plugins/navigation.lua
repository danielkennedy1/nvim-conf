return {
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- Load when these commands are used
        cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeFocus" },
        -- Load when these keys are pressed
        keys = {
            { "-",         "<cmd>NvimTreeToggle<CR>",   desc = "Toggle File Explorer" },
            { "<leader>e", "<cmd>NvimTreeToggle<CR>",   desc = "Toggle File Explorer" },
            { "<leader>E", "<cmd>NvimTreeFindFile<CR>", desc = "Find File in Explorer" },
        },
        config = function()
            -- Disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- Enable termguicolors
            vim.opt.termguicolors = true

            -- Set up dimensions
            local HEIGHT_RATIO = 0.8
            local WIDTH_RATIO = 0.5

            -- Custom on_attach function for keymaps
            local function my_on_attach(bufnr)
                local api = require("nvim-tree.api")
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- Default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- Custom mappings for nvim-tree
                -- Navigate
                vim.keymap.set('n', 'l', api.node.open.edit, opts("Open"))
                vim.keymap.set('n', 'o', api.node.open.edit, opts("Open"))
                vim.keymap.set('n', '<CR>', api.node.open.edit, opts("Open"))
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Close Directory"))

                -- Vertical split
                vim.keymap.set('n', 'v', api.node.open.vertical, opts("Open: Vertical Split"))
                vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts("CD"))

                -- Close without remembering to press 'q'
                vim.keymap.set('n', '<Esc>', api.tree.close, opts("Close"))
            end

            -- Set up nvim-tree
            require("nvim-tree").setup({
                on_attach = my_on_attach,
                disable_netrw = true,
                hijack_netrw = true,
                respect_buf_cwd = true,
                sync_root_with_cwd = true,
                view = {
                    relativenumber = true,
                    float = {
                        enable = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                                - vim.opt.cmdheight:get()
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    width = function()
                        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                    end,
                },
            })
        end,
    }
}
