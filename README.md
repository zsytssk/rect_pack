# rect_pack

a copy for node [bin pack](https://github.com/bryanburgers/bin-pack)

## Getting Started

```dart
final rect =  rectPack([{width: 100, height: 100, item: 1}, {width: 200, height: 200, item: 2}]);

print(rect.width);
print(rect.height);
print(rect.items[0].x);
print(rect.items[0].y);
print(rect.items[0].width);
print(rect.items[0].height);
print(rect.items[0].item); // 1
print(rect.items[1].item); // 2
```
