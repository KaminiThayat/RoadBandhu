import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/mountain_scenery_header.dart';
import '../../../core/localization/app_localizations.dart';
import 'confirm_location_screen.dart';

class MountainRescueScreen extends StatefulWidget {
  const MountainRescueScreen({super.key});

  @override
  State<MountainRescueScreen> createState() => _MountainRescueScreenState();
}

class _MountainRescueScreenState extends State<MountainRescueScreen> {
  final Set<String> _selectedHazards = {'landslide', 'stuck'};

  void _toggleHazard(String key) {
    setState(() {
      if (_selectedHazards.contains(key)) {
        _selectedHazards.remove(key);
      } else {
        _selectedHazards.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            MountainSceneryHeader(
              height: 220,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      Text(
                        context.tr('mountain_rescue_title'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Himalayan Specialized Extraction & Life Support',
                        style: TextStyle(
                          color: Color(0xFFFCA5A5),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildHazardCard(
                    key: 'altitude',
                    title: context.tr('mr_high_altitude'),
                    desc: 'Oxygen support, high-altitude sickness & remote pass evacuation',
                    icon: Icons.landscape,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHazardCard(
                    key: 'landslide',
                    title: context.tr('mr_landslide'),
                    desc: 'Rockfall entrapment, blocked mountain highway assistance',
                    icon: Icons.terrain,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHazardCard(
                    key: 'snow',
                    title: context.tr('mr_snow'),
                    desc: 'Black ice, snow chain assistance, sub-zero cold start',
                    icon: Icons.ac_unit,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHazardCard(
                    key: 'stuck',
                    title: context.tr('mr_slipped'),
                    desc: 'Winch pull-out from gorge, ditch recovery, steep incline extraction',
                    icon: Icons.minor_crash,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHazardCard(
                    key: 'trek',
                    title: context.tr('mr_trek'),
                    desc: 'Pilgrimage route / trekking emergency response team',
                    icon: Icons.hiking,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: '${context.tr('request_mountain_rescue')} →',
                    backgroundColor: const Color(0xFF059669),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ConfirmLocationScreen(
                            serviceType: 'Himalayan Mountain Rescue',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHazardCard({
    required String key,
    required String title,
    required String desc,
    required IconData icon,
    required bool isDark,
  }) {
    final isSelected = _selectedHazards.contains(key);

    return InkWell(
      onTap: () => _toggleHazard(key),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF064E3B) : const Color(0xFFECFDF5))
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF059669) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF059669) : AppColors.mountainSlate.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.mountainSlate,
                size: 22,
              ),
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
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isSelected,
              activeColor: const Color(0xFF059669),
              onChanged: (_) => _toggleHazard(key),
            ),
          ],
        ),
      ),
    );
  }
}
