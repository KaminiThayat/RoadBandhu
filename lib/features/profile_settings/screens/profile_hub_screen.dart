import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/state/user_role_provider.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/screens/personal_details_screen.dart';
import '../../digital_garage/screens/my_vehicles_screen.dart';
import '../../digital_garage/screens/document_locker_screen.dart';
import '../../payments_membership/screens/wallet_upi_screen.dart';
import '../../offline_sos/screens/emergency_contacts_screen.dart';
import 'notification_settings_screen.dart';
import 'privacy_security_screen.dart';
import 'help_centre_screen.dart';
import 'helpline_247_screen.dart';
import '../../partner_fleet/screens/partner_registration_screen.dart';
import '../../partner_fleet/screens/emergency_request_history_screen.dart';

class ProfileHubScreen extends ConsumerWidget {
  const ProfileHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('profile'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: isDark ? Colors.amber : AppColors.alpineNavy,
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // User Header Profile Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mountainDark,
                      border: Border.all(color: AppColors.primary, width: 2.5),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amit Sharma',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Member since Jan 2024 • Dehradun',
                          style: TextStyle(fontSize: 11, color: AppColors.mountainSlate),
                        ),
                        const SizedBox(height: 6),
                        const StatusBadge(text: 'Verified User', status: BadgeStatus.verified),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 20),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Partner Mode Switch / Registration Banner (Screen 46)
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PartnerRegistrationScreen()),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.handyman, color: Colors.amber, size: 26),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Join Partner Network (Mechanic / Fleet)',
                            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Provide rescue services on mountain routes',
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.white70),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Menu Tiles
            _buildProfileMenuItem(
              icon: Icons.person_outline,
              title: context.tr('personal_details'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.directions_car_outlined,
              title: context.tr('my_vehicles'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyVehiclesScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.folder_shared_outlined,
              title: context.tr('my_documents'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DocumentLockerScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.contact_emergency_outlined,
              title: context.tr('emergency_contacts'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EmergencyContactsScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.account_balance_wallet_outlined,
              title: context.tr('wallet_upi'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WalletUPIScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.history,
              title: context.tr('emergency_request_history'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EmergencyRequestHistoryScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.notifications_none,
              title: context.tr('notification_settings'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.shield_outlined,
              title: context.tr('privacy_security'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.help_outline,
              title: context.tr('help_centre'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HelpCentreScreen()),
              ),
              isDark: isDark,
            ),
            _buildProfileMenuItem(
              icon: Icons.headset_mic_outlined,
              title: context.tr('helpline_247'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Helpline247Screen()),
              ),
              isDark: isDark,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 22),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.mountainSlate),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
