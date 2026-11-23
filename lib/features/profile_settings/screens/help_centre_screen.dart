import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../live_tracking/screens/in_app_chat_screen.dart';

class HelpCentreScreen extends StatelessWidget {
  const HelpCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_HelpTopic> topics = [
      _HelpTopic(
        title: 'Frequently Asked Questions (FAQ)',
        subtitle: 'अक्सर पूछे जाने वाले प्रश्न',
        icon: Icons.quiz_outlined,
      ),
      _HelpTopic(
        title: 'Mountain Rescue Guidelines',
        subtitle: 'पहाड़ी बचाव दिशानिर्देश',
        icon: Icons.menu_book_outlined,
      ),
      _HelpTopic(
        title: 'Service & Booking Assistance',
        subtitle: 'सेवा एवं बुकिंग सहायता',
        icon: Icons.car_repair,
      ),
      _HelpTopic(
        title: 'Payment, UPI & Refund Inquiries',
        subtitle: 'भुगतान और रिफंड सहायता',
        icon: Icons.account_balance_wallet_outlined,
      ),
      _HelpTopic(
        title: 'Report an Incident / Issue',
        subtitle: 'समस्या की रिपोर्ट करें',
        icon: Icons.report_problem_outlined,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('help_centre'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Search Input
            TextField(
              decoration: InputDecoration(
                hintText: 'Search help topics / खोजें...',
                prefixIcon: const Icon(Icons.search, color: AppColors.mountainSlate),
                filled: true,
                fillColor: isDark ? AppColors.darkCard : Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Topics list
            ...topics.map((t) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(t.icon, color: AppColors.primary, size: 20),
                  ),
                  title: Text(
                    t.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  subtitle: Text(
                    t.subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.mountainSlate),
                  onTap: () {},
                ),
              );
            }),
            const SizedBox(height: 24),

            // Live Chat with Support CTA
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const InAppChatScreen()),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.headset_mic, color: Colors.white, size: 28),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chat with Support (Live • 24×7)',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Instant assistance from our Himalayan dispatch center',
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpTopic {
  final String title;
  final String subtitle;
  final IconData icon;

  _HelpTopic({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
