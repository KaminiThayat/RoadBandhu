import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _emergencyAlerts = true;
  bool _rescueUpdates = true;
  bool _roadWeatherAlerts = true;
  bool _promotions = false;
  bool _accountSecurity = true;

  bool _pushPref = true;
  bool _smsPref = true;
  bool _emailPref = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('notification_settings'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Text(
            'Manage what alerts you receive',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 16),

          _buildToggle(
            title: 'Emergency Alerts (आपातकालीन अलर्ट)',
            subtitle: 'Critical crash, rescue dispatch and medical SOS',
            value: _emergencyAlerts,
            onChanged: (v) => setState(() => _emergencyAlerts = v),
            isDark: isDark,
          ),
          _buildToggle(
            title: 'Rescue & Service Updates (रेस्क्यू अपडेट)',
            subtitle: 'Mechanic location, ETA countdown and service progress',
            value: _rescueUpdates,
            onChanged: (v) => setState(() => _rescueUpdates = v),
            isDark: isDark,
          ),
          _buildToggle(
            title: 'Road & Weather Alerts (सड़क व मौसम)',
            subtitle: 'Landslides, heavy snow, road closures on your route',
            value: _roadWeatherAlerts,
            onChanged: (v) => setState(() => _roadWeatherAlerts = v),
            isDark: isDark,
          ),
          _buildToggle(
            title: 'Promotions & Offers (ऑफर एवं छूट)',
            subtitle: 'Seasonal roadside membership discounts and rewards',
            value: _promotions,
            onChanged: (v) => setState(() => _promotions = v),
            isDark: isDark,
          ),
          _buildToggle(
            title: 'Account & Security Alerts (सुरक्षा अलर्ट)',
            subtitle: 'New login attempts, password changes and OTPs',
            value: _accountSecurity,
            onChanged: (v) => setState(() => _accountSecurity = v),
            isDark: isDark,
          ),
          const SizedBox(height: 24),

          Text(
            'Alert Channels / अलर्ट प्राथमिकता',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  value: _pushPref,
                  activeColor: AppColors.primary,
                  title: const Text('Push Notification (पुश नोटिफिकेशन)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  onChanged: (v) => setState(() => _pushPref = v!),
                ),
                const Divider(height: 1),
                CheckboxListTile(
                  value: _smsPref,
                  activeColor: AppColors.primary,
                  title: const Text('SMS (एसएमएस - High Priority for Mountains)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  onChanged: (v) => setState(() => _smsPref = v!),
                ),
                const Divider(height: 1),
                CheckboxListTile(
                  value: _emailPref,
                  activeColor: AppColors.primary,
                  title: const Text('Email (ईमेल)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  onChanged: (v) => setState(() => _emailPref = v!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: SwitchListTile(
        value: value,
        activeColor: AppColors.primary,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
