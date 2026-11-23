import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  int _selectedFilter = 0;

  final List<_HistoryItem> _items = [
    _HistoryItem(
      title: 'Towing Service',
      hindiTitle: 'टोइंग सेवा',
      date: '20 Jan 2026, 04:32 PM',
      location: 'NH-7 Badrinath Road, Chamoli',
      amount: '₹1,800',
      icon: Icons.local_shipping,
      color: const Color(0xFFD97706),
      status: BadgeStatus.completed,
    ),
    _HistoryItem(
      title: 'Vehicle Breakdown Assistance',
      hindiTitle: 'वाहन खराबी सहायता',
      date: '12 Jan 2026, 11:20 AM',
      location: 'Joshimath Mountain Pass',
      amount: '₹450',
      icon: Icons.car_repair,
      color: const Color(0xFF2563EB),
      status: BadgeStatus.completed,
    ),
    _HistoryItem(
      title: 'Emergency Fuel Delivery',
      hindiTitle: 'ईंधन डिलीवरी (10L Diesel)',
      date: '02 Jan 2026, 07:15 PM',
      location: 'Rudraprayag Highway Curve',
      amount: '₹620',
      icon: Icons.local_gas_station,
      color: const Color(0xFF7C3AED),
      status: BadgeStatus.completed,
    ),
    _HistoryItem(
      title: 'Battery Jump Start',
      hindiTitle: 'बैटरी जंप स्टार्ट',
      date: '24 Dec 2025, 08:40 AM',
      location: 'Pipalkoti Sub-Zero Ridge',
      amount: '₹800',
      icon: Icons.battery_charging_full,
      color: const Color(0xFF0284C7),
      status: BadgeStatus.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('service_history'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilter(0, 'All / सभी'),
                const SizedBox(width: 8),
                _buildFilter(1, 'Rescue'),
                const SizedBox(width: 8),
                _buildFilter(2, 'Service'),
                const SizedBox(width: 8),
                _buildFilter(3, 'Payment'),
              ],
            ),
          ),

          // History list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: item.color.withAlpha(20),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(item.icon, color: item.color, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                                  ),
                                ),
                                Text(
                                  item.hindiTitle,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item.amount,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
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
                              item.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const StatusBadge(text: 'Completed', status: BadgeStatus.completed),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.date,
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.white38 : AppColors.mountainSlate,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Downloading PDF Invoice...')),
                              );
                            },
                            icon: const Icon(Icons.download, size: 14, color: AppColors.primary),
                            label: const Text(
                              'Download Invoice',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
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

class _HistoryItem {
  final String title;
  final String hindiTitle;
  final String date;
  final String location;
  final String amount;
  final IconData icon;
  final Color color;
  final BadgeStatus status;

  _HistoryItem({
    required this.title,
    required this.hindiTitle,
    required this.date,
    required this.location,
    required this.amount,
    required this.icon,
    required this.color,
    required this.status,
  });
}
