import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import '../../live_tracking/screens/live_rescue_tracking_screen.dart';
import '../../live_tracking/screens/mechanic_voice_call_screen.dart';
import '../../live_tracking/screens/in_app_chat_screen.dart';

class RescueConfirmationScreen extends StatelessWidget {
  final String partnerName;
  final int etaMinutes;
  final double distanceKm;
  final String serviceType;
  final String location;
  final String requestId;

  const RescueConfirmationScreen({
    super.key,
    this.partnerName = 'Rajesh Auto Care & Mountain Recovery',
    this.etaMinutes = 18,
    this.distanceKm = 4.6,
    this.serviceType = 'Mountain Rescue',
    this.location = 'Chamoli - Badrinath Road (NH-7), Uttarakhand',
    this.requestId = 'RR-784532',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rescue Confirmed',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
                Icons.check_circle,
                color: AppColors.success,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('rescue_request_sent'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Your assigned rescue squad is en-route.',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Ticket Details Card
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
                  _buildDetailRow(context.tr('request_id'), requestId, isDark, isHighlight: true),
                  const Divider(height: 20),
                  _buildDetailRow('Assigned Unit', partnerName, isDark),
                  const Divider(height: 20),
                  _buildDetailRow('Service', serviceType, isDark),
                  const Divider(height: 20),
                  _buildDetailRow('Location', location, isDark),
                  const Divider(height: 20),
                  _buildDetailRow('Estimated Arrival', '$etaMinutes min ($distanceKm km)', isDark, isSuccess: true),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Primary CTA: Track Live Rescue (Screen 17)
            CustomButton(
              text: '🚨 ${context.tr('track_live_rescue')} →',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LiveRescueTrackingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),

            // Quick Call & Chat Actions
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Call Unit',
                    isOutlined: true,
                    icon: Icons.phone,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MechanicVoiceCallScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Chat Now',
                    isOutlined: true,
                    icon: Icons.chat_bubble_outline,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const InAppChatScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    bool isDark, {
    bool isHighlight = false,
    bool isSuccess = false,
  }) {
    Color valueColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    if (isHighlight) valueColor = AppColors.primary;
    if (isSuccess) valueColor = AppColors.success;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
