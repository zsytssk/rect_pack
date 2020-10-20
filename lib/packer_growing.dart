import 'package:rect_pack/rect_pack.dart';

class GrowingPacker {
  Map<String, dynamic> root = Map();

  fit(List<OutputItem> blocks) {
    var len = blocks.length;
    var width = len > 0 ? blocks[0].width : 0;
    var height = len > 0 ? blocks[0].height : 0;
    this.root = {"x": 0, "y": 0, 'width': width, 'height': height};

    for (final block in blocks) {
      final node = this.findNode(this.root, block.width, block.height);
      if (node != null) {
        final fit = this.splitNode(node, block.width, block.height);
        block.x = fit['x'];
        block.y = fit['y'];
      } else {
        final fit = this.growNode(block.width, block.height);
        block.x = fit['x'];
        block.y = fit['y'];
      }
    }
  }

  findNode(root, int width, int height) {
    if (root['used'] != null) {
      final rightNode = this.findNode(root['right'], width, height);
      if (rightNode != null) {
        return rightNode;
      }
      final downNode = this.findNode(root['down'], width, height);
      if (downNode != null) {
        return downNode;
      }
    } else if ((width <= root['width']) && (height <= root['height']))
      return root;
    else
      return null;
  }

  splitNode(node, width, height) {
    node['used'] = true;
    node['down'] = {
      "x": node['x'],
      "y": node['y'] + height,
      'width': node['width'],
      'height': node['height'] - height
    };
    node['right'] = {
      "x": node['x'] + width,
      "y": node['y'],
      'width': node['width'] - width,
      'height': height
    };
    return node;
  }

  growNode(int width, int height) {
    var canGrowDown = (width <= this.root['width']);
    var canGrowRight = (height <= this.root['height']);

    var shouldGrowRight = canGrowRight &&
        (this.root['height'] >=
            (this.root['width'] +
                width)); // attempt to keep square-ish by growing right when height is much greater than width
    var shouldGrowDown = canGrowDown &&
        (this.root['width'] >=
            (this.root['height'] +
                height)); // attempt to keep square-ish by growing down  when width  is much greater than height

    if (shouldGrowRight)
      return this.growRight(width, height);
    else if (shouldGrowDown)
      return this.growDown(width, height);
    else if (canGrowRight)
      return this.growRight(width, height);
    else if (canGrowDown)
      return this.growDown(width, height);
    else
      return null; // need to ensure sensible root starting size to avoid this happening
  }

  growRight(int width, int height) {
    this.root = {
      'used': true,
      'x': 0,
      'y': 0,
      'width': this.root['width'] + width,
      'height': this.root['height'],
      'down': this.root,
      'right': {
        'x': this.root['width'],
        'y': 0,
        'width': width,
        'height': this.root['height'],
      }
    };
    var node = this.findNode(this.root, width, height);
    if (node != null)
      return this.splitNode(node, width, height);
    else
      return null;
  }

  growDown(int width, int height) {
    this.root = {
      'used': true,
      'x': 0,
      'y': 0,
      'width': this.root['width'],
      'height': this.root['height'] + height,
      'down': {
        'x': 0,
        'y': this.root['height'],
        'width': this.root['width'],
        'height': height
      },
      'right': this.root
    };
    var node = this.findNode(this.root, width, height);
    if (node != null)
      return this.splitNode(node, width, height);
    else
      return null;
  }
}
