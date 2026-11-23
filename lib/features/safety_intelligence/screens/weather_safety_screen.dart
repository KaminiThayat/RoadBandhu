import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';

class WeatherSafetyScreen extends StatelessWidget {
  const WeatherSafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('weather_mountain_alerts'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Weather Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0284C7), Color(0xFF0369A1), Color(0xFF075985)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0284C7).withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chamoli, Uttarakhand',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '-2°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                        const Text(
                          'Light Snowfall • Freezing Conditions',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.ac_unit, color: Colors.white, size: 44),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4 Weather Hazard Categories
            Row(
              children: [
                _buildWeatherCategory('Snowfall', 'बर्फबारी', Icons.cloudy_snowing, const Color(0xFF0284C7), isDark),
                const SizedBox(width: 10),
                _buildWeatherCategory('Heavy Rain', 'भारी वर्षा', Icons.water_drop, const Color(0xFF2563EB), isDark),
                const SizedBox(width: 10),
                _buildWeatherCategory('Cold Wave', 'शीत लहर', Icons.severe_cold, const Color(0xFF7C3AED), isDark),
                const SizedBox(width: 10),
                _buildWeatherCategory('Avalanche', 'हिमस्खलन', Icons.landslide, const Color(0xFFDC2626), isDark),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              'Active Mountain Alerts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            _buildActiveAlertCard(
              title: 'Heavy Snowfall Warning',
              desc: 'Continuous snowfall expected across Badrinath and Joshimath ridges. Black ice on turns.',
              duration: 'Next 24 hrs',
              status: BadgeStatus.high,
              label: 'High',
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildActiveAlertCard(
              title: 'Avalanche Risk - High Altitude Gorges',
              desc: 'Moderate risk on steep slope sections above 2,800m elevation. Heavy vehicle movement restricted.',
              duration: 'Next 48 hrs',
              status: BadgeStatus.medium,
              label: 'Medium',
              isDark: isDark,
            ),
            const SizedBox(height: 24),

            // Travel Advisory Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Travel Advisory • यात्रा परामर्श',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTip('Use winter-grade diesel or anti-gel fuel additives below 0°C.'),
                  _buildTip('Install tyre snow chains before attempting steep mountain passes.'),
                  _buildTip('Do not brake abruptly on black ice curves; use engine braking in low gear.'),
                  _buildTip('Night travel after 6 PM is restricted on Char Dham Yatra high routes.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCategory(String title, String subtitle, IconData icon, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 9,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveAlertCard({
    required String title,
    required String desc,
    required String duration,
    required BadgeStatus status,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              StatusBadge(text: label, status: status),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 14, color: AppColors.mountainSlate),
              const SizedBox(width: 4),
              Text(
                duration,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.mountainSlate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: AppColors.mountainSlate),
            ),
          ),
        ],
      ),
    );
  }
}
