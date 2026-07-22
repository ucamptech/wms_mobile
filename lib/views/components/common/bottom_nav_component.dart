import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums.dart';

class BottomNavComponent extends StatelessWidget {
  const BottomNavComponent({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final AppTab current;
  final ValueChanged<AppTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColorsConst.bg,
        border: Border(top: BorderSide(color: AppColorsConst.border)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: Row(
        children: [
          _item(AppTab.scan, Icons.qr_code_scanner_rounded, 'Scan'),
          _item(AppTab.stock, Icons.inventory_2_outlined, 'Stock'),
          _item(AppTab.log, Icons.timeline_rounded, 'Log'),
        ],
      ),
    );
  }

  Widget _item(AppTab tab, IconData icon, String label) {
    final active = current == tab;
    final color = active ? AppColorsConst.primary : AppColorsConst.textSecondary;

    return Expanded(
      child: InkWell(
        onTap: () => onChanged(tab),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 11, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
