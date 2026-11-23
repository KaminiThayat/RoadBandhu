import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/state/user_role_provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../dashboard/screens/home_dashboard_screen.dart';
import '../dashboard/screens/all_services_screen.dart';
import '../live_tracking/screens/live_rescue_tracking_screen.dart';
import '../digital_garage/screens/my_vehicles_screen.dart';
import '../profile_settings/screens/profile_hub_screen.dart';
import '../emergency_sos/screens/emergency_sos_screen.dart';
import '../partner_fleet/screens/admin_fleet_dashboard_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentRole = ref.watch(userRoleProvider);

    // If role is switched to admin fleet dashboard, show Screen 47
    if (currentRole == AppUserRole.admin) {
      return const AdminFleetDashboardScreen();
    }

    final List<Widget> screens = [
      HomeDashboardScreen(onNavigateToTab: _onTabTapped),
      const AllServicesScreen(),
      const LiveRescueTrackingScreen(),
      const MyVehiclesScreen(),
      const ProfileHubScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EmergencySOSScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 6,
        shape: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color(0xFFFF5252),
                AppColors.primary,
                Color(0xFFB71C1C),
              ],
            ),
          ),
          child: const Center(
            child: Text(
              'SOS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: isDark ? AppColors.darkSurface : Colors.white,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_filled, 'Home'),
              _buildNavItem(1, Icons.grid_view_rounded, 'Services'),
              const SizedBox(width: 44), // Space for center SOS button
              _buildNavItem(2, Icons.radar_outlined, 'Track'),
              _buildNavItem(3, Icons.directions_car_outlined, 'Vehicles'),
              _buildNavItem(4, Icons.person_outline, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final color = isSelected
        ? AppColors.primary
        : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);

    return InkWell(
      onTap: () => _onTabTapped(index),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
