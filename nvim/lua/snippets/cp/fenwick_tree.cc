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
    throw std::logic_error("must implement fenwick_tree::merge");
  }

  [[nodiscard]] T unmerge(T const& x, T const& y) const noexcept {
    throw std::logic_error("must implement fenwick_tree::unmerge");
  }

  [[nodiscard]] T sentinel() const noexcept {
    throw std::logic_error("must implement fenwick_tree::sentinel");
  }

  [[nodiscard]] size_t g(size_t i) const noexcept {
    return i | (i + 1);
  }

  [[nodiscard]] size_t h(size_t i) const noexcept {
    return i & (i + 1);
  }

  std::vector<T> tree;
};
