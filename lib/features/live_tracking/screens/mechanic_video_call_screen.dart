import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MechanicVideoCallScreen extends StatefulWidget {
  const MechanicVideoCallScreen({super.key});

  @override
  State<MechanicVideoCallScreen> createState() => _MechanicVideoCallScreenState();
}

class _MechanicVideoCallScreenState extends State<MechanicVideoCallScreen> {
  int _seconds = 56;
  Timer? _timer;
  bool _isMuted = false;
  bool _isCameraOn = true;
  bool _isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimer(int s) {
    final min = (s ~/ 60).toString().padLeft(2, '0');
    final sec = (s % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Main Video Feed Simulation (Mechanic checking your vehicle)
          Container(
            color: const Color(0xFF1E293B),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Simulated vehicle engine bay / mountain view
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0F172A), Color(0xFF334155), Color(0xFF1E293B)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mountainDark,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.car_repair, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Remote Visual Diagnostic Active',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Mechanic Rajesh Kumar is inspecting your engine & tyre',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top Header Overlay with Duration and Return
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDC2626),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatTimer(_seconds),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.hd, color: Color(0xFF10B981), size: 16),
                      SizedBox(width: 4),
                      Text(
                        'HD WebRTC',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mechanic Picture-in-Picture window (top right)
          Positioned(
            top: 90,
            right: 20,
            child: Container(
              width: 110,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 10),
                ],
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.person, color: Colors.white54, size: 40),
                  ),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Rajesh Kumar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Call Controls (Flip camera, Mute, End Call, Video on/off)
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(160),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      _isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () => setState(() => _isFrontCamera = !_isFrontCamera),
                  ),
                  IconButton(
                    icon: Icon(
                      _isMuted ? Icons.mic_off : Icons.mic,
                      color: _isMuted ? const Color(0xFFDC2626) : Colors.white,
                      size: 26,
                    ),
                    onPressed: () => setState(() => _isMuted = !_isMuted),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDC2626),
                      ),
                      child: const Icon(Icons.call_end, color: Colors.white, size: 28),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isCameraOn ? Icons.videocam : Icons.videocam_off,
                      color: _isCameraOn ? Colors.white : const Color(0xFFDC2626),
                      size: 26,
                    ),
                    onPressed: () => setState(() => _isCameraOn = !_isCameraOn),
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
