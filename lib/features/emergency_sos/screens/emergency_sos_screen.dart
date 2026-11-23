import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/localization/app_localizations.dart';
import 'accident_medical_screen.dart';

class EmergencySOSScreen extends StatefulWidget {
  const EmergencySOSScreen({super.key});

  @override
  State<EmergencySOSScreen> createState() => _EmergencySOSScreenState();
}

class _EmergencySOSScreenState extends State<EmergencySOSScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  Timer? _holdTimer;
  double _holdProgress = 0.0;
  bool _isHolding = false;
  String _selectedEmergencyType = 'accident';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  void _startHolding() {
    setState(() {
      _isHolding = true;
      _holdProgress = 0.0;
    });

    const stepMs = 50;
    const totalMs = 3000;
    _holdTimer = Timer.periodic(const Duration(milliseconds: stepMs), (timer) {
      setState(() {
        _holdProgress += stepMs / totalMs;
        if (_holdProgress >= 1.0) {
          _holdProgress = 1.0;
          _holdTimer?.cancel();
          _triggerEmergencySOS();
        }
      });
    });
  }

  void _stopHolding() {
    _holdTimer?.cancel();
    setState(() {
      _isHolding = false;
      _holdProgress = 0.0;
    });
  }

  void _triggerEmergencySOS() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => AccidentMedicalScreen(
          emergencyCategory: _selectedEmergencyType,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          context.tr('emergency_sos_title'),
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.alertHigh.withAlpha(40),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.alertHigh.withAlpha(120)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield_outlined, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Emergency Rescue Protocol Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Circular Interactive 3-Sec Press & Hold SOS Button
              Center(
                child: GestureDetector(
                  onTapDown: (_) => _startHolding(),
                  onTapUp: (_) => _stopHolding(),
                  onTapCancel: () => _stopHolding(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Pulsing Glow Wave
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Container(
                            width: 220 + (_pulseController.value * 24),
                            height: 220 + (_pulseController.value * 24),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary.withAlpha(
                                (30 - (_pulseController.value * 20)).toInt(),
                              ),
                            ),
                          );
                        },
                      ),

                      // Circular Progress Indicator for 3s hold
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: _holdProgress,
                          strokeWidth: 8,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),

                      // Center Red SOS Button
                      Container(
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: _isHolding
                                ? [const Color(0xFFEF4444), const Color(0xFF7F1D1D)]
                                : [const Color(0xFFDC2626), const Color(0xFF991B1B)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(120),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.emergency_share,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'SOS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _isHolding
                                  ? '${((1 - _holdProgress) * 3).toStringAsFixed(1)}s'
                                  : 'HOLD 3s',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('press_hold_3s'),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),

              // Emergency Type Selector Chips (Accident, Medical, Vehicle Stuck, Other)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _EmergencyTypeCard(
                    title: context.tr('sos_accident'),
                    icon: Icons.car_crash,
                    isSelected: _selectedEmergencyType == 'accident',
                    onTap: () => setState(() => _selectedEmergencyType = 'accident'),
                  ),
                  _EmergencyTypeCard(
                    title: context.tr('sos_medical'),
                    icon: Icons.medical_services,
                    isSelected: _selectedEmergencyType == 'medical',
                    onTap: () => setState(() => _selectedEmergencyType = 'medical'),
                  ),
                  _EmergencyTypeCard(
                    title: context.tr('sos_stuck'),
                    icon: Icons.terrain,
                    isSelected: _selectedEmergencyType == 'stuck',
                    onTap: () => setState(() => _selectedEmergencyType = 'stuck'),
                  ),
                  _EmergencyTypeCard(
                    title: context.tr('sos_other'),
                    icon: Icons.more_horiz,
                    isSelected: _selectedEmergencyType == 'other',
                    onTap: () => setState(() => _selectedEmergencyType = 'other'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Instant Click Option
              CustomButton(
                text: '${context.tr('send_sos_btn')} →',
                backgroundColor: AppColors.primary,
                onPressed: _triggerEmergencySOS,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmergencyTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmergencyTypeCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
