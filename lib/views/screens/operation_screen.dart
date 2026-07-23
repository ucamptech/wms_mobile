import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_mobile/providers/auth_provider.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/constants/scan_samples_const.dart';
import 'package:wms_mobile/utils/enums/warehouse_op.dart';
import 'package:wms_mobile/views/components/common/app_toast.dart';
import 'package:wms_mobile/views/components/operation/operation_buttons.dart';
import 'package:wms_mobile/views/components/operation/operation_header.dart';
import 'package:wms_mobile/views/components/operation/scan_step_one.dart';
import 'package:wms_mobile/views/components/operation/scan_step_three.dart';
import 'package:wms_mobile/views/components/operation/scan_step_two.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key, required this.operation});

  final WarehouseOp operation;

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  int _step = 1;
  ScanSample? _found;

  final _scanController = TextEditingController();
  final _binController = TextEditingController();
  late final TextEditingController _qtyController;

  WarehouseOp get _op => widget.operation;

  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: _op.defaultQty);
  }

  @override
  void dispose() {
    _scanController.dispose();
    _binController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  String _confirmMessage() {
    final code = _found?.code ?? _scanController.text.trim();
    final qty = _qtyController.text.trim().isEmpty
        ? (_found?.defaultQty ?? _op.defaultQty)
        : _qtyController.text.trim();

    return _op.confirmMessage(
      code: code,
      qty: qty,
      bin: _binController.text.trim(),
    );
  }

  void _goNext({String? scannedCode}) {
    if (_step == 1) {
      final barcode = (scannedCode ?? _scanController.text).trim();
      if (barcode.isEmpty) {
        AppToast.error(context, 'Scan or enter a barcode first');
        return;
      }

      _scanController.text = barcode;
      final doc = ScanSamplesConst.lookup(_op.code, barcode);
      if (doc == null) {
        AppToast.error(context, 'Unknown barcode: $barcode');
        return;
      }

      setState(() {
        _found = doc;
        _qtyController.text = doc.defaultQty;
        _step = 2;
      });
      return;
    }

    if (_step == 2) {
      if (_op.needsBin) {
        final bin = (scannedCode ?? _binController.text).trim();
        if (bin.isEmpty) {
          AppToast.error(context, 'Scan or enter a bin location');
          return;
        }

        _binController.text = bin;
        final binDoc = ScanSamplesConst.lookup(_op.code, bin, bin: true);
        if (binDoc == null) {
          AppToast.error(context, 'Unknown bin: $bin');
          return;
        }

        setState(() => _step = 3);
        return;
      }

      if (_qtyController.text.trim().isEmpty) {
        AppToast.error(context, 'Enter quantity');
        return;
      }

      setState(() => _step = 3);
      return;
    }

    Navigator.pop(context);
  }

  void _goBack() {
    if (_step > 1) {
      setState(() => _step--);
    } else {
      Navigator.pop(context);
    }
  }

  Widget _currentStep(String username) {
    switch (_step) {
      case 1:
        return ScanStepOne(
          step1Label: _op.step1Label,
          placeholder: _op.placeholder,
          scanController: _scanController,
          onScanned: (code) => _goNext(scannedCode: code),
        );
      case 2:
        return ScanStepTwo(
          step2Label: _op.step2Label,
          needsBin: _op.needsBin,
          found: _found,
          binController: _binController,
          qtyController: _qtyController,
          onBinScanned: (code) => _goNext(scannedCode: code),
        );
      default:
        return ScanStepThree(
          confirmMsg: _confirmMessage(),
          username: username,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final username =
        context.watch<AuthProvider>().session?.username ?? 'r.santos';

    return Scaffold(
      backgroundColor: AppColorsConst.bg,
      body: Column(
        children: [
          OperationHeader(
            title: _op.title,
            step: _step,
            accentColor: _op.color,
            onClose: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 384),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: _currentStep(username),
                        ),
                      ),
                      const SizedBox(height: 24),
                      OperationPrimaryButton(
                        step: _step,
                        color: _op.color,
                        onPressed: () => _goNext(),
                      ),
                      if (_step < 3) OperationBackButton(onPressed: _goBack),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
