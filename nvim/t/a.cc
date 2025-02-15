#include <bits/stdc++.h>  // {{{

// https://codeforces.com/blog/entry/96344

#pragma GCC optimize("O2,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")

using namespace std;

template <typename T>
constexpr T MIN = std::numeric_limits<T>::min();

template <typename T>
constexpr T MAX = std::numeric_limits<T>::max();

template <typename T>
[[nodiscard]] static T sc(auto&& x) {
  return static_cast<T>(x);
}

template <typename T>
[[nodiscard]] static T sz(auto&& x) {
  return static_cast<T>(x.size());
}

template <typename... Args>
void pr(std::format_string<Args...> fmt, Args&&... args) {
  std::print(fmt, std::forward<Args>(args)...);
}

template <typename... Args>
void pr(std::format_string<Args...> fmt) {
  std::print(fmt);
}

template <typename... Args>
void prln(std::format_string<Args...> fmt, Args&&... args) {
  std::println(fmt, std::forward<Args>(args)...);
}

template <typename... Args>
void prln(std::format_string<Args...> fmt) {
  std::println(fmt);
}

void prln() {
  std::println();
}

void prln(auto const& t) {
  std::println("{}", t);
}

using ll = long long;
using ld = long double;
template <typename T>
using vec = std::vector<T>;
template <typename T, size_t N>
using arr = std::array<T, N>;

#define ff first
#define ss second
#define eb emplace_back
#define pb push_back
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
//  }}}

template <typename T>
struct fenwick_tree {
 public:
  explicit fenwick_tree(std::vector<T> const& ts) : tree(ts.size()) {
    for (size_t i = 0; i < ts.size(); ++i) {
      tree[i] = ts[i];
    }
    for (size_t i = 0; i < tree.size(); ++i) {
      size_t j = g(i);
      if (j < tree.size()) {
        tree[j] += tree[i];
      }
    }
  }

  T const query(size_t i) const {
    if (!(0 <= i && i < tree.size())) {
      throw std::out_of_range(std::format(
          "cannot query fenwick tree of size {} at index {}", tree.size(), i));
    }

    T t = sentinel();

    for (int j = static_cast<int>(i); j >= 0; j = h(j) - 1) {
      t = merge(t, tree[j]);
    }

    return t;
  };

  T const query(size_t l, size_t r) const {
    if (!(0 <= l && r < tree.size())) {
      throw std::out_of_range(
          std::format("cannot query fenwick tree of size {} at range [{}, {}]",
                      tree.size(), l, r));
    }

    if (l == 0) {
      return query(r);
    }

    return unmerge(query(r), query(l - 1));
  };

  void update(size_t i, T const& t) noexcept {
    assert(0 <= i && t < tree.size());

    for (size_t j = i; j < tree.size(); j = g(j)) {
      tree[j] = merge(tree[j], t);
    }
  }

 private:
  [[nodiscard]] T merge(T const& x, T const& y) const noexcept {
    return x + y;
  }

  [[nodiscard]] T unmerge(T const& x, T const& y) const noexcept {
    return x - y;
  }

  [[nodiscard]] T sentinel() const noexcept {
    return 0;
  }

  [[nodiscard]] size_t g(size_t i) const noexcept {
    return i | (i + 1);
  }

  [[nodiscard]] size_t h(size_t i) const noexcept {
    return i & (i + 1);
  }

  std::vector<T> tree;
};

void solve() {
  int n;
  cin >> n;
  vec<int> a(n);
  for (auto& e : a)
    cin >> e;

  fenwick_tree<int> st(a);
  cout << st.query(1, 2);
}

int main() {  // {{{
  cin.tie(nullptr)->sync_with_stdio(false);

  int t = 1;
  cin >> t;

  while (t--) {
    solve();
  }

  return 0;
}
// }}}
