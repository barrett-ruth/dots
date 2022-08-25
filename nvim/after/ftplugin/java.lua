local jdtls = require 'jdtls'
local root_markers = {
    '.git',
    'mvnw',
    'gradlew',
    'pom.xml',
}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = vim.env.HOME
    .. '/.local/share/eclipse/'
    .. vim.fn.fnamemodify(root_dir, ':p:h:t')

local settings =
    require('lsp.utils').prepare_lsp_settings(require 'lsp.servers.jdtls')

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.env.XDG_DATA_HOME
            .. '/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration',
        vim.env.XDG_DATA_HOME .. '/java/jdtls/config_linux',
        '-data',
        workspace_folder,
    },
    root_dir = require('jdtls.setup').find_root(root_markers),
}

for k, v in pairs(settings) do
    config[k] = v
end

jdtls.start_or_attach(config)
