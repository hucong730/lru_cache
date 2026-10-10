import 'dart:collection';

/// A simple LRU (Least Recently Used) cache with a fixed [capacity].
///
/// Reads ([operator []]) and writes ([operator []=]) both run in O(1) time.
/// When the cache is full, inserting a new entry evicts the least recently
/// used entry.
///
/// Note that this is a mutable object: [hashCode] is computed from the
/// current entries and changes as the cache is modified, so instances are
/// not suitable as keys in a [Map] or elements in a [Set].
class LRUCache<K, V> {
  /// The maximum number of entries the cache can hold.
  final int capacity;

  final LinkedHashMap<K, V> _cache = LinkedHashMap<K, V>();

  /// Creates an LRU cache that holds at most [capacity] entries.
  ///
  /// Throws an [ArgumentError] if [capacity] is not a positive integer.
  LRUCache(this.capacity) {
    if (capacity <= 0) {
      throw ArgumentError.value(capacity, 'capacity', 'must be positive');
    }
  }

  /// Returns the value for [key], or `null` if [key] is not in the cache.
  ///
  /// Accessing an existing key marks it as the most recently used entry.
  V? operator [](K key) {
    if (!_cache.containsKey(key)) return null;

    // Move the accessed entry to the end (most recently used position).
    final value = _cache.remove(key);
    _cache[key] = value as V;
    return value;
  }

  /// Associates [value] with [key].
  ///
  /// If [key] is already present, its value is updated and it becomes the
  /// most recently used entry. Otherwise, if the cache is full, the least
  /// recently used entry is evicted before the new entry is inserted.
  void operator []=(K key, V value) {
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    } else if (_cache.length >= capacity) {
      // The cache is full: evict the least recently used entry (the first).
      _cache.remove(_cache.keys.first);
    }

    _cache[key] = value;
  }

  /// Removes the entry for [key] and returns its value, or `null` if [key]
  /// is not in the cache.
  V? remove(K key) => _cache.remove(key);

  /// Removes all entries from the cache.
  void clear() => _cache.clear();

  /// Whether the cache contains no entries.
  bool get isEmpty => _cache.isEmpty;

  /// Whether the cache contains at least one entry.
  bool get isNotEmpty => _cache.isNotEmpty;

  /// The number of entries currently in the cache.
  int get length => _cache.length;

  /// Whether the cache contains an entry for [key].
  ///
  /// Unlike [operator []], this does not change the entry's position in
  /// the usage order.
  bool containsKey(K key) => _cache.containsKey(key);

  /// The keys of the cache, ordered from least to most recently used.
  Iterable<K> keys() => _cache.keys;

  /// The values of the cache, ordered from least to most recently used.
  Iterable<V> values() => _cache.values;

  @override
  String toString() => _cache.toString();

  @override
  int get hashCode {
    int hash = capacity.hashCode;
    for (final entry in _cache.entries) {
      hash = hash * 31 + entry.key.hashCode;
      hash = hash * 31 + entry.value.hashCode;
    }
    return hash;
  }

  @override
  bool operator ==(Object other) {
    if (other is! LRUCache<K, V>) return false;

    if (other.capacity != capacity) return false;
    if (other._cache.length != _cache.length) return false;

    for (final key in _cache.keys) {
      if (!other._cache.containsKey(key) || other._cache[key] != _cache[key]) {
        return false;
      }
    }

    return true;
  }
}
