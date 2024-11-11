# lru_cache
flutter/dart LRU缓存

```dart

final lruCache = LRUCache<int, String>(3);

lruCache[1] = "A";
lruCache[2] = "B";
lruCache[3] = "C";
print(lruCache);

print(lruCache[1]); // 访问key=1，将其移动到最近使用的位置
lruCache[4] = "D"; // 添加新的元素，触发移除最久未使用的元素
print(lruCache);

```

