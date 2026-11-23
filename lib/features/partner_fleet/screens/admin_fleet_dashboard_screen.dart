import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/state/user_role_provider.dart';
import '../../../core/widgets/rescue_map_view.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';
import '../../navigation/main_nav_screen.dart';
import 'emergency_request_history_screen.dart';

class AdminFleetDashboardScreen extends ConsumerStatefulWidget {
  const AdminFleetDashboardScreen({super.key});

  @override
  ConsumerState<AdminFleetDashboardScreen> createState() => _AdminFleetDashboardScreenState();
}

class _AdminFleetDashboardScreenState extends ConsumerState<AdminFleetDashboardScreen> {
  int _selectedTab = 0; // 0: Overview, 1: Rescue Fleet, 2: Management

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('admin_fleet_dashboard'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EmergencyRequestHistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: AppColors.alertHigh),
            tooltip: 'Switch to User View',
            onPressed: () {
              ref.read(userRoleProvider.notifier).setRole(AppUserRole.customer);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role Switch Capsule
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.admin_panel_settings, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Admin & Fleet Dispatch Mode Active',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(userRoleProvider.notifier).setRole(AppUserRole.customer);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text('Back to User', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Top Tabs: Overview / Rescue Fleet / Management
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              ),
              child: Row(
                children: [
                  _buildTab(0, 'Overview / अवलोकन'),
                  _buildTab(1, 'Rescue Fleet'),
                  _buildTab(2, 'Management'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 4 KPI Cards Grid
            Row(
              children: [
                _buildKPICard('1,248', 'Active Requests', Icons.emergency_share, AppColors.alertHigh, isDark),
                const SizedBox(width: 10),
                _buildKPICard('1,032', 'Resolved Today', Icons.task_alt, AppColors.success, isDark),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildKPICard('486', 'Active Partners', Icons.handyman, const Color(0xFF2563EB), isDark),
                const SizedBox(width: 10),
                _buildKPICard('127', 'Rescue Fleet 4x4', Icons.local_shipping, const Color(0xFFD97706), isDark),
              ],
            ),
            const SizedBox(height: 20),

            // Live Operations Map Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Live Operations / लाइव संचालन',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.fiber_manual_record, color: AppColors.success, size: 8),
                      SizedBox(width: 4),
                      Text('LIVE 60fps', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            RescueMapView(
              height: 220,
              locationTitle: 'Chamoli - Rudraprayag - Joshimath Sector',
              locationSubtitle: '14 Active Dispatches En-Route • 3 Landslides Monitored',
              showMechanic: true,
              showRoute: true,
            ),
            const SizedBox(height: 20),

            // Control Actions Grid
            Text(
              'Fleet Management Actions',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildActionCard(
                  title: 'Assign Request',
                  subtitle: 'अनुरोध असाइन करें',
                  icon: Icons.assignment_ind_outlined,
                  color: AppColors.primary,
                  isDark: isDark,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                _buildActionCard(
                  title: 'Fleet Tracking',
                  subtitle: 'फ्लीट ट्रैकिंग GPS',
                  icon: Icons.radar,
                  color: const Color(0xFF2563EB),
                  isDark: isDark,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildActionCard(
                  title: 'Partner Roster',
                  subtitle: 'पार्टनर प्रबंधन',
                  icon: Icons.group_outlined,
                  color: const Color(0xFF059669),
                  isDark: isDark,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                _buildActionCard(
                  title: 'Reports & Logs',
                  subtitle: 'रिपोर्ट व विश्लेषण',
                  icon: Icons.bar_chart,
                  color: const Color(0xFF7C3AED),
                  isDark: isDark,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const EmergencyRequestHistoryScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.mountainSlate,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKPICard(String count, String label, IconData icon, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
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
