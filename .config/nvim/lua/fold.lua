--- @class Fold
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
    vim.o.foldnestmax = 2
    vim.o.foldminlines = 5

    vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.require("fold").foldexpr()'
        end,
    })
end

--- @param start_line? number Starting line (default: 1)
--- @param end_line? number Ending line (default: last line in buffer)
function M.debug(start_line, end_line)
    local bufnr = vim.api.nvim_get_current_buf()
    local total_lines = vim.api.nvim_buf_line_count(bufnr)
    start_line = start_line or 1
    end_line = end_line or total_lines

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        print('No treesitter parser available')
        return
    end

    local trees = parser:parse()
    if not trees or #trees == 0 then
        print('No parse trees available')
        return
    end

    local root = trees[1]:root()

    for i = start_line, end_line do
        vim.v.lnum = i
        local fold_result = M.foldexpr()
        local line_text = vim.fn.getline(i)
        local content = line_text:sub(1, 50)

        local last_col = line_text:find('%S%s*$')
        local node_name = 'none'
        local display_node = nil
        if last_col then
            local node = root:named_descendant_for_range(
                i - 1,
                last_col - 1,
                i - 1,
                last_col - 1
            )
            if node then
                local temp = node
                while temp do
                    local srow, _, _, _ = temp:range()
                    if srow + 1 == i then
                        display_node = temp
                        break
                    end
                    temp = temp:parent()
                end
                display_node = display_node or node
            end
        else
            local enclosing = root:descendant_for_range(i - 1, 0, i - 1, 0)
            if enclosing then
                while enclosing and not enclosing:named() do
                    enclosing = enclosing:parent()
                end
                display_node = enclosing
            end
        end

        node_name = display_node and display_node:type() or 'none'

        print(
            string.format(
                '%-4d [%-3s] %-32s %s',
                i,
                fold_result,
                node_name,
                content
            )
        )
    end
end

--- @type table<integer, table<integer, true>>
M.edges = {}

--- @return string Fold level (as string for foldexpr)
function M.foldexpr()
    local line = vim.v.lnum
    local bufnr = vim.api.nvim_get_current_buf()

    M.edges[bufnr] = M.edges[bufnr] or {}

    if line == 1 then
        M.edges[bufnr] = {}
    end

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

    local positions = {}
    local first_col = line_text:match('^%s*()')
    if first_col and first_col <= #line_text then
        table.insert(positions, first_col - 1)
    end
    local last_col = line_text:find('%S%s*$')
    if last_col then
        table.insert(positions, last_col - 1)
    end

    if #positions == 0 then
        table.insert(positions, 0)
    end

    local function is_foldable(node_type)
        return
            -- functions/methods
            node_type == 'function_definition'
                or node_type == 'function_declaration'
                or node_type == 'method_definition'
                or node_type == 'method_declaration'
                or node_type == 'function_item'
                -- structs/unions
                or node_type == 'class_definition'
                or node_type == 'class_declaration'
                or node_type == 'class_specifier'
                or node_type == 'struct_item'
                or node_type == 'struct_specifier'
                or node_type == 'struct_type'
                -- interfaces
                or node_type == 'union_specifier'
                or node_type == 'interface_declaration'
                or node_type == 'interface_definition'
                or node_type == 'interface_type'
                -- type decls/defs
                or node_type == 'type_declaration'
                or node_type == 'type_definition'
                -- traits
                or node_type == 'trait_item'
                -- enums
                or node_type == 'enum_declaration'
                or node_type == 'enum_specifier'
                -- namespace/modules
                or node_type == 'enum_item'
                or node_type == 'impl_item'
                or node_type == 'namespace_definition'
                or node_type == 'namespace_declaration'
                or node_type == 'internal_module'
                or node_type == 'mod_item'
    end

    local function should_fold(n)
        if not n then
            return false
        end
        local srow, _, erow, _ = n:range()
        return (erow - srow + 1) >= vim.wo.foldminlines
    end

    local function nested_fold_level(node)
        if not node then
            return 0
        end
        local level = 0
        local temp = node
        while temp do
            if is_foldable(temp:type()) and should_fold(temp) then
                level = level + 1
            end
            temp = temp:parent()
        end
        return level
    end

    local function starts_on_line(n)
        local srow, _, _, _ = n:range()
        return srow + 1 == line
    end

    local max_level = 0
    local is_start = false

    for _, col in ipairs(positions) do
        local node =
            root:named_descendant_for_range(line - 1, col, line - 1, col)
        if node then
            max_level = math.max(max_level, nested_fold_level(node))
            local temp = node
            while temp do
                if
                    is_foldable(temp:type())
                    and should_fold(temp)
                    and starts_on_line(temp)
                then
                    is_start = true
                end
                temp = temp:parent()
            end
        end
    end

    if max_level == 0 then
        return '0'
    end

    if is_start then
        M.edges[bufnr][line] = true
        return '>' .. max_level
    end

    return tostring(max_level)
end

return M
