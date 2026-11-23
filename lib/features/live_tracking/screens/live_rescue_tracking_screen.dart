import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/rescue_map_view.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';
import 'mechanic_assigned_screen.dart';
import 'mechanic_voice_call_screen.dart';
import 'mechanic_video_call_screen.dart';
import 'in_app_chat_screen.dart';
import 'eta_route_map_screen.dart';
import 'service_completion_screen.dart';

class LiveRescueTrackingScreen extends StatefulWidget {
  const LiveRescueTrackingScreen({super.key});

  @override
  State<LiveRescueTrackingScreen> createState() => _LiveRescueTrackingScreenState();
}

class _LiveRescueTrackingScreenState extends State<LiveRescueTrackingScreen> {
  final int _etaRemainingMinutes = 18;
  final double _distanceRemainingKm = 6.4;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('live_tracking'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.fiber_manual_record, color: AppColors.success, size: 10),
                SizedBox(width: 4),
                Text(
                  'LIVE',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Live Map Area
          Expanded(
            child: RescueMapView(
              height: double.infinity,
              locationTitle: 'NH-7 Badrinath Road, Chamoli',
              locationSubtitle: 'Mechanic Rajesh Kumar is 6.4 km away',
              showMechanic: true,
              showRoute: true,
              onExpand: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ETARouteMapScreen(),
                  ),
                );
              },
            ),
          ),

          // Bottom Tracking Card (Screen 17)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(isDark ? 60 : 15),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mechanic Quick Profile Row
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MechanicAssignedScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mountainDark,
                            border: Border.all(color: AppColors.primary, width: 2),
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Rajesh Kumar',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const StatusBadge(text: 'Verified', status: BadgeStatus.verified),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Rescue On The Way • 8+ Yrs Exp',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.mountainSlate),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ETA and Distance Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Estimated Arrival',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.mountainSlate,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_etaRemainingMinutes min',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                        Column(
                          children: [
                            const Text(
                              'Remaining Distance',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.mountainSlate,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_distanceRemainingKm km',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white : AppColors.alpineNavy,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Communication Actions (Voice Call, Video Call, Chat)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MechanicVoiceCallScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.call, size: 18),
                          label: const Text('Call', style: TextStyle(fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MechanicVideoCallScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.videocam, size: 18),
                          label: const Text('Video', style: TextStyle(fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0284C7),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const InAppChatScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat, size: 18),
                          label: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mountainDark,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Simulation shortcut to complete service (Screen 23)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ServiceCompletionScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'Mechanic Arrived? View Service Completion & Invoice →',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
