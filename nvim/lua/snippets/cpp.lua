return {
    s('in', fmt('#include {}', { i(1) })),
    s('main', fmt('#include <iostream>\n\nint main() {{\n\t{}\n}}', { i(1) })),
    s('pr', fmt('std::cout << {}', { i(1) })),
    s('s', fmt('std::{}', { i(1) })),
}
