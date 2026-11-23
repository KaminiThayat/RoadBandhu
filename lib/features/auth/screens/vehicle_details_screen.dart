import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/localization/app_localizations.dart';
import '../../navigation/main_nav_screen.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  String _vehicleType = 'Car';
  final _plateController = TextEditingController(text: 'UK07BX1234');
  String _make = 'Hyundai';
  String _model = 'Creta';
  String _fuelType = 'Petrol';

  final List<String> _types = ['Car', 'Motorcycle / Scooter', 'SUV / 4×4', 'Commercial / Truck'];
  final List<String> _makes = ['Hyundai', 'Tata Motors', 'Mahindra', 'Maruti Suzuki', 'Toyota', 'Kia', 'Royal Enfield'];
  final List<String> _models = ['Creta', 'Nexon', 'Thar', 'Scorpio', 'Brezza', 'Fortuner', 'Himalayan 450'];
  final List<String> _fuels = ['Petrol', 'Diesel', 'CNG', 'Electric (EV)'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('vehicle_details'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Visual Header
            Container(
              padding: const EdgeInsets.all(16),
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
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.directions_car_filled,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_make $_model',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.mountainSlate.withAlpha(80)),
                          ),
                          child: Text(
                            _plateController.text,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Vehicle Type Dropdown
            Text(
              context.tr('vehicle_type'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown(
              value: _vehicleType,
              items: _types,
              onChanged: (v) => setState(() => _vehicleType = v!),
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: context.tr('vehicle_number'),
              controller: _plateController,
              hint: 'UK07BX1234',
              prefixIcon: Icons.confirmation_number_outlined,
            ),
            const SizedBox(height: 16),

            // Make Dropdown
            Text(
              context.tr('make'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown(
              value: _make,
              items: _makes,
              onChanged: (v) => setState(() => _make = v!),
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            // Model Dropdown
            Text(
              context.tr('model'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown(
              value: _model,
              items: _models,
              onChanged: (v) => setState(() => _model = v!),
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            // Fuel Type Dropdown
            Text(
              context.tr('fuel_type'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown(
              value: _fuelType,
              items: _fuels,
              onChanged: (v) => setState(() => _fuelType = v!),
              isDark: isDark,
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '${context.tr('save_and_continue')} →',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isDark,
  }) {
    return Container(
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
          value: value,
          isExpanded: true,
          dropdownColor: isDark ? AppColors.darkCard : Colors.white,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
