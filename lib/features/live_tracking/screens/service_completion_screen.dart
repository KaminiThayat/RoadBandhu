import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import 'rating_review_screen.dart';

class ServiceCompletionScreen extends StatelessWidget {
  final String issueTitle;
  final int serviceTimeMinutes;
  final int chargeAmount;

  const ServiceCompletionScreen({
    super.key,
    this.issueTitle = 'Battery Jump Start',
    this.serviceTimeMinutes = 24,
    this.chargeAmount = 800,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('service_completed'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Success checkmark badge
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.task_alt,
                color: AppColors.success,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('service_completed'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Your vehicle is operational and safe to drive.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Itemized Invoice Card
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
                  _buildSummaryItem('Service Performed', issueTitle, Icons.build_circle_outlined, isDark),
                  const Divider(height: 24),
                  _buildSummaryItem('Duration', '$serviceTimeMinutes min', Icons.timer_outlined, isDark),
                  const Divider(height: 24),
                  _buildSummaryItem('Technician', 'Rajesh Kumar (Verified)', Icons.person_outline, isDark),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Service Fee',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                        ),
                      ),
                      Text(
                        '₹$chargeAmount',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Vehicle Ready Check banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Vehicle is ready. Engine & battery health diagnostics passed.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF15803D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            CustomButton(
              text: '★ ${context.tr('rate_service')} →',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RatingReviewScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: context.tr('view_invoice'),
              isOutlined: true,
              icon: Icons.receipt_long,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Digital Invoice RR-784532 saved to Documents.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.mountainSlate),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }
}
