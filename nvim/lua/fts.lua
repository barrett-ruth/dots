local fts = {
    bash = 'shfmt -i 4 -w -ln=bash',
    sh = 'shfmt -i 4 -w -ln=posix',
    zsh = 'shfmt -i 4 -w -ln=bash',
    javascript = 'echo "$(cat % | prettierd %)" >',
    lua = 'stylua --config-path ~/.config/stylua/stylua.toml',
    python = 'black --skip-string-normalization',
}
fts.html = fts.javascript
fts.css = fts.javascript
fts.javascriptreact = fts.javascript
fts.scss = fts.javascript
fts.typescript = fts.javascript
fts.typescriptreact = fts.javascript
fts.yaml = fts.javascript

return fts
