import 'package:flutter/material.dart';

class SpiralShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 18, 132, 140)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const double offsetX = 28; // Adjust this to move the shape horizontally
    const double offsetY = 100; // Adjust this to move the shape vertically

    canvas.translate(offsetX, offsetY);

    final Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 896;
    path.moveTo(376.643 * xScaling, 63.2766 * yScaling);
    path.cubicTo(
      371.535 * xScaling,
      39.971 * yScaling,
      346.882 * xScaling,
      -3.80836 * yScaling,
      310.977 * xScaling,
      -5.80152 * yScaling,
    );
    path.cubicTo(
      275.072 * xScaling,
      -7.79467 * yScaling,
      234.369 * xScaling,
      26.9637 * yScaling,
      223.301 * xScaling,
      46.9036 * yScaling,
    );
    path.cubicTo(
      212.232 * xScaling,
      66.8436 * yScaling,
      152.493 * xScaling,
      108.414 * yScaling,
      142.635 * xScaling,
      71.5087 * yScaling,
    );
    path.cubicTo(
      129.208 * xScaling,
      21.2405 * yScaling,
      124.643 * xScaling,
      1.09152 * yScaling,
      100.044 * xScaling,
      30.1025 * yScaling,
    );
    path.cubicTo(
      75.4449 * xScaling,
      59.1135 * yScaling,
      72.1194 * xScaling,
      23.1091 * yScaling,
      40.3595 * xScaling,
      48.5964 * yScaling,
    );
    path.cubicTo(
      14.9516 * xScaling,
      68.9863 * yScaling,
      11.713 * xScaling,
      127.136 * yScaling,
      -41 * xScaling,
      93.0791 * yScaling,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
