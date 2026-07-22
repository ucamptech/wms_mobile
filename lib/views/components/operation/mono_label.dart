import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class MonoLabel extends StatelessWidget {
  const MonoLabel(this.text, {super.key, this.color = AppColorsConst.white30});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'monospace',
        letterSpacing: 1.6,
        color: color,
      ),
    );
  }
}
