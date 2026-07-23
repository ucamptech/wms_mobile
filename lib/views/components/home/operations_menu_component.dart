import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums/warehouse_op.dart';
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
                    OpCardComponent(
                      label: 'Receive',
                      subtitle: 'Scan inbound items from PO',
                      icon: Icons.south_west_rounded,
                      color: AppColorsConst.receive,
                      onTap: () => _open(context, WarehouseOp.receive),
                    ),
                    const SizedBox(height: 12),
                    OpCardComponent(
                      label: 'Putaway',
                      subtitle: 'Assign items to bin location',
                      icon: Icons.location_on_outlined,
                      color: AppColorsConst.putaway,
                      onTap: () => _open(context, WarehouseOp.putaway),
                    ),
                    const SizedBox(height: 12),
                    OpCardComponent(
                      label: 'Pick',
                      subtitle: 'Fulfill outbound order items',
                      icon: Icons.checklist_rtl_rounded,
                      color: AppColorsConst.pick,
                      onTap: () => _open(context, WarehouseOp.pick),
                    ),
                    const SizedBox(height: 24),
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
