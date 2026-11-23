import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';

class LandslideAlertsScreen extends StatefulWidget {
  const LandslideAlertsScreen({super.key});

  @override
  State<LandslideAlertsScreen> createState() => _LandslideAlertsScreenState();
}

class _LandslideAlertsScreenState extends State<LandslideAlertsScreen> {
  int _selectedFilter = 0; // 0: All, 1: Road Block, 2: Landslide, 3: Other

  final List<_RoadAlert> _alerts = [
    _RoadAlert(
      title: 'Landslide - NH-7 (Badrinath Route)',
      location: 'Chamoli - Pipalkoti (Km 138)',
      status: 'Route Closed • Heavy Rockfall',
      timeAgo: '2 hours ago',
      severity: BadgeStatus.high,
      severityLabel: 'High Alert',
      icon: Icons.terrain,
    ),
    _RoadAlert(
      title: 'Road Block - Kedarnath Route',
      location: 'Guptkashi - Sonprayag Valley Road',
      status: 'Partial Movement • 1-way police convoy',
      timeAgo: '4 hours ago',
      severity: BadgeStatus.medium,
      severityLabel: 'Medium',
      icon: Icons.warning_rounded,
    ),
    _RoadAlert(
      title: 'Road Clear - Rishikesh-Joshimath Highway',
      location: 'Devprayag to Srinagar Garhwal (NH-58)',
      status: 'Normal Traffic Movement • Clear',
      timeAgo: 'Updated 30 min ago',
      severity: BadgeStatus.completed,
      severityLabel: 'Normal',
      icon: Icons.check_circle_outline,
    ),
    _RoadAlert(
      title: 'Heavy Snow Accumulation - Mana Pass Road',
      location: 'Badrinath to Mana Border Village',
      status: 'Snow Chains Mandatory for 4x4 Only',
      timeAgo: '1 hour ago',
      severity: BadgeStatus.medium,
      severityLabel: 'Caution',
      icon: Icons.ac_unit,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('roadblock_landslide_alerts'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilter(0, 'All / सभी'),
                const SizedBox(width: 8),
                _buildFilter(1, 'Road Block'),
                const SizedBox(width: 8),
                _buildFilter(2, 'Landslide'),
                const SizedBox(width: 8),
                _buildFilter(3, 'Clear'),
              ],
            ),
          ),

          // Alert Cards List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _alerts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final a = _alerts[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(a.icon, color: _getColor(a.severity), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              a.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                          StatusBadge(text: a.severityLabel, status: a.severity),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        a.location,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            a.status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _getColor(a.severity),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            a.timeAgo,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white38 : AppColors.mountainSlate,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Report New Obstacle Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              border: Border(top: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder)),
            ),
            child: SafeArea(
              top: false,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('GPS coordinates captured. Thank you for reporting!')),
                  );
                },
                icon: const Icon(Icons.add_location_alt, size: 20),
                label: const Text('Report Road Obstacle / बाधा की रिपोर्ट करें', style: TextStyle(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(BadgeStatus status) {
    if (status == BadgeStatus.high) return AppColors.alertHigh;
    if (status == BadgeStatus.medium) return AppColors.alertMedium;
    return AppColors.success;
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

class _RoadAlert {
  final String title;
  final String location;
  final String status;
  final String timeAgo;
  final BadgeStatus severity;
  final String severityLabel;
  final IconData icon;

  _RoadAlert({
    required this.title,
    required this.location,
    required this.status,
    required this.timeAgo,
    required this.severity,
    required this.severityLabel,
    required this.icon,
  });
}
