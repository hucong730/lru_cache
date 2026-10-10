import 'package:flutter_lru_cache/lru_cache.dart';
import 'package:test/test.dart';

void main() {
  group('LRUCache', () {
    test('stores and reads entries', () {
      final cache = LRUCache<int, String>(3);
      cache[1] = 'A';
      cache[2] = 'B';

      expect(cache[1], 'A');
      expect(cache[2], 'B');
      expect(cache[3], isNull);
      expect(cache.length, 2);
    });

    test('evicts the least recently used entry when full', () {
      final cache = LRUCache<int, String>(3);
      cache[1] = 'A';
      cache[2] = 'B';
      cache[3] = 'C';
      cache[4] = 'D';

      expect(cache.containsKey(1), isFalse);
      expect(cache.keys(), [2, 3, 4]);
      expect(cache.length, 3);
    });

    test('reading an entry marks it as most recently used', () {
      final cache = LRUCache<int, String>(3);
      cache[1] = 'A';
      cache[2] = 'B';
      cache[3] = 'C';

      cache[1]; // Refresh key 1.
      cache[4] = 'D'; // Should evict key 2 instead of key 1.

      expect(cache.keys(), [3, 1, 4]);
      expect(cache[1], 'A');
      expect(cache.containsKey(2), isFalse);
    });

    test('updating an existing key refreshes its position', () {
      final cache = LRUCache<int, String>(3);
      cache[1] = 'A';
      cache[2] = 'B';
      cache[3] = 'C';

      cache[1] = 'A2';
      cache[4] = 'D';

      expect(cache.keys(), [3, 1, 4]);
      expect(cache[1], 'A2');
    });

    test('containsKey does not change the usage order', () {
      final cache = LRUCache<int, String>(2);
      cache[1] = 'A';
      cache[2] = 'B';

      expect(cache.containsKey(1), isTrue);
      cache[3] = 'C';

      expect(cache.containsKey(1), isFalse);
      expect(cache.keys(), [2, 3]);
    });

    test('remove deletes the entry and returns its value', () {
      final cache = LRUCache<int, String>(3);
      cache[1] = 'A';
      cache[2] = 'B';

      expect(cache.remove(1), 'A');
      expect(cache.remove(99), isNull);
      expect(cache.containsKey(1), isFalse);
      expect(cache.length, 1);
    });

    test('clear empties the cache', () {
      final cache = LRUCache<int, String>(3);
      cache[1] = 'A';
      cache[2] = 'B';

      cache.clear();

      expect(cache.isEmpty, isTrue);
      expect(cache.isNotEmpty, isFalse);
      expect(cache.length, 0);
    });

    test('isEmpty and isNotEmpty reflect the cache state', () {
      final cache = LRUCache<int, String>(1);
      expect(cache.isEmpty, isTrue);
      expect(cache.isNotEmpty, isFalse);

      cache[1] = 'A';
      expect(cache.isEmpty, isFalse);
      expect(cache.isNotEmpty, isTrue);
    });

    test('throws ArgumentError for non-positive capacity', () {
      expect(() => LRUCache<int, String>(0), throwsArgumentError);
      expect(() => LRUCache<int, String>(-1), throwsArgumentError);
    });

    test('equal caches compare equal and share a hashCode', () {
      final a = LRUCache<int, String>(3);
      final b = LRUCache<int, String>(3);
      a[1] = 'A';
      a[2] = 'B';
      b[1] = 'A';
      b[2] = 'B';

      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('caches with different entries or capacities are not equal', () {
      final a = LRUCache<int, String>(3);
      a[1] = 'A';

      final differentValue = LRUCache<int, String>(3);
      differentValue[1] = 'B';

      final differentKey = LRUCache<int, String>(3);
      differentKey[2] = 'A';

      final differentCapacity = LRUCache<int, String>(4);
      differentCapacity[1] = 'A';

      expect(a, isNot(equals(differentValue)));
      expect(a, isNot(equals(differentKey)));
      expect(a, isNot(equals(differentCapacity)));
      expect(a, isNot(equals('not a cache')));
    });

    test('equality distinguishes missing keys from null values', () {
      final a = LRUCache<int, String?>(3);
      a[1] = 'A';

      final b = LRUCache<int, String?>(3);
      b[1] = null;

      expect(a, isNot(equals(b)));
    });
  });
}
