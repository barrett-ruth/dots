return {
    s('fn', fmt('fn {}({}) {{\n\t{}\n}}', { i(1), i(2), i(3) })),
    s('main', fmt('fn main() {{\n\t{}\n}}', { i(1) })),
    s('pr', fmt('println!("{}");', { i(1) })),
    s('prd', fmt('println!("{{:?}}", {})', { i(1) }))
}
