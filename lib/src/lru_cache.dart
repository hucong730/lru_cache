import 'dart:collection';

/// 实现一个简单的 LRU 缓存
class LRUCache<K, V> {
  final int capacity;

  final LinkedHashMap<K, V> _cache = LinkedHashMap<K, V>();

  LRUCache(this.capacity);

  V? operator [](K key) {
    if (!_cache.containsKey(key)) return null;

    // 如果访问了某个key，将其移动到链表的末尾（表示最近使用）
    final value = _cache.remove(key);
    _cache[key] = value as V;
    return value;
  }

  void operator []=(K key, V value) {
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    } else if (_cache.length >= capacity) {
      // 如果缓存已满，移除最久未使用的元素（第一个元素）
      _cache.remove(_cache.keys.first);
    }

    // 将新元素添加到末尾
    _cache[key] = value;
  }

  V? remove(K key) => _cache.remove(key);

  void clear() => _cache.clear();

  bool get isEmpty => _cache.isEmpty;

  int get length => _cache.length;

  bool containsKey(K key) => _cache.containsKey(key);

  Iterable<K> keys() => _cache.keys;

  Iterable<V> values() => _cache.values;

  @override
  String toString() => _cache.toString();

  @override
  int get hashCode {
    // 结合容量和 _cache 内容计算哈希值
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

    // 如果容量不同，视为不相等
    if (other.capacity != capacity) return false;

    // 比较_cache内容
    if (other._cache.length != _cache.length) return false;

    for (final key in _cache.keys) {
      if (other._cache[key] != _cache[key]) return false;
    }

    return true;
  }
}
