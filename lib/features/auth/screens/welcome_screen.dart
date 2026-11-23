import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'language_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _navigateToNext(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) =>
            const LanguageSelectionScreen(),
        transitionsBuilder: (context, anim1, anim2, child) =>
            FadeTransition(opacity: anim1, child: child),
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FD),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Sky Gradient Background (Light blue to off-white)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.40, 1.0],
                  colors: [
                    Color(0xFFE0F2FE),
                    Color(0xFFF0F9FF),
                    Color(0xFFF8FAFC),
                  ],
                ),
              ),
            ),
          ),

          // 2. Bottom Misty Himalayan Mountain Landscape (100% Vector Painter)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.28,
            child: CustomPaint(
              size: Size(size.width, size.height * 0.28),
              painter: _WelcomeMountainSceneryPainter(),
            ),
          ),

          // 3. Main Native Content Column
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Top Brand Header (Vector Pin Logo + Road Bandhu® + Subtitle)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: Image.asset(
                        'assets/logo/roadbandhu_icon_512.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Road',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                letterSpacing: -0.5,
                                color: Color(0xFF0F2B48),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Bandhu',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                letterSpacing: -0.5,
                                color: AppColors.primary,
                              ),
                            ),
                            const Text(
                              '™',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F2B48),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '— ROAD & MOUNTAIN COMPANION —',
                          style: TextStyle(
                            fontSize: 7.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Color(0xFF1E3A5F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Hero Headline & Roadside Assistance Subtitle (With Vector Illustration)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Headline, Red Alert Pill, Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Stuck on the Road?',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Red Alert Pill: We're Just a Tap Away! 👆
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE11D48),
                                    Color(0xFFDC2626),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFDC2626).withAlpha(70),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "We're Just a Tap Away!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.touch_app_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Subtitle with vertical red accent line
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 3.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDC2626),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Instant, reliable and safe road\nassistance across India —\nfrom cities to mountains.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF334155),
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Right: Clean Vector Roadside Breakdown Badge (Zero pasted image stickers!)
                      Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFEFF6FF),
                              Color(0xFFDBEAFE),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFBFDBFE),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withAlpha(25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          painter: _BreakdownBadgeVectorPainter(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // 6 Service Cards (3 Columns × 2 Rows Grid)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        // Row 1: Breakdown Help, Towing Service, Medical Help
                        Expanded(
                          child: Row(
                            children: [
                              _buildWelcomeCard(
                                icon: Icons.car_repair_rounded,
                                title1: 'Breakdown',
                                title2: 'Help',
                                iconColor: const Color(0xFF2563EB),
                                iconBg: const Color(0xFFEFF6FF),
                                onTap: () => _navigateToNext(context),
                              ),
                              const SizedBox(width: 12),
                              _buildWelcomeCard(
                                icon: Icons.local_shipping_rounded,
                                title1: 'Towing',
                                title2: 'Service',
                                iconColor: const Color(0xFFEA580C),
                                iconBg: const Color(0xFFFFF7ED),
                                onTap: () => _navigateToNext(context),
                              ),
                              const SizedBox(width: 12),
                              _buildWelcomeCard(
                                icon: Icons.medical_services_rounded,
                                title1: 'Medical',
                                title2: 'Help',
                                iconColor: const Color(0xFFDC2626),
                                iconBg: const Color(0xFFFEF2F2),
                                onTap: () => _navigateToNext(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Row 2: Mountain Rescue, Accident Support, Fuel Delivery
                        Expanded(
                          child: Row(
                            children: [
                              _buildWelcomeCard(
                                icon: Icons.landscape_rounded,
                                title1: 'Mountain',
                                title2: 'Rescue',
                                iconColor: const Color(0xFF16A34A),
                                iconBg: const Color(0xFFF0FDF4),
                                onTap: () => _navigateToNext(context),
                              ),
                              const SizedBox(width: 12),
                              _buildWelcomeCard(
                                icon: Icons.warning_amber_rounded,
                                title1: 'Accident',
                                title2: 'Support',
                                iconColor: const Color(0xFFDC2626),
                                iconBg: const Color(0xFFFEF2F2),
                                onTap: () => _navigateToNext(context),
                              ),
                              const SizedBox(width: 12),
                              _buildWelcomeCard(
                                icon: Icons.local_gas_station_rounded,
                                title1: 'Fuel',
                                title2: 'Delivery',
                                iconColor: const Color(0xFF9333EA),
                                iconBg: const Color(0xFFFAF5FF),
                                onTap: () => _navigateToNext(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Bottom CTA: Full-width Crimson Red Pill Button (Get Started →)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => _navigateToNext(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFE11D48),
                              Color(0xFFDC2626),
                              Color(0xFFB91C1C),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDC2626).withAlpha(90),
                              blurRadius: 16,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard({
    required IconData icon,
    required String title1,
    required String title2,
    required Color iconColor,
    required Color iconBg,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF64748B).withAlpha(16),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title1,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    height: 1.15,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  title2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF334155),
                    height: 1.15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 100% Native Vector Mountain Landscape for Welcome Screen Base
class _WelcomeMountainSceneryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Distant misty blue mountain ridges
    final distantRidge = Path()
      ..moveTo(0, h)
      ..lineTo(0, h * 0.45)
      ..lineTo(w * 0.20, h * 0.32)
      ..lineTo(w * 0.38, h * 0.46)
      ..lineTo(w * 0.58, h * 0.28)
      ..lineTo(w * 0.78, h * 0.42)
      ..lineTo(w * 0.90, h * 0.30)
      ..lineTo(w, h * 0.38)
      ..lineTo(w, h)
      ..close();

    final distantPaint = Paint()
      ..color = const Color(0xFFBFDBFE).withAlpha(100)
      ..style = PaintingStyle.fill;
    canvas.drawPath(distantRidge, distantPaint);

    // Foreground soft pine foothills
    final midFoothills = Path()
      ..moveTo(0, h)
      ..lineTo(0, h * 0.65)
      ..lineTo(w * 0.28, h * 0.52)
      ..lineTo(w * 0.50, h * 0.68)
      ..lineTo(w * 0.75, h * 0.48)
      ..lineTo(w, h * 0.60)
      ..lineTo(w, h)
      ..close();

    final midPaint = Paint()
      ..color = const Color(0xFF93C5FD).withAlpha(85)
      ..style = PaintingStyle.fill;
    canvas.drawPath(midFoothills, midPaint);

    // Bottom soft fade to white
    final fadeRect = Rect.fromLTWH(0, h * 0.70, w, h * 0.30);
    final fadePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withAlpha(0),
          Colors.white.withAlpha(220),
        ],
      ).createShader(fadeRect);
    canvas.drawRect(fadeRect, fadePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 100% Native Vector Breakdown Badge Illustration (No blurry raster stickers!)
class _BreakdownBadgeVectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Distant mountain silhouette inside badge
    final badgeMountain = Path()
      ..moveTo(0, h * 0.65)
      ..lineTo(w * 0.30, h * 0.40)
      ..lineTo(w * 0.55, h * 0.55)
      ..lineTo(w * 0.80, h * 0.35)
      ..lineTo(w, h * 0.50)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final mtnPaint = Paint()
      ..color = const Color(0xFF93C5FD).withAlpha(90)
      ..style = PaintingStyle.fill;
    canvas.drawPath(badgeMountain, mtnPaint);

    // Curving Asphalt Road
    final road = Path()
      ..moveTo(w * 0.20, h)
      ..lineTo(w * 0.50, h * 0.60)
      ..lineTo(w * 0.65, h * 0.60)
      ..lineTo(w, h)
      ..close();

    final roadPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.fill;
    canvas.drawPath(road, roadPaint);

    // Road dashed line
    final dashPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.58, h * 0.68), Offset(w * 0.62, h * 0.78), dashPaint);

    // Modern Car Silhouette parked on roadside
    final carBody = Path()
      ..moveTo(w * 0.45, h * 0.62)
      ..lineTo(w * 0.55, h * 0.50)
      ..lineTo(w * 0.72, h * 0.50)
      ..lineTo(w * 0.82, h * 0.62)
      ..lineTo(w * 0.85, h * 0.72)
      ..lineTo(w * 0.42, h * 0.72)
      ..close();

    final carPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    canvas.drawPath(carBody, carPaint);

    // Car Wheels
    final wheelPaint = Paint()..color = const Color(0xFF0F172A);
    canvas.drawCircle(Offset(w * 0.52, h * 0.73), 5, wheelPaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.73), 5, wheelPaint);

    // Amber Hazard Blinker Glow on Car
    final hazardPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(Offset(w * 0.44, h * 0.64), 3, hazardPaint);

    // Prominent Red Emergency Hazard Triangle on Road Shoulder
    final triCenter = Offset(w * 0.28, h * 0.78);
    const triSize = 22.0;
    const half = triSize / 2;
    const triH = triSize * 0.866;

    final top = Offset(triCenter.dx, triCenter.dy - triH * 0.55);
    final bLeft = Offset(triCenter.dx - half, triCenter.dy + triH * 0.45);
    final bRight = Offset(triCenter.dx + half, triCenter.dy + triH * 0.45);

    // Outer Red Triangle
    final outerTri = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(bRight.dx, bRight.dy)
      ..lineTo(bLeft.dx, bLeft.dy)
      ..close();

    final triPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..style = PaintingStyle.fill;
    canvas.drawPath(outerTri, triPaint);

    // Inner Cutout
    const innerScale = 0.50;
    final iTop = Offset(triCenter.dx, triCenter.dy - triH * 0.55 * innerScale);
    final iBLeft = Offset(triCenter.dx - half * innerScale, triCenter.dy + triH * 0.45 * innerScale);
    final iBRight = Offset(triCenter.dx + half * innerScale, triCenter.dy + triH * 0.45 * innerScale);

    final innerTri = Path()
      ..moveTo(iTop.dx, iTop.dy)
      ..lineTo(iBRight.dx, iBRight.dy)
      ..lineTo(iBLeft.dx, iBLeft.dy)
      ..close();

    final innerPaint = Paint()
      ..color = const Color(0xFFEFF6FF)
      ..style = PaintingStyle.fill;
    canvas.drawPath(innerTri, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
