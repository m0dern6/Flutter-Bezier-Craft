import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  final String pathData;
  final bool isFilled;
  final double horizontalAlignment;
  final double verticalAlignment;
  final double shapeSize;
  final double strokeWidth;
  final Color color;
  final List<Color> gradientColors;
  final Alignment gradientStart;
  final Alignment gradientEnd;
  final bool isResponsive;
  final double width;
  final double height;

  CustomShapePainter({
    required this.pathData,
    this.isFilled = true,
    this.horizontalAlignment = 0.0,
    this.verticalAlignment = 0.0,
    this.shapeSize = 1.0,
    this.strokeWidth = 2.0,
    this.color = Colors.blue,
    this.gradientColors = const [],
    this.gradientStart = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.isResponsive = true,
    this.width = 414,
    this.height = 896,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    if (gradientColors.isNotEmpty) {
      paint.shader = LinearGradient(
        colors: gradientColors,
        begin: gradientStart,
        end: gradientEnd,
      ).createShader(Offset.zero & size);
    } else {
      paint.color = color;
    }

    final Path path = Path();
    double xScaling, yScaling;

    if (isResponsive) {
      final double aspectRatio = width / height;
      final double screenAspectRatio = size.width / size.height;

      if (screenAspectRatio > aspectRatio) {
        yScaling = size.height / height * shapeSize;
        xScaling = yScaling * aspectRatio;
      } else {
        xScaling = size.width / width * shapeSize;
        yScaling = xScaling / aspectRatio;
      }
    } else {
      xScaling = shapeSize;
      yScaling = shapeSize;
    }

    final double xOffset = size.width * (horizontalAlignment + 1) / 2;
    final double yOffset = size.height * (verticalAlignment + 1) / 2;

    final commands = pathData.split(RegExp(r'(?=[MCL])'));
    for (var command in commands) {
      if (command.isEmpty) continue;
      final cmd = command[0];
      final points = command
          .substring(1)
          .trim()
          .split(RegExp(r'\s+'))
          .map((e) => double.tryParse(e) ?? 0)
          .toList();

      if (cmd == 'M' && points.length == 2) {
        path.moveTo(
          points[0] * xScaling + xOffset,
          points[1] * yScaling + yOffset,
        );
      } else if (cmd == 'C' && points.length == 6) {
        path.cubicTo(
          points[0] * xScaling + xOffset,
          points[1] * yScaling + yOffset,
          points[2] * xScaling + xOffset,
          points[3] * yScaling + yOffset,
          points[4] * xScaling + xOffset,
          points[5] * yScaling + yOffset,
        );
      } else if (cmd == 'L' && points.length == 2) {
        path.lineTo(
          points[0] * xScaling + xOffset,
          points[1] * yScaling + yOffset,
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
