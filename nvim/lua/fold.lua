local M = {}

function M.setup()
    vim.opt.fillchars:append({
        fold = ' ',
        foldopen = 'v',
        foldclose = '>',
        foldsep = ' ',
    })

    vim.o.foldlevel = 1
    vim.o.foldtext = ''
    vim.o.foldnestmax = 3
    vim.o.foldminlines = 5

    vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.require("fold").foldexpr()'
        end,
    })
end

function M.foldexpr()
    local line = vim.v.lnum
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        return '0'
    end

    local trees = parser:parse()
    if not trees or #trees == 0 then
        return '0'
    end

    local root = trees[1]:root()
    local line_text = vim.fn.getline(line)
    local first_col = line_text:match('^%s*()') or 1
    local node = root:named_descendant_for_range(
        line - 1,
        first_col - 1,
        line - 1,
        first_col - 1
    )

    if not node then
        return '='
    end

    local function starts_on_line(n)
        return (n:range()) + 1 == line
    end

    local function is_inside_class(n)
        local parent = n:parent()
        while parent do
            if parent:type():match('class') then
                return true
            end
            parent = parent:parent()
        end
        return false
    end

    local function should_fold(n)
        local start_line, _, end_line, _ = n:range()
        return end_line - start_line + 1 >= vim.wo.foldminlines
    end

    local function is_function_def(node_type)
        return node_type == 'function_definition'
            or node_type == 'function_declaration'
            or node_type == 'method_definition'
    end

    local function is_inside_function(n)
        local parent = n:parent()
        while parent do
            if is_function_def(parent:type()) then
                return true
            end
            parent = parent:parent()
        end
        return false
    end

    local found_function_in_class = false

    while node do
        local node_type = node:type()

        if is_function_def(node_type) and is_inside_class(node) then
            found_function_in_class = true
        end

        if starts_on_line(node) then
            if node_type:match('_class') or node_type:match('^if_') or node_type:match('^while_') or node_type:match('^for_') then
                if not is_inside_function(node) then
                    return '0'
                end
            end

            if is_function_def(node_type) then
                local in_class = is_inside_class(node)
                if in_class and should_fold(node) then
                    return '>1'
                end
                return '0'
            end
        end
        node = node:parent()
    end

    return found_function_in_class and '=' or '0'
end

return M
