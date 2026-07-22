import 'package:flutter/material.dart';
import 'package:wms_mobile/models/operation_config.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums.dart';
import 'package:wms_mobile/views/components/home/activity_stats_component.dart';
import 'package:wms_mobile/views/components/home/op_card_component.dart';

class OperationsMenuComponent extends StatelessWidget {
  const OperationsMenuComponent({super.key});

  void _open(BuildContext context, WarehouseOp op) {
    Navigator.pushNamed(context, '/operation', arguments: op);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'SELECT OPERATION',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: AppColorsConst.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final item in OperationConfig.menuItems) ...[
                      OpCardComponent(
                        label: item.menuLabel,
                        subtitle: item.menuSubtitle,
                        icon: item.menuIcon,
                        color: item.color,
                        onTap: () => _open(context, item.op),
                      ),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 12),
                    const ActivityStatsComponent(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
