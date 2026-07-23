import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/views/components/operation/barcode_scanner_box.dart';
import 'package:wms_mobile/views/components/operation/mono_label.dart';
import 'package:wms_mobile/views/components/operation/scanner_text_field.dart';

class ScanStepOne extends StatelessWidget {
  const ScanStepOne({
    super.key,
    required this.step1Label,
    required this.placeholder,
    required this.scanController,
    this.onScanned,
  });

  final String step1Label;
  final String placeholder;
  final TextEditingController scanController;
  final ValueChanged<String>? onScanned;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        MonoLabel(step1Label),
        const SizedBox(height: 12),
        BarcodeScannerBox(
          onDetect: (code) {
            if (onScanned != null) {
              onScanned!(code);
            } else {
              scanController.text = code;
              scanController.selection =
                  TextSelection.collapsed(offset: code.length);
            }
          },
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
          hint: placeholder,
        ),
      ],
    );
  }
}
