return {
    s('/* ', fmt('/* {} */', { i(1) })),
    s('in', fmt('#include {}', { i(1) })),
    s(
        'cp',
        fmt(
            [[
            #include <algorithm>
            #include <bitset>
            #include <cmath>
            #include <deque>
            #include <iostream>
            #include <limits>
            #include <numeric>
            #include <queue>
            #include <random>
            #include <set>
            #include <stack>
            #include <string>
            #include <unordered_map>
            #include <unordered_set>
            #include <vector>

            #define all(x) (x).begin(), (x).end()
            #define rall(x) (x).rend(), (x).rbegin()
            #define mod 1e9 + 7
            #define pii pair<int, int>
            #define vi vector<int>

            typedef long double ld;
            typedef long long ll;

            using namespace std;

            void solve() {{
              {}
            }}

            int main() {{
              cin.tie(nullptr)->sync_with_stdio(false);

              int cases;
              cin >> cases;

              while (cases--)
                  solve();
            }}
        ]],
            { i(1) }
        )
    ),
    s('pr', fmt('std::cout << {}', { i(1) })),
}
