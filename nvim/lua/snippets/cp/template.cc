#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>

#pragma GCC optimize("O2,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")

using namespace std;
using namespace __gnu_pbds;

// https://mirror.codeforces.com/blog/entry/124683

namespace hashing {
using i64 = std::int64_t;
using u64 = std::uint64_t;
static const u64 FIXED_RANDOM =
    std::chrono::steady_clock::now().time_since_epoch().count();

#if USE_AES
std::mt19937 rd(FIXED_RANDOM);
const __m128i KEY1{(i64)rd(), (i64)rd()};
const __m128i KEY2{(i64)rd(), (i64)rd()};
#endif

template <class T, class D = void> struct custom_hash {};

template <class T> inline void hash_combine(u64 &seed, T const &v) {
  custom_hash<T> hasher;
  seed ^= hasher(v) + 0x9e3779b97f4a7c15 + (seed << 12) + (seed >> 4);
};

template <class T>
struct custom_hash<T,
                   typename std::enable_if<std::is_integral<T>::value>::type> {
  u64 operator()(T _x) const {
    u64 x = _x;
#if USE_AES
    __m128i m{i64(u64(x) * 0xbf58476d1ce4e5b9u64), (i64)FIXED_RANDOM};
    __m128i y = _mm_aesenc_si128(m, KEY1);
    __m128i z = _mm_aesenc_si128(y, KEY2);
    return z[0];
#else
    x += 0x9e3779b97f4a7c15 + FIXED_RANDOM;
    x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;
    x = (x ^ (x >> 27)) * 0x94d049bb133111eb;
    return x ^ (x >> 31);
#endif
  }
};

template <class T>
struct custom_hash<T, std::void_t<decltype(std::begin(std::declval<T>()))>> {
  u64 operator()(T const &a) const {
    u64 value = FIXED_RANDOM;
    for (auto &x : a)
      hash_combine(value, x);
    return value;
  }
};

template <class... T> struct custom_hash<std::tuple<T...>> {
  u64 operator()(const std::tuple<T...> &a) const {
    u64 value = FIXED_RANDOM;
    std::apply([&value](T const &...args) { (hash_combine(value, args), ...); },
               a);
    return value;
  }
};

template <class T, class U> struct custom_hash<std::pair<T, U>> {
  u64 operator()(std::pair<T, U> const &a) const {
    u64 value = FIXED_RANDOM;
    hash_combine(value, a.first);
    hash_combine(value, a.second);
    return value;
  }
};
}; // namespace hashing

#ifdef PB_DS_ASSOC_CNTNR_HPP
template <class Key, class Value>
using hashmap = gp_hash_table<
    Key, Value, hashing::custom_hash<Key>, std::equal_to<Key>,
    direct_mask_range_hashing<>, linear_probe_fn<>,
    hash_standard_resize_policy<hash_exponential_size_policy<>,
                                hash_load_check_resize_trigger<>, true>>;
template <class Key>
using hashset = gp_hash_table<
    Key, null_type, hashing::custom_hash<Key>, std::equal_to<Key>,
    direct_mask_range_hashing<>, linear_probe_fn<>,
    hash_standard_resize_policy<hash_exponential_size_policy<>,
                                hash_load_check_resize_trigger<>, true>>;

#endif
#ifdef PB_DS_TREE_POLICY_HPP
template <typename T>
using multiset = tree<T, null_type, std::less_equal<T>, rb_tree_tag,
                      tree_order_statistics_node_update>;
template <class Key, class Value = null_type>
using rbtree = tree<Key, Value, std::less<Key>, rb_tree_tag,
                    tree_order_statistics_node_update>;
#endif

template <typename... Args> void print(std::string const &str, Args &&...args) {
  std::cout << std::vformat(str,
                            std::make_format_args(std::forward<Args>(args)...));
}

template <typename T> void print(T const &t) { std::cout << t; }

template <std::ranges::range T> void print(T const &t) {
  if constexpr (std::is_same_v<T, string> ||
                std::is_convertible_v<T, char const *>) {
    std::cout << t << '\n';
  } else {
    for (auto const &e : t) {
      std::cout << e << ' ';
    }
    std::cout << '\n';
  }
}

template <typename... Args>
void println(std::string const &str, Args &&...args) {
  print(str, std::forward<Args>(args)...);
  cout << '\n';
}

template <typename T> void println(T const &t) { print("{}\n", t); }

template <std::ranges::range T> void println(T const &t) {
  cout << t << '\n';
}

void println() { std::cout << '\n'; }

template <typename T> T MAX() { return std::numeric_limits<T>::max(); }

template <typename T> T MIN() { return std::numeric_limits<T>::min(); }

#define ff first
#define ss second
#define eb emplace_back
#define ll long long
#define ld long double
#define vec vector

#define all(x) (x).begin(), (x).end()
#define rall(x) (r).rbegin(), (x).rend()
#define sz(x) static_cast<int>((x).size())

#ifdef LOCAL
#define dbg(x) cout << __LINE__ << ": " << #x << "=<" << (x) << ">\n";
#else
#define dbg(x)
#endif

constexpr static int MOD = 1e9 + 7;
