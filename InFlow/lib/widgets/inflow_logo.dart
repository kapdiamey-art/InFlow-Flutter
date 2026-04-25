import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class InFlowLogo extends StatelessWidget {
  final double size;
  const InFlowLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: size * 0.4,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.3),
                  blurRadius: size * 0.5,
                  spreadRadius: -5,
                ),
              ],
            ),
          ),
          // Main Body
          CustomPaint(
            size: Size(size, size),
            painter: _LogoPainter(
              primaryColor: AppColors.primary,
              secondaryColor: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _LogoPainter({required this.primaryColor, required this.secondaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Draw soft glassmorphism background circle
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.9, bgPaint);

    // 2. Draw "Flow" paths
    final path1 = Path();
    path1.moveTo(size.width * 0.3, size.height * 0.7);
    path1.cubicTo(
      size.width * 0.4, size.height * 0.85,
      size.width * 0.6, size.height * 0.15,
      size.width * 0.7, size.height * 0.3,
    );

    final path2 = Path();
    path2.moveTo(size.width * 0.25, size.height * 0.5);
    path2.cubicTo(
      size.width * 0.35, size.height * 0.3,
      size.width * 0.65, size.height * 0.7,
      size.width * 0.75, size.height * 0.5,
    );

    final flowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [primaryColor, secondaryColor, primaryColor.withOpacity(0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Outer Glow for path
    canvas.drawPath(path1, flowPaint..maskFilter = MaskFilter.blur(BlurStyle.normal, size.width * 0.02));
    canvas.drawPath(path1, flowPaint..maskFilter = null);
    
    canvas.drawPath(path2, flowPaint..maskFilter = MaskFilter.blur(BlurStyle.normal, size.width * 0.02));
    canvas.drawPath(path2, flowPaint..maskFilter = null);

    // 3. Draw a "Dot" for the 'i' effect
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.25), size.width * 0.04, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
