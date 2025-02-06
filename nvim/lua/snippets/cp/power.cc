long long power(long long a, long long b,
                long long mod = std::numeric_limits<long long>::max()) {
  long long ans = 1;
  a %= mod;
  while (b > 0) {
    if (b & 1) {
      ans *= a;
      ans %= mod;
    }
    a *= a;
    a %= mod;
    b >>= 1;
  }
  return ans;
}
