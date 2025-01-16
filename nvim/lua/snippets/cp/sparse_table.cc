template <typename T, typename F> struct sparse_table {
  sparse_table(std::vector<T> const &ts, F const& f)
      : f(f), st(floor(__lg(max(1, static_cast<int>(ts.size())))) + 1,
                 std::vector<std::invoke_result_t<F, T, T>>(ts.size())) {
    for (size_t i = 0; i < ts.size(); ++i) {
      st[0][i] = ts[i];
    }

    for (size_t j = 1; j < st.size(); ++j) {
      for (size_t i = 0; i + (1 << (j - 1)) < ts.size(); ++i) {
        st[j][i] = f(st[j - 1][i], st[j - 1][i + (1 << (j - 1))]);
      }
    }
  }

  [[nodiscard]] T query(int const l, int const r) const noexcept {
    int k = floor(__lg(r - l + 1));
    return f(st[k][l], st[k][r - (1 << k) + 1]);
  }

  F f;
  std::vector<std::vector<std::invoke_result_t<F, T, T>>> st;
};
