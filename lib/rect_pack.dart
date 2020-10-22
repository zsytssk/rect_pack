library rect_pack;

import 'dart:math' as Math;
import 'packer_growing.dart';

class InputItem<T> {
  int width;
  int height;
  T item;
  InputItem({
    this.width,
    this.height,
    this.item,
  });
}

class Result<T> {
  int width;
  int height;
  List<OutputItem<T>> items;
  Result({
    this.width,
    this.height,
    this.items,
  });
}

class OutputItem<T> {
  int x;
  int y;
  int width;
  int height;
  T item;
  OutputItem({
    this.x,
    this.y,
    this.width,
    this.height,
    this.item,
  });
  @override
  String toString() => 'x=$x, y=$y, width=$width, height=$height';
}

Result<T> rectPack<T>(List<InputItem<T>> items) {
  var packer = new GrowingPacker();

  // Clone the items.
  var newItems = items.map((item) {
    return OutputItem(width: item.width, height: item.height, item: item.item);
  }).toList();

  newItems.sort((a, b) {
    // Sort based on the size (area) of each block.
    return (b.width * b.height).compareTo(a.width * a.height);
  });

  packer.fit(newItems);

  var w = newItems.fold(0, (int curr, item) {
    return Math.max(curr, item.x + item.width);
  });
  var h = newItems.fold(0, (int curr, item) {
    return Math.max(curr, item.y + item.height);
  });

  return Result(width: w, height: h, items: newItems);
}
