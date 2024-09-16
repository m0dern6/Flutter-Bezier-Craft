import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_shape_painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomShapeScreen extends StatefulWidget {
  const CustomShapeScreen({super.key});

  @override
  _CustomShapeScreenState createState() => _CustomShapeScreenState();
}

class _CustomShapeScreenState extends State<CustomShapeScreen> {
  final pathController = TextEditingController();
  String pathData = '';
  String generatedPainterCode = '';

  bool isFilled = true;
  double horizontalAlignment = 0.0;
  double verticalAlignment = 0.0;
  double shapeSize = 1.0;
  double strokeWidth = 2.0;
  Color shapeColor = Colors.blue;
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
        title: const Text('Custom Shape Generator'),
      ),
      body: Row(
        children: [
          // Left side: Controls
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: pathController,
                    decoration: const InputDecoration(labelText: 'Path Data'),
                    maxLines: 5,
                    onChanged: (value) => setState(() => pathData = value),
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
                  const Text('Shape Size'),
                  Slider(
                    value: shapeSize,
                    min: 0.1,
                    max: 5.0,
                    onChanged: (value) => setState(() => shapeSize = value),
                  ),
                  const Text('Stroke Width'),
                  Slider(
                    value: strokeWidth,
                    min: 1.0,
                    max: 10.0,
                    onChanged: (value) => setState(() => strokeWidth = value),
                  ),
                  ElevatedButton(
                    onPressed: () => _showColorPicker(),
                    child: const Text('Pick Color'),
                  ),
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
                  ElevatedButton(
                    onPressed: _generateCode,
                    child: const Text('Generate Code'),
                  ),
                ],
              ),
            ),
          ),
          // Right side: Preview
          Expanded(
            child: Center(
              child: Container(
                width: 375,
                height: 812,
                decoration: BoxDecoration(border: Border.all()),
                child: CustomPaint(
                  painter: CustomShapePainter(
                    pathData: pathData,
                    isFilled: isFilled,
                    horizontalAlignment: horizontalAlignment,
                    verticalAlignment: verticalAlignment,
                    shapeSize: shapeSize,
                    strokeWidth: strokeWidth,
                    color: shapeColor,
                    gradientColors: gradientColors,
                    isResponsive: isResponsive,
                    width: width,
                    height: height,
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
            pickerColor: shapeColor,
            onColorChanged: (color) => setState(() => shapeColor = color),
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

  void _generateCode() {
    // Convert pathData into Dart code
    final pathCommands = pathData.split(RegExp(r'(?=[MCL])')).map((command) {
      if (command.isEmpty) return '';
      final cmd = command[0];
      final points = command
          .substring(1)
          .trim()
          .split(RegExp(r'\s+'))
          .map((e) => double.tryParse(e) ?? 0)
          .toList();

      if (cmd == 'M' && points.length == 2) {
        return 'path.moveTo(${points[0]}, ${points[1]});';
      } else if (cmd == 'C' && points.length == 6) {
        return 'path.cubicTo(${points[0]}, ${points[1]}, ${points[2]}, ${points[3]}, ${points[4]}, ${points[5]});';
      } else if (cmd == 'L' && points.length == 2) {
        return 'path.lineTo(${points[0]}, ${points[1]});';
      }
      return '';
    }).join('\n');

    final code = '''
import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = ${isFilled ? 'PaintingStyle.fill' : 'PaintingStyle.stroke'}
      ..strokeWidth = $strokeWidth;

    ${gradientColors.isNotEmpty ? '''
    paint.shader = LinearGradient(
      colors: ${gradientColors.map((c) => 'Color(0x${c.value.toRadixString(16)})').toList()},
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Offset.zero & size);
    ''' : '''
    paint.color = Color(0x${shapeColor.value.toRadixString(16)});
    '''}

    final path = Path();
    $pathCommands

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
''';

    setState(() {
      generatedPainterCode = code;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generated Code'),
        content: SingleChildScrollView(
          child: SelectableText(code),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Copy to Clipboard'),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Code copied to clipboard')),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
