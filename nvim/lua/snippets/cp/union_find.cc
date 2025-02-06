struct union_find {
 public:
  union_find(size_t n) : par(n + 1), rank(n + 1, 0) {
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

  std::vector<int> par;
  std::vector<int> rank;
};
