import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/rescue_map_view.dart';
import '../../../core/localization/app_localizations.dart';

class NearbyHospitalScreen extends StatefulWidget {
  const NearbyHospitalScreen({super.key});

  @override
  State<NearbyHospitalScreen> createState() => _NearbyHospitalScreenState();
}

class _NearbyHospitalScreenState extends State<NearbyHospitalScreen> {
  int _selectedTab = 0; // 0: Hospital, 1: Ambulance

  final List<_HospitalItem> _hospitals = [
    _HospitalItem(
      name: 'District Hospital Chamoli',
      subtitle: 'जिला अस्पताल चमोली • 24x7 Emergency & Trauma',
      distance: '5.2 km',
      eta: '12 min',
      phone: '+91 1372 252108',
      isOpen: true,
    ),
    _HospitalItem(
      name: 'Hilly Care Multi-Specialty Hospital',
      subtitle: 'हिल्ली केयर अस्पताल • ICU & Oxygen Support',
      distance: '8.7 km',
      eta: '18 min',
      phone: '+91 1372 253456',
      isOpen: true,
    ),
    _HospitalItem(
      name: 'Primary Health Centre (PHC) Pipalkoti',
      subtitle: 'प्राथमिक स्वास्थ्य केंद्र • First Aid & Stabilization',
      distance: '12.4 km',
      eta: '25 min',
      phone: '+91 1372 254789',
      isOpen: true,
    ),
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dialing $phoneNumber...')),
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
          context.tr('nearby_hospital'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          // Map preview showing route to hospital
          SizedBox(
            height: 180,
            child: RescueMapView(
              height: 180,
              locationTitle: 'District Hospital Chamoli',
              locationSubtitle: 'Nearest Emergency Centre (5.2 km)',
              showMechanic: false,
              showRoute: true,
            ),
          ),

          // Tab Switch (Hospital / Ambulance)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _selectedTab = 0),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_hospital,
                                size: 16,
                                color: _selectedTab == 0 ? Colors.white : AppColors.mountainSlate),
                            const SizedBox(width: 6),
                            Text(
                              'Hospital / अस्पताल',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: _selectedTab == 0 ? Colors.white : (isDark ? Colors.white70 : AppColors.lightTextPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _selectedTab = 1),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emergency,
                                size: 16,
                                color: _selectedTab == 1 ? Colors.white : AppColors.mountainSlate),
                            const SizedBox(width: 6),
                            Text(
                              'Ambulance / एम्बुलेंस',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: _selectedTab == 1 ? Colors.white : (isDark ? Colors.white70 : AppColors.lightTextPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hospital List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: _hospitals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final h = _hospitals[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEE2E2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.local_hospital, color: AppColors.alertHigh, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    h.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Open',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.success),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              h.subtitle,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${h.distance} • ${h.eta}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: context.tr('call_hospital'),
                      isOutlined: true,
                      icon: Icons.phone,
                      onPressed: () => _makePhoneCall('+911372252108'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: '🚨 ${context.tr('call_ambulance_108')}',
                      backgroundColor: const Color(0xFFDC2626),
                      onPressed: () => _makePhoneCall('108'),
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

class _HospitalItem {
  final String name;
  final String subtitle;
  final String distance;
  final String eta;
  final String phone;
  final bool isOpen;

  _HospitalItem({
    required this.name,
    required this.subtitle,
    required this.distance,
    required this.eta,
    required this.phone,
    required this.isOpen,
  });
}
