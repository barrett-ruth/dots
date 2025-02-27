template <typename T>
struct union_find {
 public:
  explicit union_find(size_t capacity) : rank(capacity, 0) {};

  void join(T const& u, T const& v) noexcept {
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

 private:
  [[nodiscard]] inline T sentinel() const noexcept {
    throw std::logic_error("must implement union_find::sentinel");
  }

  std::unordered_map<T, T> par;
  std::vector<int> rank;
};
