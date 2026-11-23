import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MountainSceneryHeader extends StatelessWidget {
  final double height;
  final Widget? child;
  final bool showVehicle;

  const MountainSceneryHeader({
    super.key,
    this.height = 180,
    this.child,
    this.showVehicle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _MountainRangePainter(),
          ),
          // Subtle dark vignette gradient at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(160),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          ?child,
        ],
      ),
    );
  }
}

class _MountainRangePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Distant soft blue peaks
    final distantPeaks = Path()
      ..moveTo(0, h)
      ..lineTo(0, h * 0.45)
      ..lineTo(w * 0.18, h * 0.22)
      ..lineTo(w * 0.38, h * 0.48)
      ..lineTo(w * 0.55, h * 0.18)
      ..lineTo(w * 0.75, h * 0.42)
      ..lineTo(w * 0.90, h * 0.25)
      ..lineTo(w, h * 0.38)
      ..lineTo(w, h)
      ..close();

    final distantPaint = Paint()
      ..color = const Color(0xFF475569).withAlpha(120)
      ..style = PaintingStyle.fill;
    canvas.drawPath(distantPeaks, distantPaint);

    // Foreground sharp peaks
    final fgPeaks = Path()
      ..moveTo(0, h)
      ..lineTo(0, h * 0.60)
      ..lineTo(w * 0.25, h * 0.30)
      ..lineTo(w * 0.45, h * 0.65)
      ..lineTo(w * 0.68, h * 0.25)
      ..lineTo(w * 0.88, h * 0.55)
      ..lineTo(w, h * 0.40)
      ..lineTo(w, h)
      ..close();

    final fgPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fgPeaks, fgPaint);

    // Snow caps on foreground peaks
    final snowPaint = Paint()
      ..color = Colors.white.withAlpha(220)
      ..style = PaintingStyle.fill;

    // Snow on peak 1
    final snow1 = Path()
      ..moveTo(w * 0.25, h * 0.30)
      ..lineTo(w * 0.18, h * 0.42)
      ..lineTo(w * 0.22, h * 0.40)
      ..lineTo(w * 0.26, h * 0.44)
      ..lineTo(w * 0.31, h * 0.41)
      ..close();
    canvas.drawPath(snow1, snowPaint);

    // Snow on peak 2
    final snow2 = Path()
      ..moveTo(w * 0.68, h * 0.25)
      ..lineTo(w * 0.60, h * 0.38)
      ..lineTo(w * 0.65, h * 0.36)
      ..lineTo(w * 0.70, h * 0.41)
      ..lineTo(w * 0.76, h * 0.37)
      ..close();
    canvas.drawPath(snow2, snowPaint);

    // Winding Himalayan highway line
    final roadPath = Path()
      ..moveTo(0, h * 0.95)
      ..cubicTo(w * 0.3, h * 0.88, w * 0.5, h * 0.98, w, h * 0.82);

    final roadPaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(roadPath, roadPaint);

    // Red emergency beacon glow dot
    final beaconPaint = Paint()
      ..color = AppColors.primary
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(w * 0.55, h * 0.90), 5, beaconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
