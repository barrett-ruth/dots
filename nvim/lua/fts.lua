local fts = {
    refactor = {
        extract = {
            javascript = { prefix = 'const ' },
            javascriptreact = { prefix = 'const ' },
            lua = { prefix = 'local ' },
            typescript = { prefix = 'const ' },
            typescriptreact = { prefix = 'const ' },
        },
        inline = {
            javascript = '2WviW',
            javascriptreact = '2WviW',
            lua = '2WviW',
            python = '2WviW',
            typescript = '2WviW',
            typescriptreact = '2WviW',
        },
        print = {
            javascript = { l = 'console.log(', r = ')' },
            javascriptreact = { l = 'console.log(', r = ')' },
            lua = { l = 'print(', r = ')' },
            python = { l = 'print(', r = ')' },
            typescript = { l = 'console.log(', r = ')' },
            typescriptreact = { l = 'console.log(', r = ')' },
        },
    },
    save = {
        bash = 'shfmt -i 4 -w -ln=bash',
        sh = 'shfmt -i 4 -w -ln=posix',
        zsh = 'shfmt -i 4 -w -ln=bash',
        css = 'echo "$(cat % | prettierd %)" >',
        html = 'echo "$(cat % | prettierd %)" >',
        javascript = 'echo "$(cat % | prettierd %)" >',
        javascriptreact = 'echo "$(cat % | prettierd %)" >',
        typescript = 'echo "$(cat % | prettierd %)" >',
        typescriptreact = 'echo "$(cat % | prettierd %)" >',
        lua = 'stylua --config-path ~/.config/stylua/stylua.toml',
        python = 'black -S',
    },
}

return fts
