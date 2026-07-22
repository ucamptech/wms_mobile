import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class ScannerTextField extends StatelessWidget {
  const ScannerTextField({
    super.key,
    required this.controller,
    this.hint,
    this.textAlign = TextAlign.start,
    this.fontSize = 16,
    this.keyboardType,
    this.digitsOnly = false,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  });

  final TextEditingController controller;
  final String? hint;
  final TextAlign textAlign;
  final double fontSize;
  final TextInputType? keyboardType;
  final bool digitsOnly;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: textAlign,
      keyboardType: keyboardType,
      inputFormatters: digitsOnly
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontSize >= 30 ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'monospace',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColorsConst.white20,
          fontFamily: 'monospace',
          fontSize: fontSize >= 30 ? 16 : fontSize,
        ),
        filled: true,
        fillColor: AppColorsConst.white05,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorsConst.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColorsConst.amberFocus),
        ),
      ),
    );
  }
}
