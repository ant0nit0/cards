import 'package:app_papa_v2/widgets/details/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipCardWidget extends StatefulWidget {
  final FlipCardController controller;
  final Widget front;
  final Widget back;
  const FlipCardWidget({
    super.key,
    required this.controller,
    required this.front,
    required this.back,
  });

  @override
  State<FlipCardWidget> createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    widget.controller.attach(this);
    flipCard();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future flipCard() async {
    setState(() {
      isFront = !isFront;
    });
    return controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final angle = controller.value * math.pi * 2;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: isFrontImage(angle) ? widget.front : widget.back,
          );
        },
      );

  /// Front image : From 0 till 90 degrees and 270 till 360 degrees
  /// Back image : From 90 till 270 degrees
  bool isFrontImage(double angle) {
    const degrees90 = math.pi / 2;
    const degrees270 = degrees90 * 3;
    return angle <= degrees90 || angle >= degrees270;
  }
}
