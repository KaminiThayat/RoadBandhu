import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/localization/app_localizations.dart';

class DocumentLockerScreen extends StatelessWidget {
  const DocumentLockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<_DocItem> documents = [
      _DocItem(
        title: 'Driving License',
        hindiTitle: 'ड्राइविंग लाइसेंस',
        idNumber: 'DL-0720190012345',
        validity: 'Valid till 14 Aug 2038',
        icon: Icons.badge_outlined,
        isVerified: true,
      ),
      _DocItem(
        title: 'RC (Registration Certificate)',
        hindiTitle: 'पंजीकरण प्रमाणपत्र (RC)',
        idNumber: 'UK07BX1234',
        validity: 'Valid till 22 Oct 2036',
        icon: Icons.directions_car_outlined,
        isVerified: true,
      ),
      _DocItem(
        title: 'Vehicle Insurance Policy',
        hindiTitle: 'वाहन बीमा',
        idNumber: 'BA-9876543210-01',
        validity: 'Valid till 15 Dec 2026',
        icon: Icons.shield_outlined,
        isVerified: true,
      ),
      _DocItem(
        title: 'PUC Certificate',
        hindiTitle: 'प्रदूषण प्रमाणपत्र (PUC)',
        idNumber: 'PUC-UK07-2025-8812',
        validity: 'Valid till 30 Mar 2026',
        icon: Icons.eco_outlined,
        isVerified: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('my_documents'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Security Vault Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF93C5FD)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_person_outlined, color: Color(0xFF2563EB), size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AES-256 Encrypted Digital Locker',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                        Text(
                          'Your documents are verified and safely encrypted on device & secure cloud.',
                          style: TextStyle(fontSize: 11, color: Color(0xFF3B82F6)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Document Cards
            ...documents.map((doc) => _buildDocCard(doc, isDark)),
            const SizedBox(height: 16),

            // Upload Button
            CustomButton(
              text: '+ Upload / Update Document',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select document (PDF/Image) to upload to encrypted locker.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocCard(_DocItem doc, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            child: Icon(doc.icon, color: AppColors.primary, size: 24),
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
                        doc.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        ),
                      ),
                    ),
                    const StatusBadge(text: 'Verified', status: BadgeStatus.verified),
                  ],
                ),
                Text(
                  doc.hindiTitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${doc.idNumber} • ${doc.validity}',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mountainSlate),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocItem {
  final String title;
  final String hindiTitle;
  final String idNumber;
  final String validity;
  final IconData icon;
  final bool isVerified;

  _DocItem({
    required this.title,
    required this.hindiTitle,
    required this.idNumber,
    required this.validity,
    required this.icon,
    required this.isVerified,
  });
}
