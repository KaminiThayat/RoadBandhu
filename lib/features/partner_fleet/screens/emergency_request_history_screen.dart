import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';

class EmergencyRequestHistoryScreen extends StatefulWidget {
  const EmergencyRequestHistoryScreen({super.key});

  @override
  State<EmergencyRequestHistoryScreen> createState() => _EmergencyRequestHistoryScreenState();
}

class _EmergencyRequestHistoryScreenState extends State<EmergencyRequestHistoryScreen> {
  int _selectedFilter = 0; // 0: All, 1: Completed, 2: In Progress/Cancelled

  final List<_EmergencyLog> _logs = [
    _EmergencyLog(
      id: 'RR-784532',
      serviceType: 'Accident Help & Extraction',
      hindiType: 'दुर्घटना सहायता',
      date: '12 Jan 2026, 04:32 PM',
      location: 'Uttarkashi Pass (NH-108), Uttarakhand',
      assignedUnit: 'Uttarakhand Rescue Team #4',
      status: BadgeStatus.completed,
      statusLabel: 'Completed / पूर्ण',
      icon: Icons.car_crash,
      color: AppColors.alertHigh,
    ),
    _EmergencyLog(
      id: 'RR-784519',
      serviceType: 'Vehicle Breakdown Assistance',
      hindiType: 'वाहन खराबी',
      date: '08 Jan 2026, 11:15 AM',
      location: 'Rudraprayag Mountain Highway, UK',
      assignedUnit: 'Rajesh Auto Care',
      status: BadgeStatus.completed,
      statusLabel: 'Completed / पूर्ण',
      icon: Icons.car_repair,
      color: const Color(0xFF2563EB),
    ),
    _EmergencyLog(
      id: 'RR-784490',
      serviceType: 'Mountain Rescue (Cliff Winch)',
      hindiType: 'पहाड़ी रेस्क्यू',
      date: '05 Jan 2026, 07:20 PM',
      location: 'Chopta - Tungnath Snow Ridge, UK',
      assignedUnit: 'Garhwal Quick Rescue Squad',
      status: BadgeStatus.inProgress,
      statusLabel: 'In Progress / प्रगति में',
      icon: Icons.terrain,
      color: const Color(0xFF059669),
    ),
    _EmergencyLog(
      id: 'RR-784402',
      serviceType: 'Medical Emergency & Trauma Care',
      hindiType: 'चिकित्सा आपातकाल',
      date: '02 Jan 2026, 09:05 AM',
      location: 'Chamoli - Badrinath Road (NH-7)',
      assignedUnit: '108 Ambulance Unit #12',
      status: BadgeStatus.completed,
      statusLabel: 'Completed / पूर्ण',
      icon: Icons.medical_services,
      color: const Color(0xFFE11D48),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('emergency_request_history'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs (All / Completed / In Progress)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilter(0, 'All / सभी'),
                const SizedBox(width: 8),
                _buildFilter(1, 'Completed / पूर्ण'),
                const SizedBox(width: 8),
                _buildFilter(2, 'Active / सक्रिय'),
              ],
            ),
          ),

          // Logs List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _logs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final log = _logs[index];
                return Container(
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
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: log.color.withAlpha(20),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(log.icon, color: log.color, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  log.serviceType,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                                  ),
                                ),
                                Text(
                                  log.hindiType,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StatusBadge(text: log.statusLabel, status: log.status),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.mountainSlate),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              log.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Unit: ${log.assignedUnit}',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                          ),
                          Text(
                            log.date,
                            style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : AppColors.mountainSlate),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilter(int index, String label) {
    final isSelected = _selectedFilter == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedFilter = index),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : (isDark ? AppColors.darkCard : Colors.white),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.lightTextPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmergencyLog {
  final String id;
  final String serviceType;
  final String hindiType;
  final String date;
  final String location;
  final String assignedUnit;
  final BadgeStatus status;
  final String statusLabel;
  final IconData icon;
  final Color color;

  _EmergencyLog({
    required this.id,
    required this.serviceType,
    required this.hindiType,
    required this.date,
    required this.location,
    required this.assignedUnit,
    required this.status,
    required this.statusLabel,
    required this.icon,
    required this.color,
  });
}
