import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/screens/vehicle_details_screen.dart';
import 'service_history_screen.dart';
import 'document_locker_screen.dart';

class MyVehiclesScreen extends StatefulWidget {
  const MyVehiclesScreen({super.key});

  @override
  State<MyVehiclesScreen> createState() => _MyVehiclesScreenState();
}

class _MyVehiclesScreenState extends State<MyVehiclesScreen> {
  final List<_VehicleItem> _vehicles = [
    _VehicleItem(
      plate: 'UK07BX1234',
      name: 'Hyundai Creta (1.5L CRDi)',
      type: 'Car / SUV',
      fuel: 'Diesel',
      isPrimary: true,
      insuranceValidTill: '15 Dec 2026',
      pucValidTill: '30 Mar 2026',
    ),
    _VehicleItem(
      plate: 'UK07CD5678',
      name: 'Royal Enfield Himalayan 450',
      type: 'Motorcycle',
      fuel: 'Petrol',
      isPrimary: false,
      insuranceValidTill: '10 Nov 2026',
      pucValidTill: '12 Jan 2027',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('my_vehicles'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const VehicleDetailsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Vehicle Cards
            ..._vehicles.map((v) => _buildVehicleCard(v, isDark)),
            const SizedBox(height: 12),

            // Add New Vehicle Dotted Button
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const VehicleDetailsScreen()),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      context.tr('add_new_vehicle'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions: Documents, Service History, Reminders
            _buildActionTile(
              icon: Icons.folder_shared_outlined,
              title: context.tr('my_documents'),
              desc: 'RC, Driving License, Insurance, PUC in encrypted locker',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DocumentLockerScreen()),
                );
              },
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              icon: Icons.history,
              title: context.tr('service_history'),
              desc: 'Past rescue logs, breakdown receipts & invoices',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ServiceHistoryScreen()),
                );
              },
              isDark: isDark,
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              icon: Icons.notifications_active_outlined,
              title: 'Insurance & PUC Expiry Alerts',
              desc: 'Automated warnings before validity runs out',
              onTap: () {},
              isDark: isDark,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(_VehicleItem vehicle, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: vehicle.isPrimary ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: vehicle.isPrimary ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  vehicle.type.contains('Car') ? Icons.directions_car : Icons.two_wheeler,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicle.plate,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                          ),
                        ),
                        if (vehicle.isPrimary)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Primary / मुख्य',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.success),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicle.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fuel: ${vehicle.fuel}',
                style: const TextStyle(fontSize: 11, color: AppColors.mountainSlate, fontWeight: FontWeight.w600),
              ),
              Text(
                'Insurance: ${vehicle.insuranceValidTill}',
                style: const TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.mountainSlate),
          ],
        ),
      ),
    );
  }
}

class _VehicleItem {
  final String plate;
  final String name;
  final String type;
  final String fuel;
  final bool isPrimary;
  final String insuranceValidTill;
  final String pucValidTill;

  _VehicleItem({
    required this.plate,
    required this.name,
    required this.type,
    required this.fuel,
    required this.isPrimary,
    required this.insuranceValidTill,
    required this.pucValidTill,
  });
}
