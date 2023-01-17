return {
    setup = function()
        local dap = require 'dap'

        dap.adapters.node2 = {
            type = 'executable',
            command = 'node',
            args = {
                vim.env.XDG_DATA_HOME
                    .. '/nvim/debug/vscode-node-debug2/out/src/nodeDebug.js',
            },
        }

        dap.configurations.javascript = {
            {
                name = 'Launch',
                type = 'node2',
                request = 'launch',
                program = '${file}',
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = 'inspector',
                console = 'integratedTerminal',
            },
            {
                name = 'Attach to process',
                type = 'node2',
                request = 'attach',
                processId = require('dap.utils').pick_process,
            },
        }
    end,
}
