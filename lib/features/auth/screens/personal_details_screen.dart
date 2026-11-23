import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/localization/app_localizations.dart';
import 'vehicle_details_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _nameController = TextEditingController(text: 'Amit Sharma');
  final _dobController = TextEditingController(text: '15 Aug 1995');
  String _selectedGender = 'male';
  String _selectedState = 'Uttarakhand';
  String _selectedCity = 'Dehradun';

  final List<String> _states = [
    'Uttarakhand',
    'Himachal Pradesh',
    'Jammu & Kashmir',
    'Ladakh',
    'Sikkim',
    'Arunachal Pradesh',
    'Assam',
    'Meghalaya',
    'Delhi NCR',
    'Punjab',
  ];

  final List<String> _cities = [
    'Dehradun',
    'Chamoli',
    'Joshimath',
    'Rishikesh',
    'Haridwar',
    'Nainital',
    'Shimla',
    'Manali',
    'Srinagar',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('personal_details'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar with camera icon
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mountainDark,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white70,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            CustomTextField(
              label: context.tr('full_name'),
              controller: _nameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: context.tr('dob'),
              controller: _dobController,
              prefixIcon: Icons.calendar_today_outlined,
              suffix: const Icon(Icons.arrow_drop_down, color: AppColors.mountainSlate),
            ),
            const SizedBox(height: 16),

            // Gender selector
            Text(
              context.tr('gender'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildGenderOption('male', context.tr('male')),
                const SizedBox(width: 16),
                _buildGenderOption('female', context.tr('female')),
                const SizedBox(width: 16),
                _buildGenderOption('other', context.tr('other')),
              ],
            ),
            const SizedBox(height: 16),

            // State Dropdown
            Text(
              context.tr('state'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedState,
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.darkCard : Colors.white,
                  items: _states.map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(
                        s,
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedState = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // City Dropdown
            Text(
              context.tr('city'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.darkCard : Colors.white,
                  items: _cities.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(
                        c,
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCity = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '${context.tr('continue')} →',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VehicleDetailsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String value, String label) {
    final isSelected = _selectedGender == value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => setState(() => _selectedGender = value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedGender,
            activeColor: AppColors.primary,
            onChanged: (val) {
              if (val != null) setState(() => _selectedGender = val);
            },
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
