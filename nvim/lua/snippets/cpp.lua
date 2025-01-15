local function read_file(relative_path)
    return vim.fn.readfile(
        require('plenary.path')
        :new(debug.getinfo(1, 'S').source:sub(2))
        :parent()
        :joinpath(relative_path)
        :absolute()
    )
end

return {
    s('in', fmt('#include {}', { i(1) })),
    s('main', fmt('#include <iostream>\n\nint main() {{\n\t{}\n}}', { i(1) })),
    s('pr', fmt('std::cout << {}', { i(1) })),
    s('s', fmt('std::{}', { i(1) })),
    s(
        'usaco',
        fmt(
            [[{}

#define PROBLEM_NAME "{}"

void solve() {{
    {}
}}

int main() {{
  cin.tie(nullptr)->sync_with_stdio(false);

  freopen(PROBLEM_NAME ".in", "r", stdin);
  freopen(PROBLEM_NAME ".out", "w", stdout);

  solve();

  return 0;
}}]],
            {
                t(read_file('cp/template.cc')),
                f(function()
                    return vim.fn.expand('%:t:r')
                end),
                i(1),
            }
        )
    ),
    s('st', t(read_file('cp/sparse_table.cc'))),
    s(
        'cf',
        fmt(
            [[{}

void solve() {{
  {}
}}

int main() {{
  cin.tie(nullptr)->sync_with_stdio(false);

  int t = 1;
  cin >> t;

  while (t--) {{
      solve();
  }}

  return 0;
}}]],
            { t(read_file('cp/template.cc')), i(1) }
        )
    ),
}
