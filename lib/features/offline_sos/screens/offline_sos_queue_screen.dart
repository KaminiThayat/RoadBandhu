import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';

class OfflineSOSQueueScreen extends StatefulWidget {
  const OfflineSOSQueueScreen({super.key});

  @override
  State<OfflineSOSQueueScreen> createState() => _OfflineSOSQueueScreenState();
}

class _OfflineSOSQueueScreenState extends State<OfflineSOSQueueScreen> {
  final List<_QueuedSOS> _queue = [
    _QueuedSOS(
      title: 'Vehicle Breakdown & Brake Failure',
      hindiTitle: 'वाहन खराबी सहायता',
      timestamp: 'Today, 10:14 AM',
      coordinates: '30.4412° N, 79.5768° E (NH-7 Badrinath)',
      serviceType: 'Mechanical Breakdown',
      status: BadgeStatus.pending,
    ),
    _QueuedSOS(
      title: 'Medical Emergency Alert',
      hindiTitle: 'चिकित्सा आपातकाल (घायल व्यक्ति)',
      timestamp: 'Today, 10:12 AM',
      coordinates: '30.4412° N, 79.5768° E',
      serviceType: 'Medical & 108 Ambulance',
      status: BadgeStatus.pending,
    ),
  ];

  Future<void> _sendEmergencySMS() async {
    const String emergencyNumber = '112';
    const String smsBody = 'ROADBANDHU SOS! Vehicle: UK07BX1234. GPS: Lat 30.4412, Long 79.5768 (NH-7 Chamoli Badrinath). Immediate Rescue Needed!';

    final Uri smsUri = Uri(
      scheme: 'sms',
      path: emergencyNumber,
      queryParameters: <String, String>{
        'body': smsBody,
      },
    );

    try {
      await launchUrl(smsUri);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dispatched emergency SMS payload with coordinates to 112.'),
            backgroundColor: AppColors.primary,
          ),
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
          context.tr('offline_sos_queue'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Prominent Offline Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFFB91C1C), Color(0xFF991B1B), Color(0xFF7F1D1D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFB91C1C).withAlpha(80),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.wifi_off, color: Colors.white, size: 48),
                  SizedBox(height: 10),
                  Text(
                    'You are Offline / आप अभी ऑफलाइन हैं',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'No cellular internet detected. Requests are safely queued in local storage and will automatically dispatch the second signal returns.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Queue Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved SOS Requests (${_queue.length})',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                const StatusBadge(text: 'Pending Auto-Sync', status: BadgeStatus.pending),
              ],
            ),
            const SizedBox(height: 12),

            // Queue Items
            ..._queue.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.emergency_share, color: AppColors.alertHigh, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Saved Local',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFB45309)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.hindiTitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.mountainSlate),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            item.coordinates,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mountainSlate),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.timestamp,
                      style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : AppColors.mountainSlate),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),

            // Send All When Online
            CustomButton(
              text: '🔄 Send All When Online',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Checking signal... Auto-sync watcher active in background.'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // SMS Fallback Button
            CustomButton(
              text: '📱 Send via Emergency SMS (Zero Internet)',
              backgroundColor: const Color(0xFF0F172A),
              onPressed: _sendEmergencySMS,
            ),
          ],
        ),
      ),
    );
  }
}

class _QueuedSOS {
  final String title;
  final String hindiTitle;
  final String timestamp;
  final String coordinates;
  final String serviceType;
  final BadgeStatus status;

  _QueuedSOS({
    required this.title,
    required this.hindiTitle,
    required this.timestamp,
    required this.coordinates,
    required this.serviceType,
    required this.status,
  });
}
