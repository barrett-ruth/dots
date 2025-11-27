--- @class Fold
local M = {}

--- Setup treesitter-based code folding
--- Configures fold settings and autocmds for all filetypes
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

--- Debug fold levels and treesitter nodes for a range of lines
--- Shows fold level, primary node type, and line content in formatted output
--- @param start_line? number Starting line (default: 1)
--- @param end_line? number Ending line (default: last line in buffer)
function M.debug(start_line, end_line)
    local bufnr = vim.api.nvim_get_current_buf()
    local total_lines = vim.api.nvim_buf_line_count(bufnr)

    start_line = start_line or 1
    end_line = end_line or total_lines

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        print("No treesitter parser available")
        return
    end

    local trees = parser:parse()
    if not trees or #trees == 0 then
        print("No parse trees available")
        return
    end

    local root = trees[1]:root()

    for i = start_line, end_line do
        vim.v.lnum = i
        local fold_result = M.foldexpr()
        local line_text = vim.fn.getline(i)
        local first_col = line_text:match('^%s*()') or 1
        local node = root:named_descendant_for_range(i - 1, first_col - 1, i - 1, first_col - 1)

        local display_node = nil
        if node then
            local temp = node
            while temp do
                local node_start = temp:range() + 1
                if node_start == i then
                    display_node = temp
                    break
                end
                temp = temp:parent()
            end
            display_node = display_node or node
        end

        local node_name = display_node and display_node:type() or "none"
        local content = line_text:sub(1, 50)

        print(string.format("%-4d [%-3s] %-32s %s",
            i, fold_result, node_name, content))
    end
end

--- Foldexpr function that calculates fold levels for each line
--- Uses treesitter to detect structural elements and nest folds appropriately
--- @return string Fold level: '>N' to start fold at level N, 'N' for level N, '0' for no fold
function M.foldexpr()
    local line = vim.v.lnum
    local bufnr = vim.api.nvim_get_current_buf()

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

    local function should_fold(n)
        local start_line, _, end_line, _ = n:range()
        return end_line - start_line + 1 >= vim.wo.foldminlines
    end

    local function is_foldable(node_type)
        -- Functions/methods: Python, C++, Rust, TypeScript, Go, Java, Lua
        if node_type == 'function_definition'
            or node_type == 'function_declaration'
            or node_type == 'method_definition'
            or node_type == 'method_declaration'
            or node_type == 'function_item' then
            return true
        end

        -- Classes: Python, C++, TypeScript, Java
        if node_type == 'class_definition'
            or node_type == 'class_declaration'
            or node_type == 'class_specifier' then
            return true
        end

        -- Structs/Unions: Rust, C++, Go
        if node_type == 'struct_item'
            or node_type == 'struct_specifier'
            or node_type == 'struct_type'
            or node_type == 'union_specifier' then
            return true
        end

        -- Interfaces: TypeScript, Java, Go
        if node_type == 'interface_declaration'
            or node_type == 'interface_definition'
            or node_type == 'interface_type' then
            return true
        end

        -- Type declarations/definitions: Go, C/C++
        if node_type == 'type_declaration'
            or node_type == 'type_definition' then
            return true
        end

        -- Traits: Rust
        if node_type == 'trait_item' then
            return true
        end

        -- Enums: Rust, TypeScript, C++, Java
        if node_type == 'enum_declaration'
            or node_type == 'enum_specifier'
            or node_type == 'enum_item' then
            return true
        end

        -- Impl blocks: Rust
        if node_type == 'impl_item' then
            return true
        end

        -- Namespaces/modules: C++, Rust, TypeScript
        if node_type == 'namespace_definition'
            or node_type == 'namespace_declaration'
            or node_type == 'internal_module'
            or node_type == 'mod_item' then
            return true
        end

        return false
    end

    local original_node = node
    local found_foldable = false

    while node do
        local node_type = node:type()

        if is_foldable(node_type) and should_fold(node) then
            found_foldable = true
        end

        if starts_on_line(node) and is_foldable(node_type) then
            if should_fold(node) then
                local level = 1
                local parent = node:parent()
                while parent do
                    if is_foldable(parent:type()) and should_fold(parent) then
                        level = level + 1
                    end
                    parent = parent:parent()
                end
                return '>' .. level
            end
        end

        node = node:parent()
    end

    if found_foldable then
        local level = 0
        local temp_node = original_node
        while temp_node do
            if is_foldable(temp_node:type()) and should_fold(temp_node) then
                level = level + 1
            end
            temp_node = temp_node:parent()
        end
        return tostring(level)
    end

    return '0'
end

return M
