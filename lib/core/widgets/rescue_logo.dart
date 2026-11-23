import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RescueLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool isDark;
  final Color? textColor;

  const RescueLogo({
    super.key,
    this.size = 64,
    this.showText = true,
    this.isDark = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Image.asset(
            'assets/logo/roadbandhu_icon_512.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => CustomPaint(
              size: Size(size, size * 0.75),
              painter: _MountainRescueLogoPainter(),
            ),
          ),
        ),
        if (showText) ...[
          SizedBox(width: size * 0.25),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Road',
                    style: TextStyle(
                      fontSize: size * 0.38,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.5,
                      color: textColor ?? (isDark ? Colors.white : AppColors.alpineNavy),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    'Bandhu',
                    style: TextStyle(
                      fontSize: size * 0.38,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.5,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '™',
                    style: TextStyle(
                      fontSize: size * 0.18,
                      fontWeight: FontWeight.bold,
                      color: textColor ?? (isDark ? Colors.white70 : AppColors.lightTextSecondary),
                    ),
                  ),
                ],
              ),
              Text(
                'ROAD & MOUNTAIN COMPANION',
                style: TextStyle(
                  fontSize: size * 0.11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  color: textColor?.withAlpha(180) ??
                      (isDark ? Colors.white60 : AppColors.lightTextSecondary),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _MountainRescueLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Mountain 1 (Left Peak)
    final leftPeak = Path()
      ..moveTo(0, h * 0.85)
      ..lineTo(w * 0.35, h * 0.15)
      ..lineTo(w * 0.65, h * 0.85)
      ..close();

    final mountainPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    canvas.drawPath(leftPeak, mountainPaint);

    // Mountain 2 (Right/Highest Peak)
    final rightPeak = Path()
      ..moveTo(w * 0.25, h * 0.85)
      ..lineTo(w * 0.60, h * 0.05)
      ..lineTo(w, h * 0.85)
      ..close();

    final rightMountainPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;
    canvas.drawPath(rightPeak, rightMountainPaint);

    // Snow caps
    final snowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final snowLeft = Path()
      ..moveTo(w * 0.35, h * 0.15)
      ..lineTo(w * 0.27, h * 0.35)
      ..lineTo(w * 0.33, h * 0.32)
      ..lineTo(w * 0.37, h * 0.36)
      ..lineTo(w * 0.43, h * 0.35)
      ..close();
    canvas.drawPath(snowLeft, snowPaint);

    final snowRight = Path()
      ..moveTo(w * 0.60, h * 0.05)
      ..lineTo(w * 0.50, h * 0.30)
      ..lineTo(w * 0.57, h * 0.27)
      ..lineTo(w * 0.63, h * 0.32)
      ..lineTo(w * 0.72, h * 0.29)
      ..close();
    canvas.drawPath(snowRight, snowPaint);

    // Emergency Red Swoosh / Road Path Curve
    final roadSwoosh = Path()
      ..moveTo(0, h * 0.90)
      ..quadraticBezierTo(w * 0.35, h * 0.55, w * 0.85, h * 0.50)
      ..lineTo(w, h * 0.65)
      ..quadraticBezierTo(w * 0.45, h * 0.72, w * 0.05, h * 1.0)
      ..close();

    final swooshPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    canvas.drawPath(roadSwoosh, swooshPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
