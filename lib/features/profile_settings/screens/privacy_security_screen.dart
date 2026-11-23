import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _twoFactorEnabled = true;
  bool _biometricUnlock = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('privacy_security'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Security Shield Banner
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF93C5FD)),
            ),
            child: const Row(
              children: [
                Icon(Icons.security, color: Color(0xFF2563EB), size: 28),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your data is safe with RoadBandhu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E40AF),
                        ),
                      ),
                      Text(
                        'End-to-end encrypted GPS transmissions & credential safety.',
                        style: TextStyle(fontSize: 11, color: Color(0xFF3B82F6)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            desc: 'Last updated 3 months ago',
            onTap: () {},
            isDark: isDark,
          ),
          _buildTile(
            icon: Icons.location_on_outlined,
            title: 'Location Access Permissions',
            desc: 'While using app (High accuracy for mountain GPS)',
            onTap: () {},
            isDark: isDark,
          ),
          _buildTile(
            icon: Icons.devices,
            title: 'Active Login Sessions',
            desc: 'Vivo 1906 (This Device) • Windows 11 Chrome',
            onTap: () {},
            isDark: isDark,
          ),
          const SizedBox(height: 12),

          // 2FA Toggle
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            child: SwitchListTile(
              value: _twoFactorEnabled,
              activeColor: AppColors.primary,
              title: const Text('Two-Factor Authentication (2FA)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
              subtitle: const Text('Require OTP for all logins & withdrawals', style: TextStyle(fontSize: 11, color: AppColors.mountainSlate)),
              onChanged: (v) => setState(() => _twoFactorEnabled = v),
            ),
          ),
          const SizedBox(height: 10),

          // Biometrics
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            child: SwitchListTile(
              value: _biometricUnlock,
              activeColor: AppColors.primary,
              title: const Text('Biometric Fingerprint / Face Unlock', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
              subtitle: const Text('Instant authentication without typing password', style: TextStyle(fontSize: 11, color: AppColors.mountainSlate)),
              onChanged: (v) => setState(() => _biometricUnlock = v),
            ),
          ),
          const SizedBox(height: 24),

          // Delete Account
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deletion requests require 48-hr verification.')),
              );
            },
            icon: const Icon(Icons.delete_outline, color: AppColors.alertHigh, size: 20),
            label: const Text(
              'Delete Account / खाता हटाएं',
              style: TextStyle(color: AppColors.alertHigh, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
        subtitle: Text(
          desc,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.mountainSlate),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
