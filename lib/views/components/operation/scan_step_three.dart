import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class ScanStepThree extends StatelessWidget {
  const ScanStepThree({
    super.key,
    required this.confirmMsg,
    required this.username,
  });

  final String confirmMsg;
  final String username;

  String get _timeLabel {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0x2610B981),
              border: Border.all(color: const Color(0x9910B981), width: 2),
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 40,
              color: AppColorsConst.success,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Confirmed!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              confirmMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColorsConst.white50,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColorsConst.white04,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColorsConst.white08),
            ),
            child: Text(
              'Logged · $_timeLabel · $username',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: AppColorsConst.white35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
