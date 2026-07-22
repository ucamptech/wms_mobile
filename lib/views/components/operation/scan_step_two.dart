import 'package:flutter/material.dart';
import 'package:wms_mobile/models/operation_config.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/views/components/operation/mono_label.dart';
import 'package:wms_mobile/views/components/operation/scanner_text_field.dart';

class ScanStepTwo extends StatelessWidget {
  const ScanStepTwo({
    super.key,
    required this.config,
    required this.binController,
    required this.qtyController,
  });

  final OperationConfig config;
  final TextEditingController binController;
  final TextEditingController qtyController;

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
                config.foundCode,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                config.foundDetail,
                style: const TextStyle(color: AppColorsConst.white50, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        MonoLabel(config.step2Label),
        const SizedBox(height: 12),
        if (config.isPutaway) _BinScanBox(controller: binController) else _QtyBox(controller: qtyController),
      ],
    );
  }
}

class _BinScanBox extends StatelessWidget {
  const _BinScanBox({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      decoration: BoxDecoration(
        color: AppColorsConst.white04,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColorsConst.white15, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on_outlined, size: 28, color: AppColorsConst.white25),
          const SizedBox(height: 8),
          const Text(
            'Scan bin barcode',
            style: TextStyle(color: AppColorsConst.white30, fontSize: 14),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 160,
            child: ScannerTextField(
              controller: controller,
              hint: 'or enter bin code…',
              textAlign: TextAlign.center,
              fontSize: 14,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
        const SizedBox(height: 8),
        const MonoLabel('Units', color: AppColorsConst.white25),
      ],
    );
  }
}
