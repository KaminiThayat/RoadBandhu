import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/localization/app_localizations.dart';
import 'confirm_location_screen.dart';

class AccidentMedicalScreen extends StatefulWidget {
  final String emergencyCategory;

  const AccidentMedicalScreen({super.key, this.emergencyCategory = 'accident'});

  @override
  State<AccidentMedicalScreen> createState() => _AccidentMedicalScreenState();
}

class _AccidentMedicalScreenState extends State<AccidentMedicalScreen> {
  String _selectedIncident = 'collision';
  final _additionalNotesController = TextEditingController(
    text: 'Vehicle slipped on mountain road, 1 person injured.',
  );
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accident & Medical Support',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Incident Category Badges
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.alertHigh),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.car_crash, color: AppColors.alertHigh, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Accident',
                          style: TextStyle(
                            color: AppColors.alertHigh,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2563EB)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.medical_services, color: Color(0xFF2563EB), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Medical',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              context.tr('incident_details'),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 12),

            _buildIncidentOption('collision', context.tr('opt_collision')),
            _buildIncidentOption('rollover', context.tr('opt_rollover')),
            _buildIncidentOption('injured', context.tr('opt_injured')),
            _buildIncidentOption('critical', context.tr('opt_critical')),
            _buildIncidentOption('other', 'Other Incident'),
            const SizedBox(height: 20),

            Text(
              context.tr('additional_info'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _additionalNotesController,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Describe terrain, vehicle condition or injuries...',
                    ),
                  ),
                  const Divider(height: 16),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => _isRecording = !_isRecording);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _isRecording ? AppColors.alertHigh : AppColors.primary.withAlpha(20),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _isRecording ? Icons.stop : Icons.mic,
                                size: 16,
                                color: _isRecording ? Colors.white : AppColors.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _isRecording ? 'Recording (0:04)...' : 'Add Voice Note',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _isRecording ? Colors.white : AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.attach_file, color: AppColors.mountainSlate, size: 20),
                      const SizedBox(width: 8),
                      const Icon(Icons.camera_alt_outlined, color: AppColors.mountainSlate, size: 20),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: '${context.tr('next')} →',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmLocationScreen(
                      serviceType: 'Accident & Medical Rescue',
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

  Widget _buildIncidentOption(String key, String label) {
    final isSelected = _selectedIncident == key;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => setState(() => _selectedIncident = key),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.darkSurface : const Color(0xFFFEF2F2))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: key,
              groupValue: _selectedIncident,
              activeColor: AppColors.primary,
              onChanged: (val) {
                if (val != null) setState(() => _selectedIncident = val);
              },
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
