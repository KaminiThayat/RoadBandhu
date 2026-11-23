import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/status_badge.dart';
import 'mechanic_voice_call_screen.dart';

class MechanicAssignedScreen extends StatelessWidget {
  const MechanicAssignedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mechanic Profile',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Avatar with verified badge
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mountainDark,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 54),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Rajesh Kumar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  '4.8 (2,316+ Services Completed)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const StatusBadge(text: 'Verified Rescue Partner', status: BadgeStatus.verified),
            const SizedBox(height: 24),

            // Profile info cards
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Column(
                children: [
                  _buildProfileRow(
                    icon: Icons.workspace_premium_outlined,
                    title: 'Experience',
                    desc: '8+ Years on Himalayan Highways & Hill Passes',
                    isDark: isDark,
                  ),
                  const Divider(height: 24),
                  _buildProfileRow(
                    icon: Icons.location_on_outlined,
                    title: 'Service Coverage',
                    desc: 'Chamoli, NH-7, Badrinath Corridor & Surrounding Hills',
                    isDark: isDark,
                  ),
                  const Divider(height: 24),
                  _buildProfileRow(
                    icon: Icons.build_circle_outlined,
                    title: 'Specialized In',
                    desc: 'Breakdown, Battery Jumpstart, Tyre Vulcanization, Engine Overheating, Winch Towing',
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: 'Proceed to Call Rajesh →',
              icon: Icons.call,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MechanicVoiceCallScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow({
    required IconData icon,
    required String title,
    required String desc,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
