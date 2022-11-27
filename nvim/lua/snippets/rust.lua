return {
    s('fn', fmt('fn {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('pr', fmt('println!("{}");', { i(1) }))
}
