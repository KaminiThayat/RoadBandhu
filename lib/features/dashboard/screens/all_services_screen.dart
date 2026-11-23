import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../emergency_sos/screens/emergency_sos_screen.dart';
import '../../emergency_sos/screens/mountain_rescue_screen.dart';
import '../../mountain_services/screens/towing_service_screen.dart';
import '../../mountain_services/screens/fuel_delivery_screen.dart';
import '../../mountain_services/screens/battery_jumpstart_screen.dart';
import '../../mountain_services/screens/tyre_puncture_screen.dart';
import '../../safety_intelligence/screens/nearby_hospital_screen.dart';
import '../../safety_intelligence/screens/landslide_alerts_screen.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_ServiceItem> services = [
      _ServiceItem(
        title: context.tr('service_breakdown'),
        desc: 'Engine, clutch, mechanical on-road assistance',
        icon: Icons.car_repair,
        color: const Color(0xFF2563EB),
        routeBuilder: () => const EmergencySOSScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_accident'),
        desc: 'Immediate emergency crash response & rescue',
        icon: Icons.car_crash,
        color: const Color(0xFFDC2626),
        routeBuilder: () => const EmergencySOSScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_medical'),
        desc: 'Ambulance 108, doctor support, trauma care',
        icon: Icons.medical_services,
        color: const Color(0xFFE11D48),
        routeBuilder: () => const NearbyHospitalScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_mountain'),
        desc: 'High altitude, snow, cliff winch & ditch extraction',
        icon: Icons.terrain,
        color: const Color(0xFF059669),
        routeBuilder: () => const MountainRescueScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_towing'),
        desc: 'Flatbed, hydraulic winch, long distance tow',
        icon: Icons.local_shipping,
        color: const Color(0xFFD97706),
        routeBuilder: () => const TowingServiceScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_fuel'),
        desc: 'Emergency Petrol, Diesel, Winter-grade Diesel',
        icon: Icons.local_gas_station,
        color: const Color(0xFF7C3AED),
        routeBuilder: () => const FuelDeliveryScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_battery'),
        desc: 'Cold start booster jump, battery diagnostics',
        icon: Icons.battery_charging_full,
        color: const Color(0xFF0284C7),
        routeBuilder: () => const BatteryJumpstartScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_tyre'),
        desc: 'Puncture repair, stepney replacement, tyre fix',
        icon: Icons.tire_repair,
        color: const Color(0xFFEA580C),
        routeBuilder: () => const TyrePunctureScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_roadblock'),
        desc: 'Live landslide, avalanche & roadblock warnings',
        icon: Icons.warning_rounded,
        color: const Color(0xFFB45309),
        routeBuilder: () => const LandslideAlertsScreen(),
      ),
      _ServiceItem(
        title: context.tr('service_other'),
        desc: 'General road assistance & locksmith services',
        icon: Icons.support_agent,
        color: const Color(0xFF475569),
        routeBuilder: () => const EmergencySOSScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('all_services'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final s = services[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => s.routeBuilder()),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: s.color.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(s.icon, color: s.color, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s.desc,
                          style: TextStyle(
                            fontSize: 12,
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
        },
      ),
    );
  }
}

class _ServiceItem {
  final String title;
  final String desc;
  final IconData icon;
  final Color color;
  final Widget Function() routeBuilder;

  _ServiceItem({
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
    required this.routeBuilder,
  });
}
