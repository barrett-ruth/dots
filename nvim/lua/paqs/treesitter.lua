local treesitter_configs = require 'nvim-treesitter.configs'

require('nvim-treesitter.configs').setup {
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']a'] = '@parameter.inner',
                [']c'] = '@class.outer',
                [']f'] = '@function.outer',
                [']i'] = '@conditional.outer',
            },
            goto_previous_start = {
                ['[a'] = '@parameter.outer',
                ['[c'] = '@class.outer',
                ['[f'] = '@function.outer',
                ['[i'] = '@conditional.outer',
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ab = '@block.outer',
                ib = '@block.inner',
                af = '@function.outer',
                ['if'] = '@function.inner',
                ac = '@call.outer',
                ic = '@call.inner',
                aC = '@class.outer',
                iC = '@class.inner',
                ai = '@conditional.outer',
                ii = '@conditional.inner',
                aL = '@loop.outer',
                iL = '@loop.inner',
                aa = '@parameter.outer',
                ia = '@parameter.inner',
            },
        },
    },
}

local ecma_folds = { 'arrow_function', 'class_declaration', 'function', 'function_declaration', 'method_definition' }
local treesitter_folds = {
    bash = { 'function_definition' },
    c = { 'switch_statement', 'enum_specifier', 'function_definition', 'struct_specifier' },
    cpp = { 'class_specifier', 'namespace_definition' },
    'css',
    'dockerfile',
    'go',
    'html',
    'http',
    'java',
    javascript = ecma_folds,
    'json',
    lua = { 'function_declaration', 'function_definition' },
    'make',
    python = { 'class_definition', 'function_definition' },
    tsx = ecma_folds,
    typescript = ecma_folds,
    vim = { 'function_definition' },
    'yaml',
}

local ensure_installed = {}

for filetype, fold_types in pairs(treesitter_folds) do
    if type(filetype) == 'string' then
        table.insert(ensure_installed, filetype)

        local formatted = {}
        for _, v in ipairs(fold_types) do
            table.insert(formatted, '(' .. v .. ')')
        end

        vim.treesitter.set_query(filetype, 'folds', string.format('[%s]@fold', table.concat(formatted)))
    else
        table.insert(ensure_installed, fold_types)
    end
end

treesitter_configs.setup {
    ensure_installed = ensure_installed,
    sync_install = false,
    indent = {
        enable = false,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}

local utils = require 'utils'
local map = utils.map

map {
    'n',
    '<leader>T',
    function()
        package.loaded['paqs.treesitter'] = nil
        package.loaded['nvim-treesitter'] = nil
        require 'paqs.treesitter'
        require 'nvim-treesitter'
        vim.cmd 'e'
    end,
}
