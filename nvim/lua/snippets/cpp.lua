local cppsnippets = {}

for _, snippet in ipairs({
    s('in', fmt('#include {}', { i(1) })),
    s(
        'main',
        fmt(
            [[#include <iostream>

int main() {{
  {}

  return 0;
}}]],
            { i(1) }
        )
    ),
    s('pr', fmt('std::cout << {}', { i(1) })),
    s('s', fmt('std::{}', { i(1) })),
    s(
        'pbds',
        fmt([[
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>

namespace pbds = __gnu_pbds;

template <class T>
using hashset = pbds::gp_hash_table<T, pbds::null_type>;

template <class K, class V>
using hashmap = pbds::gp_hash_table<K, V>;

template <class K, class V>
using multitreemap =
    pbds::tree<K, V, less_equal<K>, pbds::rb_tree_tag,
               pbds::tree_order_statistics_node_update>;

template <class T>
using treeset =
    pbds::tree<T, pbds::null_type, less<T>, pbds::rb_tree_tag,
               pbds::tree_order_statistics_node_update>;

template <class K, class V>
using treemap =
    pbds::tree<K, V, less<K>, pbds::rb_tree_tag,
               pbds::tree_order_statistics_node_update>;

template <class T>
using treemultiset =
    pbds::tree<T, pbds::null_type, less_equal<T>, pbds::rb_tree_tag,
               pbds::tree_order_statistics_node_update>;
    ]], {})
    ),
}) do
    table.insert(cppsnippets, snippet)
end

return cppsnippets
