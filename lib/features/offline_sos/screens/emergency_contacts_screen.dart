import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  bool _autoNotifySOS = true;

  final List<_EmergencyContact> _contacts = [
    _EmergencyContact(relation: 'Papa (पिताजी)', name: 'Rajendra Sharma', phone: '+91 98765 43210'),
    _EmergencyContact(relation: 'Maa (माताजी)', name: 'Sunita Sharma', phone: '+91 98765 43211'),
    _EmergencyContact(relation: 'Brother (भाई)', name: 'Rohit Sharma', phone: '+91 98765 43212'),
    _EmergencyContact(relation: 'Friend (मित्र)', name: 'Vikas Joshi', phone: '+91 98765 43213'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('emergency_contacts'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Informational Notice Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield_outlined, color: AppColors.alertHigh, size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your emergency contacts will be notified automatically via SMS with live GPS coordinates during any SOS or crash event.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.alertHigh,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Contacts List
            ..._contacts.map((c) => _buildContactCard(c, isDark)),
            const SizedBox(height: 12),

            // Add Contact Button
            CustomButton(
              text: '+ Add Emergency Contact',
              isOutlined: true,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Select contact from phonebook.')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Auto Notify Toggle Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              ),
              child: SwitchListTile(
                value: _autoNotifySOS,
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Auto Notify on SOS',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Send immediate SMS & location link without manual action',
                  style: TextStyle(fontSize: 11, color: AppColors.mountainSlate),
                ),
                onChanged: (val) => setState(() => _autoNotifySOS = val),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(_EmergencyContact contact, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withAlpha(20),
            ),
            child: const Icon(Icons.person, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.relation,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  '${contact.name} • ${contact.phone}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primary, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _EmergencyContact {
  final String relation;
  final String name;
  final String phone;

  _EmergencyContact({
    required this.relation,
    required this.name,
    required this.phone,
  });
}
