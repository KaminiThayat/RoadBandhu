import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MechanicVoiceCallScreen extends StatefulWidget {
  final String mechanicName;

  const MechanicVoiceCallScreen({
    super.key,
    this.mechanicName = 'Rajesh Kumar',
  });

  @override
  State<MechanicVoiceCallScreen> createState() => _MechanicVoiceCallScreenState();
}

class _MechanicVoiceCallScreenState extends State<MechanicVoiceCallScreen> {
  int _seconds = 12;
  Timer? _callTimer;
  bool _isMuted = false;
  bool _isSpeaker = true;

  @override
  void initState() {
    super.initState();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  String _formatTimer(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'VoIP Rescue Call Connected',
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.mechanicName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Verified RoadBandhu Partner • Chamoli Unit',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _formatTimer(_seconds),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
              const Spacer(),

              // Rescuer Avatar with animated rings
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mountainDark,
                    border: Border.all(color: AppColors.primary, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(60),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Audio waveform simulation bars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(12, (index) {
                  final heights = [14.0, 24.0, 18.0, 32.0, 20.0, 36.0, 26.0, 30.0, 16.0, 22.0, 12.0, 18.0];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 4,
                    height: heights[index],
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const Spacer(),

              // In-call Control buttons (Speaker, Mute, Keypad)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CallActionCircle(
                    icon: _isSpeaker ? Icons.volume_up : Icons.volume_off,
                    label: 'Speaker',
                    isActive: _isSpeaker,
                    onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                  ),
                  _CallActionCircle(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: 'Mute',
                    isActive: _isMuted,
                    onTap: () => setState(() => _isMuted = !_isMuted),
                  ),
                  _CallActionCircle(
                    icon: Icons.dialpad,
                    label: 'Keypad',
                    isActive: false,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Red End Call Button
              Center(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDC2626),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFDC2626),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.call_end, color: Colors.white, size: 34),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallActionCircle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CallActionCircle({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.white : Colors.white12,
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF0F172A) : Colors.white,
              size: 26,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
