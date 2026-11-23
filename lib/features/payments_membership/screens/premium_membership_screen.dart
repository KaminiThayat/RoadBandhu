import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';

class PremiumMembershipScreen extends StatefulWidget {
  const PremiumMembershipScreen({super.key});

  @override
  State<PremiumMembershipScreen> createState() => _PremiumMembershipScreenState();
}

class _PremiumMembershipScreenState extends State<PremiumMembershipScreen> {
  int _selectedPlan = 1; // 0: Monthly, 1: Yearly (Recommended)

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('premium_membership'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Gold Crown Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFB45309), Color(0xFFD97706), Color(0xFFF59E0B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD97706).withAlpha(80),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.workspace_premium, color: Colors.white, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'RoadBandhu Premium',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Comprehensive Himalayan Safety & Peace of Mind',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Benefits Checklist
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              ),
              child: Column(
                children: [
                  _buildBenefit('Priority Emergency Support (प्राथमिक आपात सहायता)', isDark),
                  const Divider(height: 18),
                  _buildBenefit('Guaranteed Faster Response (24x7 Pan-India)', isDark),
                  const Divider(height: 18),
                  _buildBenefit('Free Towing (Up to 40 km / 2 incidents per year)', isDark),
                  const Divider(height: 18),
                  _buildBenefit('Coverage for up to 3 Family Vehicles (परिवार के वाहन)', isDark),
                  const Divider(height: 18),
                  _buildBenefit('Emergency Ditch Extraction & Mountain Lifeline Support', isDark),
                  const Divider(height: 18),
                  _buildBenefit('Exclusive 25% Off on Spare Parts & Battery Replacements', isDark),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Plans Selector
            Row(
              children: [
                Expanded(
                  child: _buildPlanCard(
                    index: 0,
                    title: 'Monthly Plan',
                    price: '₹199',
                    subtitle: 'Billed monthly',
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPlanCard(
                    index: 1,
                    title: 'Yearly Plan',
                    price: '₹1,499',
                    subtitle: 'Save 37% • Best Value',
                    isDark: isDark,
                    isPopular: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '★ Upgrade to Premium →',
              backgroundColor: const Color(0xFFD97706),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Welcome to RoadBandhu Premium! Priority Rescue Activated.'),
                    backgroundColor: Color(0xFFD97706),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefit(String title, bool isDark) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: AppColors.success, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard({
    required int index,
    required String title,
    required String price,
    required String subtitle,
    required bool isDark,
    bool isPopular = false,
  }) {
    final isSelected = _selectedPlan == index;

    return InkWell(
      onTap: () => setState(() => _selectedPlan = index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.darkSurface : const Color(0xFFFEF3C7))
              : (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFD97706) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD97706),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'BEST VALUE',
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900),
                ),
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: isSelected ? const Color(0xFFD97706) : (isDark ? Colors.white : AppColors.alpineNavy),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
