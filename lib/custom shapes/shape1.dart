import 'package:flutter/material.dart';
import 'dart:math' as math;

class Shape1 extends CustomPainter {
  final double horizontalAlignment;
  final double verticalAlignment;
  final double shapeSize;
  final Color shadowColor;
  final double shadowBlurRadius;
  final Offset shadowOffset;

  Shape1({
    this.horizontalAlignment = 0.00,
    this.verticalAlignment = 0.00,
    this.shapeSize = 10.00,
    this.shadowColor = Colors.black,
    this.shadowBlurRadius = 10.00,
    this.shadowOffset = const Offset(0, 4),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff3DA0A7)
      ..style = PaintingStyle.fill;

    final Path path = Path();
    const double aspectRatio = 414 / 896;
    final double screenAspectRatio = size.width / size.height;

    double effectiveWidth, effectiveHeight;
    if (screenAspectRatio > aspectRatio) {
      effectiveHeight = size.height;
      effectiveWidth = size.height * aspectRatio;
    } else {
      effectiveWidth = size.width;
      effectiveHeight = size.width / aspectRatio;
    }

    final double scale = math.min(effectiveWidth / 414, effectiveHeight / 896);
    final double xScaling = scale * shapeSize;
    final double yScaling = scale * shapeSize;

    final double xOffset =
        size.width / 2 + (horizontalAlignment * effectiveWidth / 2);
    final double yOffset =
        size.height / 2 + (verticalAlignment * effectiveHeight / 2);

    const pathData =
        'M17.5 -19.3C23.3 -11.7 29 -5.9 30.7 1.7C32.4 9.2 30 18.5 24.3 26.2C18.5 34 9.2 40.3 1.9 38.4C-5.5 36.5 -11 26.5 -17.8 18.7C-24.6 11 -32.8 5.5 -32.7 0.1C-32.6 -5.3 -24.2 -10.6 -17.4 -18.1C-10.6 -25.7 -5.3 -35.5 0.3 -35.8C5.9 -36.1 11.7 -26.8 17.5 -19.3';
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
      }
    }

    canvas.drawShadow(path, shadowColor, shadowBlurRadius, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Shape2 extends CustomPainter {
  final double horizontalAlignment;
  final double verticalAlignment;
  final double shapeSize;

  Shape2({
    this.horizontalAlignment = 0.00,
    this.verticalAlignment = 0.00,
    this.shapeSize = 8.00,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 95, 182, 188)
      ..style = PaintingStyle.fill;

    final Path path = Path();
    const double aspectRatio = 414 / 896;
    final double screenAspectRatio = size.width / size.height;

    double effectiveWidth, effectiveHeight;
    if (screenAspectRatio > aspectRatio) {
      effectiveHeight = size.height;
      effectiveWidth = size.height * aspectRatio;
    } else {
      effectiveWidth = size.width;
      effectiveHeight = size.width / aspectRatio;
    }

    final double scale = math.min(effectiveWidth / 414, effectiveHeight / 896);
    final double xScaling = scale * shapeSize;
    final double yScaling = scale * shapeSize;

    final double xOffset =
        size.width / 2 + (horizontalAlignment * effectiveWidth / 2);
    final double yOffset =
        size.height / 2 + (verticalAlignment * effectiveHeight / 2);

    const pathData =
        'M17.5 -19.3C23.3 -11.7 29 -5.9 30.7 1.7C32.4 9.2 30 18.5 24.3 26.2C18.5 34 9.2 40.3 1.9 38.4C-5.5 36.5 -11 26.5 -17.8 18.7C-24.6 11 -32.8 5.5 -32.7 0.1C-32.6 -5.3 -24.2 -10.6 -17.4 -18.1C-10.6 -25.7 -5.3 -35.5 0.3 -35.8C5.9 -36.1 11.7 -26.8 17.5 -19.3';
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
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Shape3 extends CustomPainter {
  final double horizontalAlignment;
  final double verticalAlignment;
  final double shapeSize;

  Shape3({
    this.horizontalAlignment = 0.00,
    this.verticalAlignment = 0.00,
    this.shapeSize = 8.00,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 156, 207, 210)
      ..style = PaintingStyle.fill;

    final Path path = Path();
    const double aspectRatio = 414 / 896;
    final double screenAspectRatio = size.width / size.height;

    double effectiveWidth, effectiveHeight;
    if (screenAspectRatio > aspectRatio) {
      effectiveHeight = size.height;
      effectiveWidth = size.height * aspectRatio;
    } else {
      effectiveWidth = size.width;
      effectiveHeight = size.width / aspectRatio;
    }

    final double scale = math.min(effectiveWidth / 414, effectiveHeight / 896);
    final double xScaling = scale * shapeSize;
    final double yScaling = scale * shapeSize;

    final double xOffset =
        size.width / 2 + (horizontalAlignment * effectiveWidth / 2);
    final double yOffset =
        size.height / 2 + (verticalAlignment * effectiveHeight / 2);

    const pathData =
        'M17.5 -19.3C23.3 -11.7 29 -5.9 30.7 1.7C32.4 9.2 30 18.5 24.3 26.2C18.5 34 9.2 40.3 1.9 38.4C-5.5 36.5 -11 26.5 -17.8 18.7C-24.6 11 -32.8 5.5 -32.7 0.1C-32.6 -5.3 -24.2 -10.6 -17.4 -18.1C-10.6 -25.7 -5.3 -35.5 0.3 -35.8C5.9 -36.1 11.7 -26.8 17.5 -19.3';
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
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
