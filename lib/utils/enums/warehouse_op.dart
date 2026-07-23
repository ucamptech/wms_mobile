import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class WarehouseOp {
  const WarehouseOp({
    required this.code,
    required this.title,
    required this.color,
    required this.step1Label,
    required this.step2Label,
    required this.placeholder,
    required this.defaultQty,
    this.needsBin = false,
  });

  final String code;
  final String title;
  final Color color;
  final String step1Label;
  final String step2Label;
  final String placeholder;
  final String defaultQty;
  final bool needsBin;

  static const receive = WarehouseOp(
    code: 'receive',
    title: 'Receive Items',
    color: AppColorsConst.receive,
    step1Label: 'Scan PO Barcode',
    step2Label: 'Enter Quantity',
    placeholder: 'PO-2024-XXXX',
    defaultQty: '24',
  );

  static const putaway = WarehouseOp(
    code: 'putaway',
    title: 'Putaway',
    color: AppColorsConst.putaway,
    step1Label: 'Scan Item / SKU',
    step2Label: 'Scan Bin Location',
    placeholder: 'SKU-XXXXX',
    defaultQty: '10',
    needsBin: true,
  );

  static const pick = WarehouseOp(
    code: 'pick',
    title: 'Pick Items',
    color: AppColorsConst.pick,
    step1Label: 'Scan Order / Picklist',
    step2Label: 'Scan & Count Items',
    placeholder: 'SO-2024-XXXX',
    defaultQty: '10',
  );

  String confirmMessage({
    required String code,
    required String qty,
    String bin = '',
  }) {
    switch (this.code) {
      case 'putaway':
        return '$code ($qty units) → Bin ${bin.isEmpty ? '—' : bin} confirmed';
      case 'pick':
        return '$qty units picked for $code · Recorded';
      case 'receive':
      default:
        return '$qty units received for $code → Queued for putaway';
    }
  }
}
