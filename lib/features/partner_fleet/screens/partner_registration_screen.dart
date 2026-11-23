import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/state/user_role_provider.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/localization/app_localizations.dart';
import 'admin_fleet_dashboard_screen.dart';

class PartnerRegistrationScreen extends ConsumerStatefulWidget {
  const PartnerRegistrationScreen({super.key});

  @override
  ConsumerState<PartnerRegistrationScreen> createState() => _PartnerRegistrationScreenState();
}

class _PartnerRegistrationScreenState extends ConsumerState<PartnerRegistrationScreen> {
  int _selectedCategory = 0; // 0: Mechanic, 1: Towing, 2: Fleet
  final _workshopController = TextEditingController(text: 'Rajesh Auto Care & Winch');
  final _ownerController = TextEditingController(text: 'Rajesh Kumar');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _cityController = TextEditingController(text: 'Chamoli / Pipalkoti, UK');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('partner_registration'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Hero
            Text(
              'Join RoadBandhu Partner Network',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Empowering local mechanics, towing drivers & mountain rescue squads',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 16),

            // Category Tabs
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              ),
              child: Row(
                children: [
                  _buildTab(0, 'Mechanic / मैकेनिक'),
                  _buildTab(1, 'Towing / टोइंग'),
                  _buildTab(2, 'Fleet / रेस्क्यू'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Benefits Checklist Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF86EFAC)),
              ),
              child: Column(
                children: [
                  _buildBenefit('Get Verified & Certified by RoadBandhu India'),
                  _buildBenefit('Receive Instant Nearby SOS & Rescue Dispatch Alerts'),
                  _buildBenefit('Guaranteed Direct Bank & UPI Payouts for every job'),
                  _buildBenefit('Exclusive 24x7 Mountain Towing & Diagnostic Tools'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form inputs
            CustomTextField(
              label: 'Workshop / Service Station Name',
              hint: 'e.g. Rajesh Auto Care',
              controller: _workshopController,
              prefixIcon: Icons.store_outlined,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Lead Mechanic / Owner Name',
              hint: 'e.g. Rajesh Kumar',
              controller: _ownerController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Contact Mobile Number (+91)',
              hint: '+91 98765 43210',
              controller: _phoneController,
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              label: 'Service City & Mountain Corridor',
              hint: 'e.g. Chamoli / Badrinath Road',
              controller: _cityController,
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: 'Register as Verified Partner →',
              backgroundColor: const Color(0xFF059669),
              onPressed: () {
                ref.read(userRoleProvider.notifier).setRole(AppUserRole.partner);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registered! Switched to Partner Dispatch Mode.'),
                    backgroundColor: Color(0xFF059669),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 14),

            // Quick Switch to Fleet Admin
            Center(
              child: TextButton.icon(
                onPressed: () {
                  ref.read(userRoleProvider.notifier).setRole(AppUserRole.admin);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AdminFleetDashboardScreen()),
                  );
                },
                icon: const Icon(Icons.admin_panel_settings, size: 18, color: AppColors.primary),
                label: const Text(
                  'Switch to Admin & Fleet Operations Dashboard →',
                  style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = _selectedCategory == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = index),
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

  Widget _buildBenefit(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF15803D), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF15803D)),
            ),
          ),
        ],
      ),
    );
  }
}
