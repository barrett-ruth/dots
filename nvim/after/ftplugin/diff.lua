for _, sign in ipairs { 'Add', 'Chg', 'Del', 'DelEnd' } do
    vim.fn.sign_define('Undotree' .. sign, { text = '' })
end
