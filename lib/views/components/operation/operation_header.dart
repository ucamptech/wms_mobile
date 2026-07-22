import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class OperationHeader extends StatelessWidget {
  const OperationHeader({
    super.key,
    required this.title,
    required this.step,
    required this.accentColor,
    required this.onClose,
  });

  final String title;
  final int step;
  final Color accentColor;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return Container(
      decoration: const BoxDecoration(
        color: AppColorsConst.surface,
        border: Border(bottom: BorderSide(color: AppColorsConst.white08)),
      ),
      padding: EdgeInsets.only(top: top, left: 16, right: 16),
      height: 54 + top,
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            icon: const Icon(Icons.close, size: 17, color: AppColorsConst.white50),
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Row(
            children: List.generate(3, (i) {
              final active = (i + 1) <= step;
              return Container(
                width: 24,
                height: 4,
                margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
                decoration: BoxDecoration(
                  color: active ? accentColor : AppColorsConst.white15,
                  borderRadius: BorderRadius.circular(99),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
