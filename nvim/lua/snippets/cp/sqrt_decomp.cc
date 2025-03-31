#include <cmath>
#include <stdexcept>
#include <vector>

template <typename T>
class sqrt_decomp {
 public:
  explicit sqrt_decomp(std::vector<T> const& data)
      : data(data),
        block_size(static_cast<int>(std::sqrt(data.size()))),
        blocks((data.size() + block_size - 1) / block_size, sentinel()) {
    for (size_t i = 0; i < data.size(); ++i) {
      blocks[i / block_size] = merge(blocks[i / block_size], data[i]);
    }
  }

  void update(int i, T t) noexcept {
    int b = i / block_size;
    blocks[b] = unmerge(blocks[b], data[i]);
    data[i] = t;
    blocks[b] = merge(blocks[b], data[i]);
  }

  [[nodiscard]] T query(int l, int r) const noexcept {
    T res = sentinel();
    while (l <= r && l % block_size != 0)
      res = merge(res, data[l++]);
    while (l + block_size - 1 <= r)
      res = merge(res, blocks[l / block_size]), l += block_size;
    while (l <= r)
      res = merge(res, data[l++]);
    return res;
  }

 private:
  std::vector<T> data, blocks;
  int block_size;

  [[nodiscard]] virtual T merge(T a, T b) const {
    throw std::logic_error("must implement sqrt_decomp::merge");
  }

  [[nodiscard]] virtual T unmerge(T a, T b) const {
    throw std::logic_error("must implement sqrt_decomp::unmerge");
  }

  [[nodiscard]] virtual T sentinel() const {
    throw std::logic_error("must implement sqrt_decomp::sentinel");
  }
};
