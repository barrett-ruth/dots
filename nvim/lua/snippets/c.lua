return {
    s('in', fmt('#include {}', { i(1) })),
    s('/* ', fmt('/* {} */', { i(1) })),
    s('def', t '#define ', i(1)),
    s('in', fmt('#include {}', { i(1) })),
    s('pr', fmt('printf("{}", {});', { i(1), i(2) }))
}
