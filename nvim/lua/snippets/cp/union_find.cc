template <typename T>
struct union_find {
 public:
  explicit union_find(size_t capacity) : par(capacity, 0), rank(capacity, 0) {
    std::iota(par.begin(), par.end(), 0);
  };

  void join(T u, T v) noexcept {
    u = find(u), v = find(v);

    if (u == v)
      return;

    if (rank[u] < rank[v])
      std::swap(u, v);

    if (rank[u] == rank[v])
      ++rank[u];

    par[v] = u;
  }

  [[nodiscard]] T find(T const& u) noexcept {
    if (u != par[u])
      par[u] = find(par[u]);
    return par[u];
  }

  std::vector<T> par;
  std::vector<int> rank;
};
