return {
    s('main', fmt('fn main() {{\n\t{}\n}}', { i(1) })),
    s('pr', fmt('println!("{}");', { i(1) })),
}
