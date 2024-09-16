import 'package:custom_svg_shape_generator/contributors.dart';
import 'package:custom_svg_shape_generator/custom%20shapes/shape1.dart';
import 'package:custom_svg_shape_generator/custom_shape.dart';
import 'package:custom_svg_shape_generator/custom_line.dart';
import 'package:custom_svg_shape_generator/custom%20lines/spiral_shape.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset offset1 = const Offset(0, 0);
  double spreadRadius1 = 0;
  double blurRadius1 = 0;

  Offset offset2 = const Offset(0, 0);
  double spreadRadius2 = 0;
  double blurRadius2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                'Flutter Custom Svg Shape Generator',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                'Input bezier path and generate custom shapes and lines',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3DA0A7),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                Column(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (event) {
                        setState(() {
                          offset1 = const Offset(-4, 10);
                          spreadRadius1 = 4;
                          blurRadius1 = 4;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          offset1 = const Offset(0, 0);
                          spreadRadius1 = 0;
                          blurRadius1 = 0;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomShapeScreen()));
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: offset1,
                                  spreadRadius: spreadRadius1,
                                  blurRadius: blurRadius1,
                                ),
                              ]),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(300, 300),
                                painter: Shape1(),
                              ),
                              CustomPaint(
                                size: const Size(200, 200),
                                painter: Shape2(),
                              ),
                              CustomPaint(
                                size: const Size(100, 100),
                                painter: Shape3(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Custom Shape Generator',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (event) {
                        setState(() {
                          offset2 = const Offset(-4, 10);
                          spreadRadius2 = 4;
                          blurRadius2 = 4;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          offset2 = const Offset(0, 0);
                          spreadRadius2 = 0;
                          blurRadius2 = 0;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomLineScreen()));
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: offset2,
                                  spreadRadius: spreadRadius2,
                                  blurRadius: blurRadius2,
                                ),
                              ]),
                          child: CustomPaint(
                            size: const Size(50, 50),
                            painter: SpiralShape(),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Custom Line Generator',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Created using Flutter.',
                style: TextStyle(fontSize: 16, color: Color(0xff3DA0A7)),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contributors()));
                  },
                  child: Text(
                    'Contributors:',
                    style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.amber,
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
