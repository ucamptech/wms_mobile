import 'package:flutter/material.dart';
import 'package:wms_mobile/models/operation_config.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/views/components/operation/mono_label.dart';
import 'package:wms_mobile/views/components/operation/scanner_text_field.dart';

class ScanStepOne extends StatelessWidget {
  const ScanStepOne({
    super.key,
    required this.config,
    required this.scanController,
  });

  final OperationConfig config;
  final TextEditingController scanController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        MonoLabel(config.step1Label),
        const SizedBox(height: 12),
        Container(
          height: 176,
          decoration: BoxDecoration(
            color: AppColorsConst.white04,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColorsConst.white15, width: 2),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_scanner_rounded, size: 38, color: AppColorsConst.white20),
              SizedBox(height: 12),
              Text(
                'Point camera at barcode',
                style: TextStyle(color: AppColorsConst.white30, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                'Auto-detects QR / Code128',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: AppColorsConst.white20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(child: Divider(color: AppColorsConst.white10, height: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR ENTER MANUALLY',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: AppColorsConst.white25,
                ),
              ),
            ),
            Expanded(child: Divider(color: AppColorsConst.white10, height: 1)),
          ],
        ),
        const SizedBox(height: 16),
        ScannerTextField(
          controller: scanController,
          hint: config.placeholder,
        ),
      ],
    );
  }
}
