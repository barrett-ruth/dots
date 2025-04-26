local cppsnippets = {}

local Path = require('plenary.path')
local cpsnippets =
    Path:new(debug.getinfo(1, 'S').source:sub(2)):parent():joinpath('cp')

local function readlines(file, absolute)
    return vim.fn.readfile(
        not absolute and cpsnippets:joinpath(file):absolute() or file
    )
end

require('plenary.scandir').scan_dir(tostring(cpsnippets), {
    on_insert = function(file)
        table.insert(
            cppsnippets,
            s(vim.fn.fnamemodify(file, ':t:r'), t(readlines(file, true)))
        )
    end,
})

for _, snippet in ipairs({
    s('in', fmt('#include {}', { i(1) })),
    s(
        'main',
        fmt(
            [[#include <iostream>

int main() {{
    {}

    return 0;
}}]],
            { i(1) }
        )
    ),
    s('pr', fmt('std::cout << {}', { i(1) })),
    s('s', fmt('std::{}', { i(1) })),
    s(
        'usaco',
        fmt(
            [[{}

void solve() {{
  {}
}}

int main() {{  // {{{{{{
  cin.tie(nullptr)->sync_with_stdio(false);
  cin.exceptions(cin.failbit);

#define PROBLEM_NAME "{}"

#ifdef LOCAL
  freopen("io/" PROBLEM_NAME ".in", "r", stdin);
  freopen("io/" PROBLEM_NAME ".out", "w", stdout);
#else
  freopen(PROBLEM_NAME ".in", "r", stdin);
  freopen(PROBLEM_NAME ".out", "w", stdout);
#endif

  solve();

  return 0;
}}
// }}}}}}]],
            {
                t(readlines('template.cc')),
                i(1),
                f(function()
                    return vim.fn.expand('%:t:r')
                end),
            }
        )
    ),
    s(
        'cses',
        fmt(
            [[{}

void solve() {{
  {}
}}

int main() {{  // {{{{{{
  cin.tie(nullptr)->sync_with_stdio(false);
  cin.exceptions(cin.failbit);

  int tc = 1;
  // cin >> tc;

  for (int t = 0; t < tc; ++t) {{
    solve();
  }}

  return 0;
}}
// }}}}}}]],
            { t(readlines('template.cc')), i(1) }
        )
    ),
    s(
        'icpc',
        fmt(
            [[{}

void solve() {{
  {}
}}

int main() {{  // {{{{{{
  cin.tie(nullptr)->sync_with_stdio(false);
  cin.exceptions(cin.failbit);

  solve();

  return 0;
}}
// }}}}}}]],
            { t(readlines('template.cc')), i(1) }
        )
    ),
    s(
        'codeforces',
        fmt(
            [[{}

void solve() {{
  {}
}}

int main() {{  // {{{{{{
  cin.tie(nullptr)->sync_with_stdio(false);
  cin.exceptions(cin.failbit);

  int tc = 1;
  cin >> tc;

  for (int t = 0; t < tc; ++t) {{
    solve();
  }}

  return 0;
}}
// }}}}}}]],
            { t(readlines('template.cc')), i(1) }
        )
    ),
}) do
    table.insert(cppsnippets, snippet)
end

return cppsnippets
