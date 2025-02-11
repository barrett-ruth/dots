struct union_find {
 public:
  union_find(size_t capacity) : par(capacity), rank(capacity, 0) {
    std::iota(par.begin(), par.end(), 0);
  };

  void join(int u, int v) {
    u = find(u), v = find(v);

    if (u == v)
      return;

    if (rank[u] < rank[v])
      std::swap(u, v);

    if (rank[u] == rank[v])
      ++rank[u];

    par[v] = u;
  }

  int find(int u) {
    if (u != par[u])
      par[u] = find(par[u]);
    return par[u];
  }

  void resize(size_t capacity) {
    par.assign(capacity, 0);
    std::iota(par.begin(), par.end(), 0);
    rank.assign(capacity, 0);
  }

  std::vector<int> par;
  std::vector<int> rank;
};
