import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localizations.dart';
import '../../emergency_sos/screens/emergency_sos_screen.dart';
import '../../live_tracking/screens/in_app_chat_screen.dart';

class Helpline247Screen extends StatelessWidget {
  const Helpline247Screen({super.key});

  Future<void> _makeCall(BuildContext context, String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    try {
      await launchUrl(launchUri);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dialing $number...')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('helpline_247'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Helpline Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 40 : 10),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withAlpha(20),
                    ),
                    child: const Icon(Icons.support_agent, color: AppColors.primary, size: 40),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'RoadBandhu 24×7 Helpline',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Toll-Free Pan-India Emergency Assistance',
                    style: TextStyle(fontSize: 12, color: AppColors.mountainSlate),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '1800-123-ROAD (7623)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: '📞 ${context.tr('call_now')}',
                    onPressed: () => _makeCall(context, AppConstants.helplinePhone),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Secondary Options: Chat / Request Callback
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const InAppChatScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.chat_bubble_outline, color: Color(0xFF2563EB), size: 26),
                          SizedBox(height: 8),
                          Text('Chat Support', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                          Text('(Live 24×7)', style: TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Callback requested. An agent will call you in 3 minutes.')),
                      );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.phone_callback_outlined, color: Color(0xFFD97706), size: 26),
                          SizedBox(height: 8),
                          Text('Request Call Back', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                          Text('Within 3 mins', style: TextStyle(fontSize: 11, color: AppColors.mountainSlate)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Red Emergency SOS button shortcut
            CustomButton(
              text: '🚨 Emergency SOS Direct Trigger',
              backgroundColor: const Color(0xFFDC2626),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EmergencySOSScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
