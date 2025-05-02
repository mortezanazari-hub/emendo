import 'package:flutter/material.dart';

class IconHoleClipper extends CustomClipper<Path> {
  final Rect iconRect;

  IconHoleClipper(this.iconRect);

  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final RRect iconHole = RRect.fromRectAndRadius(
      iconRect.inflate(0),
      const Radius.circular(50),
    );

    path.addRRect(iconHole);
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(IconHoleClipper oldClipper) {
    return oldClipper.iconRect != iconRect;
  }
}
