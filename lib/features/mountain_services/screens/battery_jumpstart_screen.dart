import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import '../../emergency_sos/screens/confirm_location_screen.dart';

class BatteryJumpstartScreen extends StatefulWidget {
  const BatteryJumpstartScreen({super.key});

  @override
  State<BatteryJumpstartScreen> createState() => _BatteryJumpstartScreenState();
}

class _BatteryJumpstartScreenState extends State<BatteryJumpstartScreen> {
  String _selectedService = 'jumpstart';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('battery_jumpstart'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0284C7).withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.battery_charging_full, color: Color(0xFF0284C7), size: 34),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Battery Down?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'High-altitude sub-zero cold start jump or new battery replacement',
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
            const SizedBox(height: 24),

            Text(
              'Select Battery Service',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            _buildOption(
              key: 'jumpstart',
              title: 'Jump Start',
              subtitle: 'जंप स्टार्ट • High amperage booster kit',
              icon: Icons.flash_on,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildOption(
              key: 'diagnostic',
              title: 'Battery Health Test',
              subtitle: 'बैटरी जांच • Multi-meter voltage & alternator check',
              icon: Icons.biotech,
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildOption(
              key: 'replace',
              title: 'Replace Battery',
              subtitle: 'बैटरी बदलें • Amaron / Exide on-site delivery',
              icon: Icons.battery_unknown,
              isDark: isDark,
            ),
            const SizedBox(height: 24),

            // Location
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
                          'Pithoragarh / Chamoli, Uttarakhand - 262501',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '${context.tr('request_jumpstart')} →',
              backgroundColor: const Color(0xFF0284C7),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmLocationScreen(
                      serviceType: 'Emergency Battery Jump Start',
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

  Widget _buildOption({
    required String key,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isDark,
  }) {
    final isSelected = _selectedService == key;

    return InkWell(
      onTap: () => setState(() => _selectedService = key),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0284C7).withAlpha(20)
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF0284C7) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0284C7).withAlpha(isSelected ? 35 : 15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF0284C7), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
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
            Radio<String>(
              value: key,
              groupValue: _selectedService,
              activeColor: const Color(0xFF0284C7),
              onChanged: (v) => setState(() => _selectedService = v!),
            ),
          ],
        ),
      ),
    );
  }
}
