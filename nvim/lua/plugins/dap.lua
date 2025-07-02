return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            require("nvim-dap-virtual-text").setup()
            local function close_debugger()
                ui.close()
                dap.terminate()
            end

            vim.keymap.set("n", "<leader>dq", close_debugger, { desc = "Close DAP UI and terminate debug session" })

            ui.setup()

            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gd", dap.run_to_cursor)

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F13>", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                -- ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                -- ui.close()
            end

            -- Настройка dap-python с учётом пути к src
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
            require("dap-python").test_runner = "pytest"
            vim.keymap.set({ "n", "v" }, "<Leader>dt", function()
                require("dap-python").test_method()
            end)
        end,
    },
}
