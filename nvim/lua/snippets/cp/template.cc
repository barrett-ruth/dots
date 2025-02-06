#include <bits/stdc++.h>

// https://codeforces.com/blog/entry/96344

#pragma GCC optimize("O2,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")

using namespace std;

template <typename... Args>
void pr(std::string const &str, Args &&...args) {
  std::cout << std::vformat(str, std::make_format_args(args...));
}

template <typename T>
void pr(T const &t) {
  std::cout << t;
}

template <std::ranges::range T>
void pr(T const &t) {
  if constexpr (std::is_convertible_v<T, char const *>) {
    std::cout << t;
  } else {
    for (auto const &e : t) {
      cout << e << ' ';
    }
  }
}

template <std::ranges::range T>
void prln(T const &t) {
  pr(t);
  std::cout << '\n';
}

void prln() {
  std::cout << '\n';
}

template <typename... Args>
void prln(std::string const &str, Args &&...args) {
  pr(str, std::forward<Args>(args)...);
  std::cout << '\n';
}

template <typename T>
void prln(T const &t) {
  pr(t);
  std::cout << '\n';
}

template <typename T>
constexpr T MIN = std::numeric_limits<T>::min();

template <typename T>
constexpr T MAX = std::numeric_limits<T>::max();

template <typename T>
static T sc(auto &&x) {
  return static_cast<T>(x);
}

#define ff first
#define ss second
#define eb emplace_back
#define pb push_back
#define ll long long
#define ld long double
#define vec vector
#define endl '\n'

#define all(x) (x).begin(), (x).end()
#define rall(x) (r).rbegin(), (x).rend()
#define sz(x) static_cast<int>((x).size())
#define FOR(a, b, c) for (long long a = (b); (a) < (c); ++a)
#define ROF(a, b, c) for (long long a = (b); (a) > (c); --a)
