import 'package:flutter_lru_cache/lru_cache.dart';

void main() {
  // Create a cache that holds at most 3 entries.
  final cache = LRUCache<int, String>(3);

  // Write entries with operator []=.
  cache[1] = 'A';
  cache[2] = 'B';
  cache[3] = 'C';
  print(cache); // {1: A, 2: B, 3: C}

  // Reading an entry marks it as the most recently used.
  print(cache[1]); // A
  print(cache.keys().toList()); // [2, 3, 1]

  // The cache is full: inserting a new entry evicts the least
  // recently used one (key 2).
  cache[4] = 'D';
  print(cache); // {3: C, 1: A, 4: D}
  print(cache.containsKey(2)); // false

  // Updating an existing key refreshes its position and never
  // grows the cache beyond its capacity.
  cache[3] = 'C2';
  print(cache.keys().toList()); // [1, 4, 3]
  print(cache.length); // 3

  // Reading a missing key returns null.
  print(cache[42]); // null

  // containsKey checks existence without changing the usage order.
  print(cache.containsKey(1)); // true
  print(cache.keys().toList()); // [1, 4, 3]

  // Remove an entry explicitly; removing a missing key returns null.
  print(cache.remove(4)); // D
  print(cache.remove(42)); // null
  print(cache.length); // 2

  // Inspect the cache state.
  print(cache.isEmpty); // false
  print(cache.isNotEmpty); // true
  print(cache.keys().toList()); // [1, 3]
  print(cache.values().toList()); // [A, C2]

  // Iterate over the entries in usage order (least to most recent).
  // Copy the keys first, because reading entries reorders the cache.
  for (final key in cache.keys().toList()) {
    print('$key -> ${cache[key]}');
  }

  // Clear everything.
  cache.clear();
  print(cache.isEmpty); // true
  print(cache.length); // 0

  // The capacity must be a positive integer.
  try {
    LRUCache<int, String>(0);
  } on ArgumentError catch (e) {
    print('Invalid capacity: ${e.message}');
  }
}
