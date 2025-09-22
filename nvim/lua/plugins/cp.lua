local template = [=[#include <bits/stdc++.h>  // {{{{{{

#include <version>
#ifdef __cpp_lib_ranges_enumerate
#include <ranges>
namespace rv = std::views;
namespace rs = std::ranges;
#endif

// https://codeforces.com/blog/entry/96344

#pragma GCC optimize("O2,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")

using namespace std;

using i16 = int16_t;
using u16 = uint16_t;
using i32 = int32_t;
using u32 = uint32_t;
using i64 = int64_t;
using u64 = uint64_t;
using f64 = double;
using f128 = long double;

#if __cplusplus >= 202002L
template <typename T>
constexpr T MIN = std::numeric_limits<T>::min();

template <typename T>
constexpr T MAX = std::numeric_limits<T>::max();

template <typename T>
[[nodiscard]] static T sc(auto&& x) {{
  return static_cast<T>(x);
}}

template <typename T>
[[nodiscard]] static T sz(auto&& x) {{
  return static_cast<T>(x.size());
}}
#endif

static void NO() {{
  std::cout << "NO\n";
}}

static void YES() {{
  std::cout << "YES\n";
}}

template <typename T>
using vec = std::vector<T>;

#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define ff first
#define ss second

#ifdef LOCAL
#define db(...) std::print(__VA_ARGS__)
#define dbln(...) std::println(__VA_ARGS__)
#else
#define db(...)
#define dbln(...)
#endif
//  }}}}}}]=]

return {
    'barrett-ruth/cp.nvim',
    command = 'CP',
    dependencies = {
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local ls = require('luasnip')
        local s, i, fmt =
            ls.snippet, ls.insert_node, require('luasnip.extras.fmt').fmt

        local default_cpp = {
            compile = {
                'g++',
                '-fdiagnostics-color=always',
                '-std=c++{version}',
                '-pedantic-errors',
                '-O2',
                '-Wall',
                '-Wextra',
                '-Wpedantic',
                '-Wshadow',
                '-Wformat=2',
                '-Wfloat-equal',
                '-Wlogical-op',
                '-Wshift-overflow=2',
                '-Wnon-virtual-dtor',
                '-Wold-style-cast',
                '-Wcast-qual',
                '-Wuseless-cast',
                '-Wno-sign-promotion',
                '-Wcast-align',
                '-Wunused',
                '-Woverloaded-virtual',
                '-Wconversion',
                '-Wmisleading-indentation',
                '-Wduplicated-cond',
                '-Wduplicated-branches',
                '-Wnull-dereference',
                '-Wformat-overflow',
                '-Wformat-truncation',
                '-Wdouble-promotion',
                '-Wundef',
                '-DLOCAL',
                '{source}',
                '-o',
                '{binary}',
            },
            test = { '{binary}' },
            debug = {
                'g++',
                '-std=c++{version}',
                '-g3',
                '-fsanitize=address,undefined',
                '-fsanitize=float-divide-by-zero',
                '-fsanitize=float-cast-overflow',
                '-fno-sanitize-recover=all',
                '-fstack-protector-all',
                '-fstack-usage',
                '-fno-omit-frame-pointer',
                '-fno-inline',
                '-ffunction-sections',
                '-D_GLIBCXX_DEBUG',
                '-D_GLIBCXX_DEBUG_PEDANTIC',
                '-DLOCAL',
                '{source}',
                '-o',
                '{binary}',
            },
            version = 20,
            extension = 'cc',
        }

        local default_python = {
            test = { '{source}' },
            debug = { '{source}' },
            executable = 'python3',
            extension = 'py',
        }

        require('cp').setup({
            contests = {
                codeforces = {
                    cpp = vim.tbl_extend(
                        'force',
                        default_cpp,
                        { version = 23, extension = 'cc' }
                    ),
                    python = default_python,
                    default_language = 'python',
                },
                atcoder = {
                    cpp = vim.tbl_extend(
                        'force',
                        default_cpp,
                        { version = 23 }
                    ),
                    python = default_python,
                    default_language = 'cpp',
                },
                cses = {
                    cpp = vim.tbl_extend(
                        'force',
                        default_cpp,
                        { version = 20 }
                    ),
                    python = default_python,
                    default_language = 'cpp',
                },
            },
            picker = 'fzf-lua',
            hooks = {
                before_run = function(ctx)
                    vim.lsp.buf.format({ async = true })
                    vim.cmd.wall()
                end,
                setup_code = function(ctx)
                    vim.api.nvim_set_option_value(
                        'winbar',
                        '',
                        { scope = 'local' }
                    )
                    vim.api.nvim_set_option_value(
                        'foldlevel',
                        0,
                        { scope = 'local' }
                    )
                    vim.api.nvim_set_option_value(
                        'foldmethod',
                        'marker',
                        { scope = 'local' }
                    )
                    vim.api.nvim_set_option_value(
                        'foldmarker',
                        '{{{,}}}',
                        { scope = 'local' }
                    )
                    vim.api.nvim_set_option_value(
                        'foldtext',
                        '',
                        { scope = 'local' }
                    )
                    vim.diagnostic.enable(false)
                end,
            },
            snippets = {
                s(
                    'cp.nvim/codeforces.cpp',
                    fmt(template .. [=[


void solve() {{
  {}
}}

int main() {{  // {{{{{{
  std::cin.exceptions(std::cin.failbit);

#ifdef LOCAL
  std::cerr.rdbuf(std::cout.rdbuf());
  std::cout.setf(std::ios::unitbuf);
  std::cerr.setf(std::ios::unitbuf);
#else
  std::cin.tie(nullptr)->sync_with_stdio(false);
#endif

  u32 tc = 1;
  std::cin >> tc;

  for (u32 t = 0; t < tc; ++t) {{
    solve();
  }}

  return 0;
}}
// }}}}}}]=], { i(1) })
                ),
                s(
                    'cp.nvim/atcoder.cpp',
                    fmt(template .. [=[


void solve() {{
  {}
}}

int main() {{  // {{{{{{
  std::cin.exceptions(std::cin.failbit);

#ifdef LOCAL
  std::cerr.rdbuf(std::cout.rdbuf());
  std::cout.setf(std::ios::unitbuf);
  std::cerr.setf(std::ios::unitbuf);
#else
  std::cin.tie(nullptr)->sync_with_stdio(false);
#endif

  solve();

  return 0;

}}
// }}}}}}]=], { i(1) })
                ),
                s(
                    'cp.nvim/cses.cpp',
                    fmt(template .. [=[


void solve() {{
  {}
}}

int main() {{  // {{{{{{
  std::cin.exceptions(std::cin.failbit);

#ifdef LOCAL
  std::cerr.rdbuf(std::cout.rdbuf());
  std::cout.setf(std::ios::unitbuf);
  std::cerr.setf(std::ios::unitbuf);
#else
  std::cin.tie(nullptr)->sync_with_stdio(false);
#endif

  solve();

  return 0;
}}
// }}}}}}]=], { i(1) })
                ),
            },
        })
    end,
}
