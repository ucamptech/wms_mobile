import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/constants/scan_samples_const.dart';
import 'package:wms_mobile/views/components/operation/barcode_scanner_box.dart';
import 'package:wms_mobile/views/components/operation/mono_label.dart';
import 'package:wms_mobile/views/components/operation/scanner_text_field.dart';

class ScanStepTwo extends StatelessWidget {
  const ScanStepTwo({
    super.key,
    required this.step2Label,
    required this.needsBin,
    required this.found,
    required this.binController,
    required this.qtyController,
    this.onBinScanned,
  });

  final String step2Label;
  final bool needsBin;
  final ScanSample? found;
  final TextEditingController binController;
  final TextEditingController qtyController;
  final ValueChanged<String>? onBinScanned;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColorsConst.white05,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColorsConst.white10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MonoLabel('FOUND', color: AppColorsConst.white35),
              const SizedBox(height: 4),
              Text(
                found?.code ?? '—',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                found?.detail ?? 'No document details',
                style: const TextStyle(color: AppColorsConst.white50, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MonoLabel(step2Label),
        const SizedBox(height: 12),
        if (needsBin)
          _BinScanBox(controller: binController, onScanned: onBinScanned)
        else
          _QtyBox(controller: qtyController),
      ],
    );
  }
}

class _BinScanBox extends StatelessWidget {
  const _BinScanBox({required this.controller, this.onScanned});

  final TextEditingController controller;
  final ValueChanged<String>? onScanned;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BarcodeScannerBox(
          icon: Icons.location_on_outlined,
          hint: 'Point camera at bin barcode',
          subHint: 'Auto-detects QR / Code128',
          onDetect: (code) {
            if (onScanned != null) {
              onScanned!(code);
            } else {
              controller.text = code;
              controller.selection =
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
          controller: controller,
          hint: 'A1-03',
        ),
      ],
    );
  }
}

class _QtyBox extends StatelessWidget {
  const _QtyBox({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScannerTextField(
          controller: controller,
          textAlign: TextAlign.center,
          fontSize: 36,
          keyboardType: TextInputType.number,
          digitsOnly: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
        const SizedBox(height: 8),
        const MonoLabel('Units', color: AppColorsConst.white25),
      ],
    );
  }
}
