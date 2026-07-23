import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class OperationPrimaryButton extends StatelessWidget {
  const OperationPrimaryButton({
    super.key,
    required this.step,
    required this.color,
    required this.onPressed,
  });

  final int step;
  final Color color;
  final VoidCallback? onPressed;

  String get _label {
    if (step == 1) return 'Confirm';
    if (step == 2) return 'Submit';
    return 'Done — New Scan';
  }

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OperationBackButton extends StatelessWidget {
  const OperationBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        '← Back',
        style: TextStyle(color: AppColorsConst.white30, fontSize: 14),
      ),
    );
  }
}
