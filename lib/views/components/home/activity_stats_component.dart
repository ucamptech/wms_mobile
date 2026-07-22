import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class ActivityStatsComponent extends StatelessWidget {
  const ActivityStatsComponent({
    super.key,
    this.received = '18',
    this.putaway = '12',
    this.picked = '24',
  });

  final String received;
  final String putaway;
  final String picked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsConst.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColorsConst.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TODAY'S ACTIVITY",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: AppColorsConst.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _Stat(value: received, label: 'Received')),
              Expanded(child: _Stat(value: putaway, label: 'Putaway')),
              Expanded(child: _Stat(value: picked, label: 'Picked')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColorsConst.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColorsConst.textSecondary),
        ),
      ],
    );
  }
}
