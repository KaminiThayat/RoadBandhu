import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';
import 'rescue_confirmation_screen.dart';

class NearbyHelpScreen extends StatefulWidget {
  final String serviceType;
  final String location;

  const NearbyHelpScreen({
    super.key,
    required this.serviceType,
    required this.location,
  });

  @override
  State<NearbyHelpScreen> createState() => _NearbyHelpScreenState();
}

class _NearbyHelpScreenState extends State<NearbyHelpScreen> {
  int _selectedCategoryIndex = 0;

  final List<_PartnerCandidate> _partners = [
    _PartnerCandidate(
      name: 'Rajesh Auto Care & Mountain Recovery',
      type: 'Mechanic',
      rating: 4.8,
      reviews: 2316,
      distanceKm: 2.1,
      etaMinutes: 12,
      isVerified: true,
      experienceYears: '8+ Years',
      serviceArea: 'Chamoli & NH-7 Corridors',
      phone: '+91 98765 43210',
    ),
    _PartnerCandidate(
      name: 'Uttarakhand Mountain Rescue Squad',
      type: 'Rescue Team',
      rating: 4.9,
      reviews: 1420,
      distanceKm: 4.6,
      etaMinutes: 18,
      isVerified: true,
      experienceYears: '12+ Years',
      serviceArea: 'High Altitude & Landslide Zones',
      phone: '+91 98765 43211',
    ),
    _PartnerCandidate(
      name: 'Chamoli District Emergency Ambulance',
      type: 'Ambulance',
      rating: 4.8,
      reviews: 950,
      distanceKm: 6.2,
      etaMinutes: 20,
      isVerified: true,
      experienceYears: '10+ Years',
      serviceArea: 'Chamoli Govt Hospital Fleet',
      phone: '108',
    ),
    _PartnerCandidate(
      name: 'Himalayan Heavy Towing & Winch',
      type: 'Mechanic',
      rating: 4.7,
      reviews: 812,
      distanceKm: 7.5,
      etaMinutes: 25,
      isVerified: true,
      experienceYears: '9+ Years',
      serviceArea: 'Gorge Winch Recovery Expert',
      phone: '+91 98765 43212',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('nearby_help'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs (All / Mechanic / Rescue Team / Ambulance)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilterChip(0, context.tr('tab_all')),
                const SizedBox(width: 8),
                _buildFilterChip(1, context.tr('tab_mechanic')),
                const SizedBox(width: 8),
                _buildFilterChip(2, context.tr('tab_rescue')),
                const SizedBox(width: 8),
                _buildFilterChip(3, context.tr('tab_ambulance')),
              ],
            ),
          ),

          // Subtitle info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Text(
                  '3 verified units responding nearby',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.flash_on, color: AppColors.alertMedium, size: 16),
                const Text(
                  'Fastest ETA: 12 min',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.alertMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Candidate List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: _partners.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final p = _partners[index];
                return _PartnerCard(
                  partner: p,
                  onSelect: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RescueConfirmationScreen(
                          partnerName: p.name,
                          etaMinutes: p.etaMinutes,
                          distanceKm: p.distanceKm,
                          serviceType: widget.serviceType,
                          location: widget.location,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedCategoryIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedCategoryIndex = index),
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

class _PartnerCandidate {
  final String name;
  final String type;
  final double rating;
  final int reviews;
  final double distanceKm;
  final int etaMinutes;
  final bool isVerified;
  final String experienceYears;
  final String serviceArea;
  final String phone;

  _PartnerCandidate({
    required this.name,
    required this.type,
    required this.rating,
    required this.reviews,
    required this.distanceKm,
    required this.etaMinutes,
    required this.isVerified,
    required this.experienceYears,
    required this.serviceArea,
    required this.phone,
  });
}

class _PartnerCard extends StatelessWidget {
  final _PartnerCandidate partner;
  final VoidCallback onSelect;

  const _PartnerCard({required this.partner, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mountainDark,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: const Icon(Icons.engineering, color: Colors.white, size: 28),
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
                            partner.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (partner.isVerified)
                          const StatusBadge(text: 'Verified', status: BadgeStatus.verified),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '${partner.rating} (${partner.reviews})',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('•', style: TextStyle(color: isDark ? Colors.white38 : Colors.black26)),
                        const SizedBox(width: 8),
                        Text(
                          '${partner.distanceKm} km away',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer, color: AppColors.success, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'ETA: ${partner.etaMinutes} min',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Dispatch Now', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
