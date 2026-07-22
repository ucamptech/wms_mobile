import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums.dart';

class OperationConfig {
  const OperationConfig({
    required this.op,
    required this.label,
    required this.menuLabel,
    required this.menuSubtitle,
    required this.menuIcon,
    required this.color,
    required this.step1Label,
    required this.step2Label,
    required this.placeholder,
    required this.foundCode,
    required this.foundDetail,
    required this.confirmMsg,
    required this.defaultQty,
  });

  final WarehouseOp op;
  final String label;
  final String menuLabel;
  final String menuSubtitle;
  final IconData menuIcon;
  final Color color;
  final String step1Label;
  final String step2Label;
  final String placeholder;
  final String foundCode;
  final String foundDetail;
  final String confirmMsg;
  final String defaultQty;

  bool get isPutaway => op == WarehouseOp.putaway;

  static const receive = OperationConfig(
    op: WarehouseOp.receive,
    label: 'Receive Items',
    menuLabel: 'Receive',
    menuSubtitle: 'Scan inbound items from PO',
    menuIcon: Icons.south_west_rounded,
    color: AppColorsConst.receive,
    step1Label: 'Scan PO Barcode',
    step2Label: 'Enter Quantity',
    placeholder: 'PO-2024-XXXX',
    foundCode: 'PO-2024-0889',
    foundDetail: 'Global Hardware Co. · 12 line items',
    confirmMsg: '24 units received for PO-2024-0889 → Queued for putaway',
    defaultQty: '24',
  );

  static const putaway = OperationConfig(
    op: WarehouseOp.putaway,
    label: 'Putaway',
    menuLabel: 'Putaway',
    menuSubtitle: 'Assign items to bin location',
    menuIcon: Icons.location_on_outlined,
    color: AppColorsConst.putaway,
    step1Label: 'Scan Item / SKU',
    step2Label: 'Scan Bin Location',
    placeholder: 'SKU-XXXXX',
    foundCode: 'SKU-10042',
    foundDetail: 'Industrial Motor 5HP · 24 units awaiting',
    confirmMsg: 'SKU-10042 (24 units) → Bin A1-03 confirmed',
    defaultQty: '10',
  );

  static const pick = OperationConfig(
    op: WarehouseOp.pick,
    label: 'Pick Items',
    menuLabel: 'Pick',
    menuSubtitle: 'Fulfill outbound order items',
    menuIcon: Icons.checklist_rtl_rounded,
    color: AppColorsConst.pick,
    step1Label: 'Scan Order / Picklist',
    step2Label: 'Scan & Count Items',
    placeholder: 'SO-2024-XXXX',
    foundCode: 'SO-2024-1198',
    foundDetail: 'BrightBuild Ltd. · 3 items to pick',
    confirmMsg: '10 units picked for SO-2024-1198 · Recorded',
    defaultQty: '10',
  );

  static const List<OperationConfig> menuItems = [receive, putaway, pick];

  static OperationConfig fromOp(WarehouseOp op) {
    switch (op) {
      case WarehouseOp.receive:
        return receive;
      case WarehouseOp.putaway:
        return putaway;
      case WarehouseOp.pick:
        return pick;
    }
  }
}
