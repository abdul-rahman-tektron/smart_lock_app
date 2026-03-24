import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_lock_app/res/colors.dart';

class DotCircleSpinner extends StatefulWidget {
  final double size;
  final Color color;
  final double dotSize;

  const DotCircleSpinner({
    super.key,
    this.size = 60,
    this.dotSize = 5,
    this.color = AppColors.white,
  });

  @override
  State<DotCircleSpinner> createState() => _DotCircleSpinnerState();
}

class _DotCircleSpinnerState extends State<DotCircleSpinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: _DotSpinnerPainter(
                animationValue: _controller.value,
                dotColor: widget.color,
                dotSize: widget.dotSize
            ),
          );
        },
      ),
    );
  }
}

class _DotSpinnerPainter extends CustomPainter {
  final double animationValue;
  final double dotSize;
  final Color dotColor;

  _DotSpinnerPainter({
    required this.animationValue,
    required this.dotColor,
    required this.dotSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const int dotCount = 12;
    final double radius = size.width / 2;
    final double dotRadius = dotSize;
    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < dotCount; i++) {
      final double angle = 2 * pi * i / dotCount;
      final double dx = center.dx + radius * 0.7 * cos(angle);
      final double dy = center.dy + radius * 0.7 * sin(angle);

      // Create fade delay based on position
      final double progress = (animationValue + i / dotCount) % 1.0;
      final double opacity = (1.0 - progress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = dotColor.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}