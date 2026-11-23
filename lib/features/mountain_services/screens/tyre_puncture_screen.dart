import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import '../../emergency_sos/screens/confirm_location_screen.dart';

class TyrePunctureScreen extends StatefulWidget {
  const TyrePunctureScreen({super.key});

  @override
  State<TyrePunctureScreen> createState() => _TyrePunctureScreenState();
}

class _TyrePunctureScreenState extends State<TyrePunctureScreen> {
  String _selectedOption = 'repair';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('tyre_assistance'),
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
                      color: const Color(0xFFEA580C).withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tire_repair, color: Color(0xFFEA580C), size: 34),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tyre Puncture & Rim Assistance',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tubeless repair, spare tyre swap, or new tyre fitment on mountain roads',
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
              'Select Tyre Service',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildTyreCard('repair', 'Puncture Repair', 'पंचर रिपेयर', Icons.build, isDark),
                const SizedBox(width: 10),
                _buildTyreCard('spare', 'Spare Tyre Fit', 'स्पेयर टायर लगाना', Icons.swap_horizontal_circle, isDark),
                const SizedBox(width: 10),
                _buildTyreCard('replace', 'Tyre Replace', 'टायर बदलना', Icons.tire_repair, isDark),
              ],
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
                          'Kausani / Chamoli Road, Uttarakhand - 263639',
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
              text: '${context.tr('request_tyre')} →',
              backgroundColor: const Color(0xFFEA580C),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmLocationScreen(
                      serviceType: 'Tyre Puncture & Replacement Help',
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

  Widget _buildTyreCard(String key, String title, String subtitle, IconData icon, bool isDark) {
    final isSelected = _selectedOption == key;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedOption = key),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFEA580C).withAlpha(20)
                : (isDark ? AppColors.darkCard : Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? const Color(0xFFEA580C) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFFEA580C), size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
