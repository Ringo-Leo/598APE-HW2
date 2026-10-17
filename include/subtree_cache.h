#pragma once

#include <cstddef>
#include <string>
#include <unordered_map>
#include <vector>

struct SubTreeEntry {
  std::vector<float> out;
  int last = 0;
  bool ready = false;
};

struct SubTreeCache {
  std::unordered_map<std::string, SubTreeEntry> cache;
  int cur = 0;
  size_t bytes = 0;
  size_t budget = size_t(512) << 20;
  static constexpr int MIN_SIZE = 4;
};
