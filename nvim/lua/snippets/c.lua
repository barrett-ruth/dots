return {
    s('/* ', fmt('/* {} */', { i(1) })),
    s('def', t '#define ', i(1)),
    s('for', fmt('for ({}) ', { i(1) })),
    s('if', fmt('if ({}) ', { i(1) })),
    s('inh', fmt('#include "{}"', { i(1) })),
    s('in', fmt('#include <{}>', { i(1) })),
}
