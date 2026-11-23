import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RescueMapView extends StatelessWidget {
  final double height;
  final String locationTitle;
  final String locationSubtitle;
  final bool showMechanic;
  final bool showRoute;
  final VoidCallback? onExpand;

  const RescueMapView({
    super.key,
    this.height = 240,
    this.locationTitle = 'Chamoli - Badrinath Road (NH-7)',
    this.locationSubtitle = 'Lat: 30.4412° N, Long: 79.5768° E',
    this.showMechanic = true,
    this.showRoute = true,
    this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: height,
        width: double.infinity,
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        child: Stack(
          children: [
            // Custom vector mountain topographic terrain map
            CustomPaint(
              size: Size(double.infinity, height),
              painter: _HimalayanMapPainter(isDark: isDark, showRoute: showRoute),
            ),

            // Top control badges
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.alertLow,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live GPS Connected',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppColors.alpineNavy,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (onExpand != null)
              Positioned(
                top: 12,
                right: 12,
                child: InkWell(
                  onTap: onExpand,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.fullscreen,
                      size: 18,
                      color: isDark ? Colors.white : AppColors.alpineNavy,
                    ),
                  ),
                ),
              ),

            // Bottom Location Banner
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.darkSurface : Colors.white).withAlpha(240),
                  border: Border(
                    top: BorderSide(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            locationTitle,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            locationSubtitle,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HimalayanMapPainter extends CustomPainter {
  final bool isDark;
  final bool showRoute;

  _HimalayanMapPainter({required this.isDark, required this.showRoute});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background terrain contours
    final contourPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withAlpha(15)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (int i = 1; i <= 5; i++) {
      final path = Path()
        ..moveTo(0, h * 0.2 * i)
        ..cubicTo(w * 0.3, h * 0.15 * i, w * 0.7, h * 0.25 * i, w, h * 0.18 * i);
      canvas.drawPath(path, contourPaint);
    }

    // River Alaknanda path (blue ribbon)
    final riverPath = Path()
      ..moveTo(0, h * 0.7)
      ..cubicTo(w * 0.25, h * 0.6, w * 0.45, h * 0.85, w * 0.7, h * 0.75)
      ..cubicTo(w * 0.85, h * 0.68, w * 0.95, h * 0.8, w, h * 0.82);

    final riverPaint = Paint()
      ..color = const Color(0xFF38BDF8).withAlpha(isDark ? 80 : 120)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    canvas.drawPath(riverPath, riverPaint);

    if (showRoute) {
      // Highway NH-7 Mountain Route
      final routePath = Path()
        ..moveTo(w * 0.18, h * 0.68)
        ..cubicTo(w * 0.32, h * 0.45, w * 0.45, h * 0.58, w * 0.60, h * 0.35)
        ..cubicTo(w * 0.70, h * 0.25, w * 0.78, h * 0.32, w * 0.82, h * 0.28);

      // Route outline (White shadow)
      final routeShadow = Paint()
        ..color = Colors.white
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawPath(routePath, routeShadow);

      // Active GPS Route Line (Emergency Blue)
      final routePaint = Paint()
        ..color = const Color(0xFF2563EB)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      canvas.drawPath(routePath, routePaint);

      // Rescue Vehicle Marker (moving at w*0.48, h*0.48)
      final vehiclePos = Offset(w * 0.48, h * 0.48);
      final vehicleGlow = Paint()
        ..color = AppColors.primary.withAlpha(60)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(vehiclePos, 16, vehicleGlow);

      final vehicleBg = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.fill;
      canvas.drawCircle(vehiclePos, 11, vehicleBg);

      final vehicleCore = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(vehiclePos, 5, vehicleCore);

      // User Breakdown Location Pin (Destination) at w*0.82, h*0.28
      final destPos = Offset(w * 0.82, h * 0.28);
      final destPin = Paint()
        ..color = AppColors.alertHigh
        ..style = PaintingStyle.fill;
      canvas.drawCircle(destPos, 8, destPin);

      final destInner = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(destPos, 3, destInner);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
