import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import '../../emergency_sos/screens/confirm_location_screen.dart';

class TowingServiceScreen extends StatefulWidget {
  const TowingServiceScreen({super.key});

  @override
  State<TowingServiceScreen> createState() => _TowingServiceScreenState();
}

class _TowingServiceScreenState extends State<TowingServiceScreen> {
  String _selectedTowingType = 'breakdown';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('towing_service'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Towing Truck Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD97706).withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_shipping, color: Color(0xFFD97706), size: 36),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vehicle Towing Assistance',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Safe flatbed & mountain winch transport to destination',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Select Towing Type',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // 4 Towing Options
            Row(
              children: [
                Expanded(
                  child: _TowingOptionCard(
                    title: 'Breakdown',
                    subtitle: 'खराबी',
                    icon: Icons.car_repair,
                    isSelected: _selectedTowingType == 'breakdown',
                    onTap: () => setState(() => _selectedTowingType = 'breakdown'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TowingOptionCard(
                    title: 'Accident',
                    subtitle: 'दुर्घटना',
                    icon: Icons.car_crash,
                    isSelected: _selectedTowingType == 'accident',
                    onTap: () => setState(() => _selectedTowingType = 'accident'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _TowingOptionCard(
                    title: 'Off-road Winch',
                    subtitle: 'खाई / ढलान',
                    icon: Icons.terrain,
                    isSelected: _selectedTowingType == 'offroad',
                    onTap: () => setState(() => _selectedTowingType = 'offroad'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TowingOptionCard(
                    title: 'Long Distance',
                    subtitle: 'लंबी दूरी',
                    icon: Icons.alt_route,
                    isSelected: _selectedTowingType == 'long_distance',
                    onTap: () => setState(() => _selectedTowingType = 'long_distance'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Location Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Location', style: TextStyle(fontSize: 11, color: AppColors.mountainSlate)),
                        Text(
                          'Chamoli, Uttarakhand - 246472',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.my_location, color: AppColors.primary, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '${context.tr('request_towing')} →',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmLocationScreen(
                      serviceType: 'Towing & Hydraulic Winch Recovery',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TowingOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TowingOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.darkSurface : const Color(0xFFFEF3C7))
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFFD97706) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFD97706) : AppColors.mountainSlate,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
