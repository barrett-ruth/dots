return {
    cmd = { 'mdx-language-server', '--stdio' },
    filetypes = { 'mdx' },
    root_markers = { 'package.json' },
    settings = {},
    init_options = {
        typescript = {},
    },
    before_init = function(_, config)
        if
            config.init_options
            and config.init_options.typescript
            and not config.init_options.typescript.tsdk
        then
            local tsdk = require('lspconfig.util').get_typescript_server_path(config.root_dir)
            if tsdk == '' then
                local pnpm_pattern = config.root_dir
                    .. '/node_modules/.pnpm/typescript@*/node_modules/typescript'
                local pnpm_matches = vim.fn.glob(pnpm_pattern, false, true)
                if #pnpm_matches > 0 then
                    tsdk = pnpm_matches[1] .. '/lib'
                end
            end
            config.init_options.typescript.tsdk = tsdk
        end
    end,
}
