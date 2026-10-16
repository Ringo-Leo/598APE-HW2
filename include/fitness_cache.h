#pragma once

#include <cstddef>
#include <cstdint>
#include <functional>
#include <unordered_map>
#include <vector>

namespace genetic{

struct ProgramKeyHash{
    std::size_t operator()(const std::vector<uint32_t> &key) const{
        std::size_t hash = 0;
        for (uint32_t value: key) {
            hash ^= std::hash<uint32_t>{}(value) + 0x9e3779b9u + (hash << 6) + (hash >> 2);
        }
        return hash;
    }
};

using FitnessCache = std::unordered_map<std::vector<uint32_t>, float, ProgramKeyHash>;

}