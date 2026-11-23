import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
    );
    _progressController.forward();

    Timer(const Duration(milliseconds: 3400), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const WelcomeScreen(),
            transitionsBuilder: (context, anim1, anim2, child) =>
                FadeTransition(opacity: anim1, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FD),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Sky Gradient Background (Light blue at top to white)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.45, 1.0],
                  colors: [
                    Color(0xFFE0F2FE),
                    Color(0xFFF0F9FF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
            ),
          ),

          // 2. 100% Native Vector Mountain Sunset & Curved Highway Painter
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.48,
            child: CustomPaint(
              size: Size(size.width, size.height * 0.48),
              painter: _MountainSunsetSceneryPainter(),
            ),
          ),

          // 3. Foreground Brand & Service Cards (Zero pasted images)
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Concentric Halo Rings around Vector Pin Logo
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer faint pulse ring
                      Container(
                        width: 136,
                        height: 136,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF60A5FA).withAlpha(45),
                            width: 1.5,
                          ),
                        ),
                      ),
                      // Inner glowing glass circle
                      Container(
                        width: 114,
                        height: 114,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withAlpha(160),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withAlpha(30),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      // Crisp Vector Brand Pin Logo
                      SizedBox(
                        width: 82,
                        height: 82,
                        child: Image.asset(
                          'assets/logo/roadbandhu_icon_512.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Brand Title: Road (Navy) Bandhu (Red) ®
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Road',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.5,
                          color: Color(0xFF0F2B48),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Bandhu',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -0.5,
                          color: AppColors.primary,
                        ),
                      ),
                      const Text(
                        '™',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F2B48),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // Subtitle: — ROAD & MOUNTAIN COMPANION —
                  const Text(
                    '— ROAD & MOUNTAIN COMPANION —',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Pill Badge: ⏱ India's 24×7 Highway & Mountain Companion
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(235),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFBFDBFE),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(12),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 15,
                          color: Color(0xFF1E293B),
                        ),
                        SizedBox(width: 7),
                        Text(
                          "India's 24×7 Highway & Mountain Companion",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Horizontal Row of 5 Native Service Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        _buildServiceCard(
                          icon: Icons.car_repair_rounded,
                          title1: 'Breakdown',
                          title2: 'Help',
                          iconColor: const Color(0xFF2563EB),
                          iconBg: const Color(0xFFEFF6FF),
                        ),
                        _buildServiceCard(
                          icon: Icons.local_shipping_rounded,
                          title1: 'Towing',
                          title2: 'Service',
                          iconColor: const Color(0xFFEA580C),
                          iconBg: const Color(0xFFFFF7ED),
                        ),
                        _buildServiceCard(
                          icon: Icons.medical_services_rounded,
                          title1: 'Medical',
                          title2: 'Help',
                          iconColor: const Color(0xFFDC2626),
                          iconBg: const Color(0xFFFEF2F2),
                        ),
                        _buildServiceCard(
                          icon: Icons.landscape_rounded,
                          title1: 'Mountain',
                          title2: 'Rescue',
                          iconColor: const Color(0xFF16A34A),
                          iconBg: const Color(0xFFF0FDF4),
                        ),
                        _buildServiceCard(
                          icon: Icons.local_gas_station_rounded,
                          title1: 'Fuel',
                          title2: 'Delivery',
                          iconColor: const Color(0xFF9333EA),
                          iconBg: const Color(0xFFFAF5FF),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Bottom Native Glowing Loader & Road Rescue Services Text
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Glowing Animated Linear Progress Indicator
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, _) {
                    return Container(
                      width: 170,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(45),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 170 * _progressController.value,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF8A80),
                                Color(0xFFFF1744),
                                Color(0xFFD50000),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF1744).withAlpha(180),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Crisp White Footer Text Over Asphalt
                const Text(
                  'Breakdown  •  Accident  •  Medical  •  Towing  •  Mountain Rescue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.6,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title1,
    required String title2,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title1,
              style: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              title2,
              style: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// 100% Native Vector Mountain Sunset Scenery & Curving Highway Painter
class _MountainSunsetSceneryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Warm Sunset Atmosphere Glow above horizon
    final glowRect = Rect.fromLTWH(0, 0, w, h * 0.55);
    final glowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Color(0x30FED7AA),
          Color(0x80FDBA74),
          Color(0xC0FB923C),
        ],
      ).createShader(glowRect);
    canvas.drawRect(glowRect, glowPaint);

    // 2. Radiant Sun Disc at Sunset Horizon
    final sunCenter = Offset(w * 0.40, h * 0.38);
    final sunHaloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFFBEB).withAlpha(240),
          const Color(0xFFFDE68A).withAlpha(180),
          const Color(0xFFF59E0B).withAlpha(70),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: sunCenter, radius: 65));
    canvas.drawCircle(sunCenter, 65, sunHaloPaint);

    // 3. Layer 1: Distant Himalayan Snow-Capped Peaks
    final distantPeaks = Path()
      ..moveTo(0, h * 0.55)
      ..lineTo(0, h * 0.35)
      ..lineTo(w * 0.16, h * 0.26)
      ..lineTo(w * 0.30, h * 0.34)
      ..lineTo(w * 0.44, h * 0.22)
      ..lineTo(w * 0.58, h * 0.30)
      ..lineTo(w * 0.72, h * 0.20)
      ..lineTo(w * 0.86, h * 0.28)
      ..lineTo(w, h * 0.22)
      ..lineTo(w, h * 0.55)
      ..close();

    final distantPaint = Paint()
      ..color = const Color(0xFF64748B).withAlpha(180)
      ..style = PaintingStyle.fill;
    canvas.drawPath(distantPeaks, distantPaint);

    // Snow caps on distant peaks
    final snowPaint = Paint()
      ..color = const Color(0xFFF1F5F9).withAlpha(230)
      ..style = PaintingStyle.fill;

    final snow1 = Path()
      ..moveTo(w * 0.44, h * 0.22)
      ..lineTo(w * 0.41, h * 0.26)
      ..lineTo(w * 0.43, h * 0.25)
      ..lineTo(w * 0.47, h * 0.27)
      ..close();
    canvas.drawPath(snow1, snowPaint);

    final snow2 = Path()
      ..moveTo(w * 0.72, h * 0.20)
      ..lineTo(w * 0.68, h * 0.25)
      ..lineTo(w * 0.71, h * 0.24)
      ..lineTo(w * 0.75, h * 0.26)
      ..close();
    canvas.drawPath(snow2, snowPaint);

    // 4. Layer 2: Mid-range Pine Covered Mountain Ridges
    final midRidge = Path()
      ..moveTo(0, h * 0.55)
      ..lineTo(0, h * 0.38)
      ..lineTo(w * 0.22, h * 0.42)
      ..lineTo(w * 0.48, h * 0.36)
      ..lineTo(w * 0.78, h * 0.44)
      ..lineTo(w, h * 0.36)
      ..lineTo(w, h * 0.55)
      ..close();

    final midPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.fill;
    canvas.drawPath(midRidge, midPaint);

    // 5. Layer 3: Foreground Valley Slopes flanking highway
    final leftSlope = Path()
      ..moveTo(0, h * 0.42)
      ..lineTo(w * 0.20, h * 0.48)
      ..lineTo(w * 0.35, h * 0.56)
      ..lineTo(0, h * 0.68)
      ..close();
    final slopePaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    canvas.drawPath(leftSlope, slopePaint);

    final rightSlope = Path()
      ..moveTo(w, h * 0.38)
      ..lineTo(w * 0.60, h * 0.52)
      ..lineTo(w * 0.48, h * 0.55)
      ..lineTo(w, h * 0.70)
      ..close();
    canvas.drawPath(rightSlope, slopePaint);

    // 6. Curving Highway Asphalt Road
    final roadPath = Path()
      ..moveTo(w * 0.38, h * 0.50) // Horizon start
      ..lineTo(w * 0.46, h * 0.50)
      ..cubicTo(w * 0.52, h * 0.62, w * 0.75, h * 0.75, w * 0.95, h)
      ..lineTo(w * 0.05, h)
      ..cubicTo(w * 0.20, h * 0.78, w * 0.30, h * 0.62, w * 0.38, h * 0.50)
      ..close();

    final asphaltPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF334155),
          Color(0xFF1E222A),
          Color(0xFF111827),
          Color(0xFF0B0F17),
        ],
        stops: [0.0, 0.35, 0.75, 1.0],
      ).createShader(Rect.fromLTWH(0, h * 0.50, w, h * 0.50));
    canvas.drawPath(roadPath, asphaltPaint);

    // Left and Right Road Shoulders (Deep solid base)
    final leftGround = Path()
      ..moveTo(0, h * 0.60)
      ..lineTo(w * 0.15, h * 0.70)
      ..lineTo(w * 0.05, h)
      ..lineTo(0, h)
      ..close();
    final groundPaint = Paint()..color = const Color(0xFF0F172A);
    canvas.drawPath(leftGround, groundPaint);

    final rightGround = Path()
      ..moveTo(w, h * 0.65)
      ..lineTo(w * 0.85, h * 0.82)
      ..lineTo(w * 0.95, h)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(rightGround, groundPaint);

    // Highway Guardrail (Silver line along curve)
    final railPath = Path()
      ..moveTo(w * 0.46, h * 0.50)
      ..cubicTo(w * 0.54, h * 0.62, w * 0.78, h * 0.74, w * 0.98, h);
    final railPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(railPath, railPaint);

    // Broken Yellow Highway Centerline
    final centerDashes = [
      [Offset(w * 0.42, h * 0.51), Offset(w * 0.425, h * 0.53)],
      [Offset(w * 0.435, h * 0.55), Offset(w * 0.445, h * 0.58)],
      [Offset(w * 0.46, h * 0.61), Offset(w * 0.48, h * 0.65)],
      [Offset(w * 0.505, h * 0.69), Offset(w * 0.54, h * 0.75)],
      [Offset(w * 0.575, h * 0.80), Offset(w * 0.63, h * 0.89)],
    ];

    for (int i = 0; i < centerDashes.length; i++) {
      final pair = centerDashes[i];
      final dashPaint = Paint()
        ..color = const Color(0xFFFBBF24).withAlpha(200 + i * 10)
        ..strokeWidth = 1.8 + i * 0.9
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(pair[0], pair[1], dashPaint);
    }

    // 7. Red Reflective Highway Hazard Triangle on Road Shoulder
    _drawHazardTriangle(canvas, Offset(w * 0.28, h * 0.83), size: 36);

    // 8. Distant Car Headlights & Red Tail-lights on Highway Curve
    final carPoint = Offset(w * 0.44, h * 0.53);
    final carLightPaint = Paint()
      ..color = const Color(0xFFFEE2E2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(carPoint, 3, carLightPaint);

    final carRedGlow = Paint()
      ..color = const Color(0xFFEF4444)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(Offset(w * 0.455, h * 0.53), 2.5, carRedGlow);
  }

  void _drawHazardTriangle(Canvas canvas, Offset center, {required double size}) {
    final half = size / 2;
    final height = size * 0.866; // Equilateral triangle height

    final top = Offset(center.dx, center.dy - height * 0.55);
    final bLeft = Offset(center.dx - half, center.dy + height * 0.45);
    final bRight = Offset(center.dx + half, center.dy + height * 0.45);

    // Triangle Shadow on Asphalt
    final shadowPath = Path()
      ..moveTo(bLeft.dx - 4, bLeft.dy + 3)
      ..lineTo(bRight.dx + 4, bRight.dy + 3)
      ..lineTo(center.dx + 8, bRight.dy + 6)
      ..close();
    canvas.drawPath(shadowPath, Paint()..color = Colors.black.withAlpha(120));

    // Outer Red Triangle
    final outerPath = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(bRight.dx, bRight.dy)
      ..lineTo(bLeft.dx, bLeft.dy)
      ..close();

    final outerPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..style = PaintingStyle.fill;
    canvas.drawPath(outerPath, outerPaint);

    // Inner Orange Reflective Core
    final innerScale = 0.65;
    final iTop = Offset(center.dx, center.dy - height * 0.55 * innerScale);
    final iBLeft = Offset(center.dx - half * innerScale, center.dy + height * 0.45 * innerScale);
    final iBRight = Offset(center.dx + half * innerScale, center.dy + height * 0.45 * innerScale);

    final innerPath = Path()
      ..moveTo(iTop.dx, iTop.dy)
      ..lineTo(iBRight.dx, iBRight.dy)
      ..lineTo(iBLeft.dx, iBLeft.dy)
      ..close();

    final innerPaint = Paint()
      ..color = const Color(0xFFF97316)
      ..style = PaintingStyle.fill;
    canvas.drawPath(innerPath, innerPaint);

    // Hollow cutout inside
    final holeScale = 0.38;
    final hTop = Offset(center.dx, center.dy - height * 0.55 * holeScale);
    final hBLeft = Offset(center.dx - half * holeScale, center.dy + height * 0.45 * holeScale);
    final hBRight = Offset(center.dx + half * holeScale, center.dy + height * 0.45 * holeScale);

    final holePath = Path()
      ..moveTo(hTop.dx, hTop.dy)
      ..lineTo(hBRight.dx, hBRight.dy)
      ..lineTo(hBLeft.dx, hBLeft.dy)
      ..close();

    final holePaint = Paint()
      ..color = const Color(0xFF1E222A) // Asphalt color showing through hole
      ..style = PaintingStyle.fill;
    canvas.drawPath(holePath, holePaint);

    // Small metallic stand feet
    final standPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 2.0;
    canvas.drawLine(bLeft, Offset(bLeft.dx - 2, bLeft.dy + 4), standPaint);
    canvas.drawLine(bRight, Offset(bRight.dx + 2, bRight.dy + 4), standPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
