import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomLineScreen extends StatefulWidget {
  const CustomLineScreen({super.key});

  @override
  _CustomLineScreenState createState() => _CustomLineScreenState();
}

class _CustomLineScreenState extends State<CustomLineScreen> {
  final pathController = TextEditingController();
  String pathData = '';
  String generatedPainterCode = '';

  double horizontalAlignment = 0.0;
  double verticalAlignment = 0.0;
  double strokeWidth = 2.0;
  double lineSize = 1.0; // New variable for line size
  Color lineColor = Colors.blue;
  List<Color> gradientColors = [];
  bool isResponsive = true;
  double width = 414;
  double height = 896;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Bezier Path Input'),
      ),
      body: Row(
        children: [
          // Left side: Input form and controls
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Enter Bézier Path Data:'),
                  TextField(
                    controller: pathController,
                    decoration: const InputDecoration(
                      labelText: 'Path Data',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 6,
                    onChanged: (value) {
                      setState(() {
                        pathData = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Horizontal Alignment'),
                  Slider(
                    value: horizontalAlignment,
                    min: -1.0,
                    max: 1.0,
                    onChanged: (value) =>
                        setState(() => horizontalAlignment = value),
                  ),
                  const Text('Vertical Alignment'),
                  Slider(
                    value: verticalAlignment,
                    min: -1.0,
                    max: 1.0,
                    onChanged: (value) =>
                        setState(() => verticalAlignment = value),
                  ),
                  const Text('Stroke Width'),
                  Slider(
                    value: strokeWidth,
                    min: 1.0,
                    max: 10.0,
                    onChanged: (value) => setState(() => strokeWidth = value),
                  ),
                  const Text('Line Size'),
                  Slider(
                    value: lineSize,
                    min: 0.5,
                    max: 5.0,
                    onChanged: (value) => setState(() => lineSize = value),
                  ),
                  TextFormField(
                    initialValue: lineSize.toString(),
                    decoration: const InputDecoration(labelText: 'Line Size'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(
                        () => lineSize = double.tryParse(value) ?? lineSize),
                  ),
                  ElevatedButton(
                    onPressed: _showColorPicker,
                    child: const Text('Pick Line Color'),
                  ),
                  // ElevatedButton(
                  //   onPressed: _showGradientPicker,
                  //   child: const Text('Set Gradient Colors'),
                  // ),
                  CheckboxListTile(
                    title: const Text('Responsive'),
                    value: isResponsive,
                    onChanged: (value) => setState(() => isResponsive = value!),
                  ),
                  TextFormField(
                    initialValue: width.toString(),
                    decoration: const InputDecoration(labelText: 'Width'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        setState(() => width = double.tryParse(value) ?? width),
                  ),
                  TextFormField(
                    initialValue: height.toString(),
                    decoration: const InputDecoration(labelText: 'Height'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(
                        () => height = double.tryParse(value) ?? height),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            generatedPainterCode =
                                generatePainterCode(pathData);
                          });
                        },
                        child: const Text('Generate Code'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: generatedPainterCode));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Code copied to clipboard!')),
                          );
                        },
                        child: const Text('Copy Code'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Generated CustomPainter Code:'),

                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: SelectableText(
                      generatedPainterCode,
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right side: Preview container
          Expanded(
            child: Center(
              child: Container(
                width: 375, // Width of a mobile screen
                height: 812, // Height of a mobile screen
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: CustomPaint(
                  painter: CustomShapePainter(
                    pathData: pathData,
                    strokeWidth: strokeWidth,
                    color: lineColor,
                    gradientColors: gradientColors,
                    horizontalAlignment: horizontalAlignment,
                    verticalAlignment: verticalAlignment,
                    isResponsive: isResponsive,
                    width: width,
                    height: height,
                    lineSize: lineSize, // Pass lineSize to the painter
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: lineColor,
            onColorChanged: (color) => setState(() => lineColor = color),
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showGradientPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Gradient Colors'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < gradientColors.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: ColorPicker(
                        pickerColor: gradientColors[i],
                        onColorChanged: (color) {
                          setState(() {
                            gradientColors[i] = color;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          gradientColors.removeAt(i);
                        });
                        Navigator.of(context).pop();
                        _showGradientPicker();
                      },
                    ),
                  ],
                ),
              ElevatedButton(
                child: const Text('Add Color'),
                onPressed: () {
                  setState(() {
                    gradientColors.add(Colors.white);
                  });
                  Navigator.of(context).pop();
                  _showGradientPicker();
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  String generatePainterCode(String pathData) {
    final pathString = pathData.trim();
    final commands = pathString.split(RegExp(r'(?=[MCL])'));

    final buffer = StringBuffer();
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln('');
    buffer.writeln('class CustomShapePainter extends CustomPainter {');
    buffer.writeln('  @override');
    buffer.writeln('  void paint(Canvas canvas, Size size) {');
    buffer.writeln('    final paint = Paint()');
    buffer.writeln(
        '      ..color = Color(0x${lineColor.value.toRadixString(16)})');
    buffer.writeln('      ..style = PaintingStyle.stroke');
    buffer.writeln('      ..strokeWidth = $strokeWidth;');

    if (gradientColors.isNotEmpty) {
      buffer.writeln('    paint.shader = LinearGradient(');
      buffer.writeln(
          '      colors: ${gradientColors.map((c) => 'Color(0x${c.value.toRadixString(16)})').toList()},');
      buffer.writeln('      begin: Alignment.topLeft,');
      buffer.writeln('      end: Alignment.bottomRight,');
      buffer.writeln('    ).createShader(Offset.zero & size);');
    }

    buffer.writeln('');
    buffer.writeln('    final Path path = Path();');
    buffer.writeln('    final double _xScaling = size.width / $width;');
    buffer.writeln('    final double _yScaling = size.height / $height;');

    for (var command in commands) {
      if (command.isEmpty) continue;
      final cmd = command[0];
      final points = command
          .substring(1)
          .trim()
          .split(RegExp(r'\s+'))
          .map((e) => double.tryParse(e) ?? 0.0)
          .toList();

      if (cmd == 'M') {
        buffer.writeln(
            '    path.moveTo(${points[0]} * _xScaling, ${points[1]} * _yScaling);');
      } else if (cmd == 'C') {
        buffer.writeln(
            '    path.cubicTo(${points[0]} * _xScaling, ${points[1]} * _yScaling, ${points[2]} * _xScaling, ${points[3]} * _yScaling, ${points[4]} * _xScaling, ${points[5]} * _yScaling);');
      } else if (cmd == 'L') {
        buffer.writeln(
            '    path.lineTo(${points[0]} * _xScaling, ${points[1]} * _yScaling);');
      }
    }

    buffer.writeln('');
    buffer.writeln('    canvas.drawPath(path, paint);');
    buffer.writeln('  }');
    buffer.writeln('');
    buffer.writeln('  @override');
    buffer
        .writeln('  bool shouldRepaint(covariant CustomPainter oldDelegate) {');
    buffer.writeln('    return true;');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}

class CustomShapePainter extends CustomPainter {
  final String pathData;
  final double strokeWidth;
  final Color color;
  final List<Color> gradientColors;
  final double horizontalAlignment;
  final double verticalAlignment;
  final bool isResponsive;
  final double width;
  final double height;
  final double lineSize; // New parameter for line size

  CustomShapePainter({
    required this.pathData,
    required this.strokeWidth,
    required this.color,
    required this.gradientColors,
    required this.horizontalAlignment,
    required this.verticalAlignment,
    required this.isResponsive,
    required this.width,
    required this.height,
    required this.lineSize, // Initialize lineSize
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    if (gradientColors.isNotEmpty) {
      paint.shader = LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    }

    final Path path = Path();
    final double xScaling = isResponsive ? size.width / width : 1.0;
    final double yScaling = isResponsive ? size.height / height : 1.0;

    // Adjust position based on alignment
    final double xTranslation = horizontalAlignment * size.width / 2;
    final double yTranslation = verticalAlignment * size.height / 2;

    final commands = pathData.split(RegExp(r'(?=[MCL])'));

    for (var command in commands) {
      if (command.isEmpty) continue;
      final cmd = command[0];
      final points = command
          .substring(1)
          .trim()
          .split(RegExp(r'\s+'))
          .map((e) => double.tryParse(e) ?? 0.0)
          .toList();

      if (cmd == 'M') {
        path.moveTo(
          points[0] * xScaling * lineSize + xTranslation,
          points[1] * yScaling * lineSize + yTranslation,
        );
      } else if (cmd == 'C') {
        path.cubicTo(
          points[0] * xScaling * lineSize + xTranslation,
          points[1] * yScaling * lineSize + yTranslation,
          points[2] * xScaling * lineSize + xTranslation,
          points[3] * yScaling * lineSize + yTranslation,
          points[4] * xScaling * lineSize + xTranslation,
          points[5] * yScaling * lineSize + yTranslation,
        );
      } else if (cmd == 'L') {
        path.lineTo(
          points[0] * xScaling * lineSize + xTranslation,
          points[1] * yScaling * lineSize + yTranslation,
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
