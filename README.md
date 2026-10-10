# flutter_lru_cache

A simple and efficient LRU (Least Recently Used) cache implementation for Dart and Flutter. Built on `LinkedHashMap`, both reads and writes run in O(1) time. When the cache is full, the least recently used entry is evicted automatically.

## Features

- O(1) read and write operations
- Automatic eviction of the least recently used entry
- Pure Dart with zero dependencies: works on iOS, Android, Web, Windows, macOS and Linux

## Installation

```bash
dart pub add flutter_lru_cache
```

Or add it to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_lru_cache: ^1.0.5
```

## Usage

```dart
import 'package:flutter_lru_cache/lru_cache.dart';

void main() {
  final cache = LRUCache<int, String>(3);

  cache[1] = 'A';
  cache[2] = 'B';
  cache[3] = 'C';
  print(cache); // {1: A, 2: B, 3: C}

  print(cache[1]); // Reads key 1 and marks it as most recently used.
  cache[4] = 'D'; // The cache is full: evicts the least recently used entry (key 2).
  print(cache); // {3: C, 1: A, 4: D}
}
```

## API

| Member | Description |
| --- | --- |
| `LRUCache(capacity)` | Creates a cache holding at most `capacity` entries; `capacity` must be a positive integer |
| `cache[key]` | Reads an entry and marks it as most recently used; returns `null` if the key is missing |
| `cache[key] = value` | Writes or updates an entry; evicts the least recently used entry when the cache is full |
| `remove(key)` | Removes an entry and returns its value, or `null` if the key is missing |
| `clear()` | Removes all entries |
| `isEmpty` / `isNotEmpty` | Whether the cache is empty / not empty |
| `length` | The current number of entries |
| `containsKey(key)` | Whether the key exists, without changing the usage order |
| `keys()` / `values()` | All keys / values, ordered from least to most recently used |

See the [example](example/flutter_lru_cache_example.dart) for more use cases.

## License

MIT
