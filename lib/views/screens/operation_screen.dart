import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_mobile/models/operation_config.dart';
import 'package:wms_mobile/providers/auth_provider.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums.dart';
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

  final _scanController = TextEditingController();
  final _binController = TextEditingController();
  late final TextEditingController _qtyController;
  late final OperationConfig _config;

  @override
  void initState() {
    super.initState();
    _config = OperationConfig.fromOp(widget.operation);
    _qtyController = TextEditingController(text: _config.defaultQty);
  }

  @override
  void dispose() {
    _scanController.dispose();
    _binController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_step < 3) {
      setState(() => _step++);
    } else {
      Navigator.pop(context);
    }
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
          config: _config,
          scanController: _scanController,
        );
      case 2:
        return ScanStepTwo(
          config: _config,
          binController: _binController,
          qtyController: _qtyController,
        );
      default:
        return ScanStepThree(
          confirmMsg: _config.confirmMsg,
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
            title: _config.label,
            step: _step,
            accentColor: _config.color,
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
                        color: _config.color,
                        onPressed: _goNext,
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
