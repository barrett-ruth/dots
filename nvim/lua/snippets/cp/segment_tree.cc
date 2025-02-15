template <typename T>
struct segment_tree {
 public:
  explicit segment_tree(std::vector<T> const& ts) : n(ts.size()) {
    tree.resize(4 * n);
    build(1, 0, n - 1, ts);
  }

  [[nodiscard]] T const query(size_t const l, size_t const r) const {
    if (!(0 <= l && r < n)) {
      throw std::out_of_range(std::format(
          "cannot query segment tree of size {} at range [{}, {}]", n, l, r));
    }

    return query(1, 0, n - 1, l, r);
  }

  // TODO: update range

  void update(int i, T const& t) noexcept {
    if (!(0 <= i && i < n)) {
      throw std::out_of_range(std::format(
          "cannot update segment tree of size {} at index {}", n, i));
    }

    update(1, 0, n - 1, i, t);
  }

 private:
  T const sentinel() const noexcept {
    throw std::logic_error("implement segment_tree::sentinel");
  }

  T const merge(T const& x, T const& y) const noexcept {
    throw std::logic_error("implement segment_tree::merge");
  }

  void build(size_t const node, size_t const l, size_t const r,
             std::vector<T> const& ts) noexcept {
    if (l == r) {
      tree[node] = ts[l];
    } else {
      int m = l + (r - l) / 2;
      build(2 * node, l, m, ts);
      build(2 * node + 1, m + 1, r, ts);
      tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
  }

  [[nodiscard]] T query(size_t const node, size_t const lower,
                        size_t const upper, size_t const l,
                        size_t const r) const noexcept {
    if (upper < l || r < lower) {
      return sentinel();
    }

    if (l <= lower && upper <= r) {
      return tree[node];
    }

    size_t m = lower + (upper - lower) / 2;

    return merge(query(2 * node, lower, m, l, r),
                 query(2 * node + 1, m + 1, upper, l, r));
  }

  void update(size_t const node, size_t const l, size_t const r, size_t const i,
              T const& t) noexcept {
    if (l == r) {
      tree[node] = t;
    } else {
      size_t m = l + (r - l) / 2;
      if (i <= m) {
        update(2 * node, l, m, i, t);
      } else {
        update(2 * node + 1, m + 1, r, i, t);
      }
      tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
  }

  size_t n;
  std::vector<T> tree;
};

