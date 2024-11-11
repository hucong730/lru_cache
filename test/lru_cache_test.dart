import 'package:lru_cache/lru_cache.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final lruCache = LRUCache<int, String>(3);

    lruCache[1] = "A";
    lruCache[2] = "B";
    lruCache[3] = "C";

    setUp(() {
      // Additional setup goes here.
      print(lruCache[1]); // 访问key=1，将其移动到最近使用的位置
      lruCache[4] = "D"; // 添加新的元素，触发移除最久未使用的元素
      print(lruCache);
    });

    test('First Test', () {
      expect(lruCache.keys(), [3, 1, 4]);
    });
  });
}
