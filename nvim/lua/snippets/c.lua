return {
    s('/* ', fmt('/* {} */', { i(1) })),
    s('def', fmt('#define {}', { i(1) })),
    s('inh', fmt('#include "{}"', { i(1) })),
    s('in', fmt('#include <{}>', { i(1) })),
}