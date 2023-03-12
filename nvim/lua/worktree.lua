local parse_entry = function(entry)
    local parsed = vim.split(entry, '%s+')

    return {
        path = parsed[1],
        hash = parsed[2],
        branch = parsed[3]:sub(2, #parsed[3] - 1),
    }
end

local actions, fzf = require 'fzf-lua.actions', require 'fzf-lua'

return {
    git_worktrees = function()
        local wt = require 'git-worktree'

        fzf.fzf_exec('git worktree list | sed "s|$HOME|~|g"', {
            fn_transform = function(x)
                local parsed = parse_entry(x)

                local first_whitespace = { x:find '%s+' }
                local _, second_whitespace_begin = x:find '.*%S%s'
                local _, second_whitespace_end = x:find '.*%s+'

                local colored = table.concat {
                    fzf.utils.ansi_codes.blue(parsed.path),
                    x:sub(unpack(first_whitespace)),
                    fzf.utils.ansi_codes.yellow(parsed.hash),
                    x:sub(second_whitespace_begin, second_whitespace_end),
                    fzf.utils.ansi_codes.green('[' .. parsed.branch .. ']'),
                }

                return colored
            end,
            actions = {
                ['default'] = function(selected)
                    local parsed = parse_entry(selected[1])

                    wt.switch_worktree(parsed.branch)
                end,
                ['ctrl-a'] = {
                    function()
                        local query = fzf.config.__resume_data.last_query

                        if require('utils').empty(query) then
                            return
                        end

                        local path, branch, upstream =
                            unpack(vim.split(vim.trim(query), ' '))
                        branch = branch or vim.fn.fnamemodify(path, ':t')

                        wt.create_worktree(path, branch, upstream)
                    end,
                    actions.resume,
                },
                ['ctrl-d'] = {
                    function(selected)
                        local parsed = parse_entry(selected[1])

                        wt.delete_worktree(parsed.branch, true)
                    end,
                    actions.resume,
                },
            },
        })
    end,
}
