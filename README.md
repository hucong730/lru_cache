# flutter_lru_cache

一个简单高效的 LRU（Least Recently Used，最近最少使用）缓存实现，适用于 Dart 和 Flutter。基于 `LinkedHashMap`，读写均为 O(1) 时间复杂度；当缓存满时，自动淘汰最久未使用的条目。

## 安装

```bash
dart pub add flutter_lru_cache
```

或在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  flutter_lru_cache: ^1.0.4
```

## 使用示例

```dart
import 'package:flutter_lru_cache/lru_cache.dart';

void main() {
  final lruCache = LRUCache<int, String>(3);

  lruCache[1] = "A";
  lruCache[2] = "B";
  lruCache[3] = "C";
  print(lruCache); // {1: A, 2: B, 3: C}

  print(lruCache[1]); // 访问 key=1，将其移动到最近使用的位置
  lruCache[4] = "D"; // 缓存已满，淘汰最久未使用的 key=2
  print(lruCache); // {3: C, 1: A, 4: D}
}
```

## API

| 成员 | 说明 |
| --- | --- |
| `LRUCache(capacity)` | 创建容量为 `capacity` 的缓存，`capacity` 必须为正整数 |
| `cache[key]` | 读取条目；存在则标记为最近使用，不存在返回 `null` |
| `cache[key] = value` | 写入/更新条目；缓存满时淘汰最久未使用的条目 |
| `remove(key)` | 删除条目并返回其值，不存在返回 `null` |
| `clear()` | 清空缓存 |
| `isEmpty` / `isNotEmpty` | 缓存是否为空 / 非空 |
| `length` | 当前条目数 |
| `containsKey(key)` | 是否包含 key（不改变使用顺序） |
| `keys()` / `values()` | 按最久未使用 → 最近使用的顺序返回所有 key / value |

## 许可证

MIT
