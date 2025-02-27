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

  T const query(int i) const {
    if (!(0 <= i && i < static_cast<int>(tree.size()))) {
      throw std::out_of_range("cannot query fenwick tree of size " +
                              std::to_string(tree.size()) + " at index " +
                              std::to_string(i));
    }

    T t = sentinel();

    for (int j = static_cast<int>(i); j >= 0; j = h(j) - 1) {
      t = merge(t, tree[j]);
    }

    return t;
  };

  T const query(int l, int r) const {
    if (!(0 <= l && l <= r && r < static_cast<int>(tree.size()))) {
      throw std::out_of_range(
          "cannot query fenwick tree of size " + std::to_string(tree.size()) +
          " at range [" + std::to_string(l) + ", " + std::to_string(r) + "]");
    }

    if (l == 0) {
      return query(r);
    }

    return unmerge(query(r), query(l - 1));
  };

  void update(int i, T const& t) noexcept {
    assert(0 <= i && i < static_cast<int>(tree.size()));

    for (size_t j = i; j < tree.size(); j = g(j)) {
      tree[j] = merge(tree[j], t);
    }
  }

 private:
  [[nodiscard]] inline T merge(T const& x, T const& y) const noexcept {
    throw std::logic_error("must implement fenwick_tree::merge");
  }

  [[nodiscard]] inline T unmerge(T const& x, T const& y) const noexcept {
    throw std::logic_error("must implement fenwick_tree::unmerge");
  }

  [[nodiscard]] inline T sentinel() const noexcept {
    throw std::logic_error("must implement fenwick_tree::sentinel");
  }

  [[nodiscard]] inline size_t g(size_t i) const noexcept {
    return i | (i + 1);
  }

  [[nodiscard]] inline size_t h(size_t i) const noexcept {
    return i & (i + 1);
  }

  std::vector<T> tree;
};
