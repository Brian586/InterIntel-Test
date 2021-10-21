import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interintel/config/app_config.dart';

class RandomButtonWidget extends StatefulWidget {
  const RandomButtonWidget({Key? key}) : super(key: key);

  @override
  _RandomButtonWidgetState createState() => _RandomButtonWidgetState();
}

class _RandomButtonWidgetState extends State<RandomButtonWidget> {
  static const double minSize = 50;
  static const double maxSize = 200;

  Color color = Colors.green;
  double width = maxSize;
  double height = maxSize;
  BorderRadius borderRadius = BorderRadius.zero;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            width: maxSize,
            height: maxSize,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInBack,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: borderRadius,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RaisedButton(
            shape: const StadiumBorder(),
            color: InterIntel.themeColor,
            child: const Text(
              'Animate',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              final random = Random();

              /// Color
              final red = random.nextInt(255);
              final green = random.nextInt(255);
              final blue = random.nextInt(255);
              final color = Color.fromRGBO(red, green, blue, 1);

              /// Size
              final size = generateSize();

              /// BorderRadius
              final borderRadius =
                  BorderRadius.circular(random.nextDouble() * 80);

              setState(() {
                this.color = color;
                width = size.width;
                height = size.height;
                this.borderRadius = borderRadius;
              });
            },
          ),
        ],
      );

  Size generateSize() {
    final random = Random();

    final addMax = maxSize.toInt() - minSize.toInt();
    final width = minSize + random.nextInt(addMax);
    final height = minSize + random.nextInt(addMax);

    return Size(width, height);
  }
}
