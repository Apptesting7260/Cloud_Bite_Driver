import 'dart:ui';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class GradientDottedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Radius radius;
  final List<Color> gradientColors;

  const GradientDottedBorder({
    super.key,
    required this.child,
    required this.gradientColors,
    this.strokeWidth = 2,
    this.radius = const Radius.circular(15),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientDottedBorderPainter(
        strokeWidth: strokeWidth,
        radius: radius,
        gradientColors: gradientColors,
      ),
      child: child,
    );
  }
}

class _GradientDottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Radius radius;
  final List<Color> gradientColors;

  _GradientDottedBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, radius);

    final path = Path()..addRRect(rrect);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = LinearGradient(colors: gradientColors).createShader(rect);

    const dashWidth = 5.0;
    const dashSpace = 5.0;

    final PathMetrics pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final pathSegment = metric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(pathSegment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
