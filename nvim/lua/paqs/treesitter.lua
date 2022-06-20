local ensure_installed = {}
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

require('nvim-treesitter.configs').setup {
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

require('nvim-treesitter.configs').setup {
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
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

for k, v in pairs {
    a = '@parameter.inner',
    c = '@call.outer',
    C = '@class.outer',
    f = '@function.outer',
    i = '@conditional.outer',
} do
    map(
        { 'n', ']' .. k, [[':<c-u>lua require("paqs.treesitter").next("]] .. v .. [[", ' . v:count1 . ')<cr>']] },
        { expr = true }
    )
    map(
        { 'n', '[' .. k, [[':<c-u>lua require("paqs.treesitter").previous("]] .. v .. [[", ' . v:count1 . ')<cr>']] },
        { expr = true }
    )
end

return {
    next = function(type, count)
        for _ = 1, count do
            require('nvim-treesitter.textobjects.move').goto_next_start(type)
        end
    end,
    previous = function(type, count)
        for _ = 1, count do
            require('nvim-treesitter.textobjects.move').goto_previous_start(type)
        end
    end,
}
