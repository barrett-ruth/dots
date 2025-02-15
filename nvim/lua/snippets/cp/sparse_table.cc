template <typename T>
struct sparse_table {
  sparse_table(std::vector<T> const& ts)
      : table(floor(__lg(max(1, static_cast<int>(ts.size())))) + 1,
              std::vector<T>(ts.size())) {
    for (size_t i = 0; i < ts.size(); ++i) {
      table[0][i] = ts[i];
    }

    for (size_t j = 1; j < table.size(); ++j) {
      for (size_t i = 0; i + (1 << (j - 1)) < ts.size(); ++i) {
        table[j][i] = merge(table[j - 1][i], table[j - 1][i + (1 << (j - 1))]);
      }
    }
  }

  [[nodiscard]] T query(size_t const l, size_t const r) const {
    if (!(0 <= l && r < table[0].size())) {
      throw std::out_of_range(
          std::format("cannot query sparse table of size {} at range [{}, {}]",
                      table[0].size(), l, r));
    }

    int k = floor(__lg(r - l + 1));
    return merge(table[k][l], table[k][r - (1 << k) + 1]);
  }

 private:
  [[nodiscard]] T merge(T const& x, T const& y) const noexcept {
    throw std::logic_error("implement sparse_table::merge");
  }

  std::vector<std::vector<T>> table;
};
