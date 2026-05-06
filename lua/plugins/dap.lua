return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
            { "<leader>dc", "<cmd>DapContinue<cr>",         desc = "Continue" },
            { "<leader>do", "<cmd>DapStepOver<cr>",         desc = "Step Over" },
            { "<leader>di", "<cmd>DapStepInto<cr>",         desc = "Step Into" },
            { "<leader>dO", "<cmd>DapStepOut<cr>",          desc = "Step Out" },
            { "<leader>dt", "<cmd>DapTerminate<cr>",        desc = "Terminate" },
            { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle DAP UI" },
            { "<leader>dr", function()
                -- Find workspace root
                local workspace_root = vim.fn.getcwd()
                local workspace_markers = {"WORKSPACE", "MODULE.bazel", "WORKSPACE.bazel"}
                for _, marker in ipairs(workspace_markers) do
                    local marker_path = vim.fn.findfile(marker, workspace_root .. ";")
                    if marker_path ~= "" then
                        workspace_root = vim.fn.fnamemodify(marker_path, ":p:h")
                        break
                    end
                end

                -- Read .dap.json config
                local config_file = workspace_root .. "/.dap.json"
                local config = {}
                local f = io.open(config_file, "r")
                if f then
                    local content = f:read("*a")
                    f:close()
                    config = vim.fn.json_decode(content)
                else
                    vim.notify("No .dap.json found in workspace root. Create one with target info.", vim.log.levels.ERROR)
                    return
                end

                local target = config.target
                if not target then
                    vim.notify(".dap.json missing 'target' field", vim.log.levels.ERROR)
                    return
                end

                -- Convert //src:main to bazel-bin/src/main
                local binary_path = target:gsub("^//", ""):gsub(":", "/")
                binary_path = workspace_root .. "/bazel-bin/" .. binary_path

                -- Build with debug symbols
                vim.notify("Building " .. target .. " with debug symbols...")
                local build_cmd = string.format("cd %s && bazel build --config=dbg %s",
                    vim.fn.shellescape(workspace_root),
                    vim.fn.shellescape(target))

                local result = vim.fn.system(build_cmd)
                if vim.v.shell_error ~= 0 then
                    vim.notify("Build failed:\n" .. result, vim.log.levels.ERROR)
                    return
                end

                vim.notify("Build successful! Starting debugger...")

                -- Start debugging with the built binary
                local dap = require("dap")
                dap.run({
                    type = "lldb",
                    request = "launch",
                    name = "Debug " .. target,
                    program = binary_path,
                    cwd = workspace_root,
                    stopOnEntry = false,
                    args = config.args or {},
                    initCommands = {
                        string.format('settings set target.source-map /proc/self/cwd %s', workspace_root),
                    },
                })
            end, desc = "Build and Debug (from .dap.json)" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Setup DAP UI
            dapui.setup()

            -- Auto-open DAP UI when debugging starts
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "julianolf/nvim-dap-lldb",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "c", "cpp", "rust" },
        config = function()
            require("dap-lldb").setup()

            -- Add Bazel debugging configuration
            local dap = require("dap")

            dap.configurations.cpp = dap.configurations.cpp or {}
            table.insert(dap.configurations.cpp, {
                name = "Debug Bazel Target",
                type = "lldb",
                request = "launch",
                program = function()
                    -- Find workspace root by looking for WORKSPACE or MODULE.bazel
                    local workspace_root = vim.fn.getcwd()
                    local workspace_markers = {"WORKSPACE", "MODULE.bazel", "WORKSPACE.bazel"}
                    for _, marker in ipairs(workspace_markers) do
                        local marker_path = vim.fn.findfile(marker, workspace_root .. ";")
                        if marker_path ~= "" then
                            workspace_root = vim.fn.fnamemodify(marker_path, ":p:h")
                            break
                        end
                    end

                    -- Find all executables in bazel-bin
                    local bazel_bin = workspace_root .. "/bazel-bin"
                    local handle = io.popen("find " .. vim.fn.shellescape(bazel_bin) .. " -type f -executable 2>/dev/null")
                    if not handle then
                        vim.notify("Could not find bazel-bin directory", vim.log.levels.ERROR)
                        return vim.fn.input('Bazel binary path: ', '', 'file')
                    end

                    local binaries = {}
                    for line in handle:lines() do
                        -- Skip test files and helper scripts
                        if not line:match("%.runfiles") and not line:match("%.sh$") then
                            table.insert(binaries, line)
                        end
                    end
                    handle:close()

                    if #binaries == 0 then
                        vim.notify("No built binaries found in bazel-bin. Run 'bazel build -c dbg //target' first.", vim.log.levels.WARN)
                        return vim.fn.input('Bazel binary path: ', '', 'file')
                    end

                    -- Let user select from built binaries
                    local selected
                    vim.ui.select(binaries, {
                        prompt = "Select Bazel binary to debug:",
                        format_item = function(item)
                            return item:gsub(workspace_root .. "/", "")
                        end,
                    }, function(choice)
                        selected = choice
                    end)

                    return selected
                end,
                cwd = function()
                    -- Find workspace root
                    local workspace_root = vim.fn.getcwd()
                    local workspace_markers = {"WORKSPACE", "MODULE.bazel", "WORKSPACE.bazel"}
                    for _, marker in ipairs(workspace_markers) do
                        local marker_path = vim.fn.findfile(marker, workspace_root .. ";")
                        if marker_path ~= "" then
                            return vim.fn.fnamemodify(marker_path, ":p:h")
                        end
                    end
                    return workspace_root
                end,
                stopOnEntry = false,
                args = function()
                    local args_string = vim.fn.input('Arguments: ')
                    return vim.split(args_string, " ", { trimempty = true })
                end,
                -- Set up source path mapping for Bazel's /proc/self/cwd
                initCommands = function()
                    local workspace_root = vim.fn.getcwd()
                    local workspace_markers = {"WORKSPACE", "MODULE.bazel", "WORKSPACE.bazel"}
                    for _, marker in ipairs(workspace_markers) do
                        local marker_path = vim.fn.findfile(marker, workspace_root .. ";")
                        if marker_path ~= "" then
                            workspace_root = vim.fn.fnamemodify(marker_path, ":p:h")
                            break
                        end
                    end

                    return {
                        -- Map Bazel's /proc/self/cwd to actual workspace
                        string.format('settings set target.source-map /proc/self/cwd %s', workspace_root),
                    }
                end,
            })
        end
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "go",
        config = function()
            require("dap-go").setup()
        end
    },
}
