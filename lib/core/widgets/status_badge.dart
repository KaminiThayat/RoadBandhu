import 'package:flutter/material.dart';

enum BadgeStatus {
  verified,
  completed,
  inProgress,
  pending,
  high,
  medium,
  low,
}

class StatusBadge extends StatelessWidget {
  final String text;
  final BadgeStatus status;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.text,
    required this.status,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData defaultIcon;

    switch (status) {
      case BadgeStatus.verified:
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF15803D);
        defaultIcon = Icons.verified;
        break;
      case BadgeStatus.completed:
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF15803D);
        defaultIcon = Icons.check_circle_outline;
        break;
      case BadgeStatus.inProgress:
        bg = const Color(0xFFEFF6FF);
        fg = const Color(0xFF1D4ED8);
        defaultIcon = Icons.sync;
        break;
      case BadgeStatus.pending:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        defaultIcon = Icons.access_time;
        break;
      case BadgeStatus.high:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        defaultIcon = Icons.error_outline;
        break;
      case BadgeStatus.medium:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        defaultIcon = Icons.warning_amber_outlined;
        break;
      case BadgeStatus.low:
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF475569);
        defaultIcon = Icons.info_outline;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? defaultIcon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
