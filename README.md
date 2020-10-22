# rect_pack

a copy for node [bin pack](https://github.com/bryanburgers/bin-pack)

## Getting Started

```dart
final List<InputItem> list = [];

list.add(InputItem(width: 100, height: 100, item: 1));
list.add(InputItem(width: 200, height: 200, item: 2));
final rect = rectPack(list);
print(rect.width);
print(rect.height);
print(rect.items);
```
