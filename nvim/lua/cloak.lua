-- github.com/laytan/cloak.nvim

local group = vim.api.nvim_create_augroup('ACloak', {})
local ns = vim.api.nvim_create_namespace('cloak')

local enabled = true

local function uncloak()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

local function cloak(cloak_pattern)
    uncloak()

    require('cmp').setup.buffer({ enabled = false })

    local found_pattern = false
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
        -- Find all matches for the current line
        local searchStartIndex = 1
        while searchStartIndex < #line do
            -- Find best pattern based on starting position and tiebreak with length
            local first, last = -1, 1
            local current_first, current_last =
                line:find(cloak_pattern, searchStartIndex)

            if
                current_first ~= nil
                and (
                    first < 0
                    or current_first < first
                    or (current_first == first and current_last > last)
                )
            then
                first, last = current_first, current_last
            end

            if first >= 0 then
                found_pattern = true
                vim.api.nvim_buf_set_extmark(0, ns, i - 1, first, {
                    hl_mode = 'combine',
                    virt_text = {
                        {
                            string.rep('*', last - first),
                            'Comment',
                        },
                    },
                    virt_text_pos = 'overlay',
                })
            else
                break
            end

            searchStartIndex = last
        end
    end

    if found_pattern then
        vim.opt_local.wrap = false
    end
end

local function toggle()
    if enabled then
        enabled = false
        uncloak()
    else
        enabled = true
        vim.api.nvim_exec_autocmds('TextChanged', { group = group })
    end
end

return {
    setup = function()
        vim.api.nvim_create_autocmd(
            { 'BufEnter', 'TextChanged', 'TextChangedI', 'TextChangedP' },
            {
                pattern = '.env*',
                callback = function()
                    if enabled then
                        cloak('=.+')
                    end
                end,
                group = group,
            }
        )

        map({ 'n', '<leader>c', toggle })
    end,
}
