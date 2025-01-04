return {
    s('in', fmt('#include {}', { i(1) })),
    s('main', fmt('#include <iostream>\n\nint main() {{\n\t{}\n}}', { i(1) })),
    s('pr', fmt('std::cout << {}', { i(1) })),
    s('s', fmt('std::{}', { i(1) })),
    s(
        'cp',
        fmt(
            [[#include <bits/stdc++.h>
using namespace std;

#define all(x) (x).begin(), (x).end()
#define sz(x) static_cast<int>((x).size())
#define FOR(i, x) for (size_t i = 0; i < (x).size(); ++i)

#ifndef ONLINE_JUDGE
#define dbg(x) cerr << #x << " = " << (x) << '\n'
#else
#define dbg(x)
#endif

void solve() {{
  {}
}}

int main() {{
  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  int t; cin >> t;

  while (t--) {{
      solve();
  }}

  return 0;
}}]],
            { i(1) }
        )
    ),
}
