return {
    {
        'mfussenegger/nvim-dap',
        -- TODO: extract config to debug/map.lua
        config = function()
            local dap = require 'dap'

            map { 'n', '<leader>db', dap.toggle_breakpoint }
            map { 'n', '<leader>dc', dap.continue }
            map { 'n', '<leader>dd', dap.down }
            map { 'n', '<leader>dh', require('dap.ui.widgets').hover }
            map { 'n', '<leader>di', dap.step_into }
            map { 'n', '<leader>do', dap.step_over }
            map { 'n', '<leader>du', dap.up }
        end,
        dependencies = {
            { 'theHamsta/nvim-dap-virtual-text', config = true },
            {
                'rcarriga/nvim-dap-ui',
                config = function(_, opts)
                    require('dapui').setup(opts)
                end,
                keys = {
                    {
                        '<leader>dt',
                        function()
                            require('dapui').toggle {}
                        end,
                    },
                    { '<leader>dn', require('debug.node').setup },
                },
                lazy = true,
                opts = {
                    icons = {
                        expanded = 'v',
                        collapsed = '>',
                    },
                },
            },
        },
        lazy = true,
    },
}
