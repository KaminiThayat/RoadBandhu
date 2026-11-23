import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import '../../emergency_sos/screens/confirm_location_screen.dart';

class FuelDeliveryScreen extends StatefulWidget {
  const FuelDeliveryScreen({super.key});

  @override
  State<FuelDeliveryScreen> createState() => _FuelDeliveryScreenState();
}

class _FuelDeliveryScreenState extends State<FuelDeliveryScreen> {
  String _selectedFuel = 'petrol';
  int _quantityLiters = 5;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('fuel_delivery'),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_gas_station, color: Color(0xFF7C3AED), size: 32),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Run Out of Fuel?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Emergency canister fuel delivered directly to your vehicle',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Select Fuel Type',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _buildFuelCard('petrol', 'Petrol', 'पेट्रोल', Icons.local_gas_station, const Color(0xFF059669), isDark),
                const SizedBox(width: 10),
                _buildFuelCard('diesel', 'Diesel', 'डीजल', Icons.local_gas_station, const Color(0xFF2563EB), isDark),
                const SizedBox(width: 10),
                _buildFuelCard('cng', 'CNG', 'सीएनजी', Icons.propane_tank, const Color(0xFFD97706), isDark),
              ],
            ),
            const SizedBox(height: 24),

            // Quantity selector
            Text(
              'Quantity (Liters)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildQtyButton(5, isDark),
                const SizedBox(width: 12),
                _buildQtyButton(10, isDark),
                const SizedBox(width: 12),
                _buildQtyButton(15, isDark),
              ],
            ),
            const SizedBox(height: 24),

            // Location card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery Location', style: TextStyle(fontSize: 11, color: AppColors.mountainSlate)),
                        Text(
                          'Rudraprayag / Chamoli Highway, Uttarakhand',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '${context.tr('request_fuel')} →',
              backgroundColor: const Color(0xFF7C3AED),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmLocationScreen(
                      serviceType: 'Emergency Fuel Canister Delivery',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuelCard(String key, String title, String subtitle, IconData icon, Color color, bool isDark) {
    final isSelected = _selectedFuel == key;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedFuel = key),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withAlpha(25)
                : (isDark ? AppColors.darkCard : Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? color : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQtyButton(int qty, bool isDark) {
    final isSelected = _quantityLiters == qty;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _quantityLiters = qty),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.darkCard : Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Center(
            child: Text(
              '$qty Liters',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.lightTextPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
