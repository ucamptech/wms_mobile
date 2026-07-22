import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class EmptyTabComponent extends StatelessWidget {
  const EmptyTabComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: AppColorsConst.textSecondary),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColorsConst.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: AppColorsConst.textSecondary),
          ),
        ],
      ),
    );
  }
}
