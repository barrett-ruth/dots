local ls = require 'luasnip'

local fmt = require('luasnip.extras.fmt').fmt
local i, s = ls.i, ls.s

local c = require 'paqs.luasnippets.c'
local cpp = {
    s(
        'cp',
        fmt(
            [[
            #include <algorithm>
            #include <bitset>
            #include <climits>
            #include <iostream>
            #include <math.h>
            #include <queue>
            #include <stack>
            #include <string>
            #include <unordered_map>
            #include <vector>

            using namespace std;

            typedef long long ll;

            #define all(x) (x).begin(), (x).end()
            #define sz(x) (int)(x).size()

            #define eb emplace_back
            #define mp make_pair
            #define pii pair<int, int>
            #define vi vector<int>

            #define mod 10e9 + 7

            void solve() {{
                {}
            }}

            int main() {{
                ios_base::sync_with_stdio(0);
                cin.tie(0);
                cout.tie(0);

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

ls.add_snippets('cpp', cpp)
ls.add_snippets('cpp', c)
