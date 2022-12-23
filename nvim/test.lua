require('import-cost').setup()

local bufnr = vim.fn.bufnr("react_imports.js")
require('import-cost.extmark').set_extmarks(bufnr)
