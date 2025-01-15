template <typename T> struct sparse_table {
  sparse_table(std::vector<T> const &ts, std::function<T(T, T)> f)
      : f(f), st(floor(log2(ts.size()) + 1), std::vector<int>(ts.size())) {
    for (size_t i = 0; i < ts.size(); ++i) {
      st[0][i] = ts[i];
    }

    for (size_t j = 1; (1 << j) <= ts.size(); ++j) {
      for (size_t i = 0; i + (1 << j) - 1 < ts.size(); ++i) {
        st[j][i] = f(st[j - 1][i], st[j - 1][i + (1 << (j - 1))]);
      }
    }
  }

  [[nodiscard]] T query(int const l, int const r) const noexcept {
    int k = floor(log2(r - l + 1));
    return f(st[k][l], st[k][r - (1 << k) + 1]);
  }

  void update(size_t const i, T const &t) noexcept {
    st[0][i] = t;

    for (size_t j = 1; (1 << j) <= st[0].size(); ++j) {
      st[j][i] = f(st[j - 1][i], st[j - 1][i + (1 << (j - 1))]);
    }
  }

  std::vector<std::vector<T>> st;
  std::function<T(T, T)> f;
};
