return {
    s('/* ', fmt('/* {} */', { i(1) })),
    s('def', t '#define ', i(1)),
    s('in', fmt('#include {}', { i(1) })),
}
