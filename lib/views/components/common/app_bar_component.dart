import 'package:flutter/material.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
    required this.title,
    this.subtitle,
    this.onLogout,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColorsConst.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: const Icon(Icons.warehouse_rounded, color: AppColorsConst.primary),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColorsConst.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (subtitle != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                subtitle!,
                style: const TextStyle(fontSize: 12, color: AppColorsConst.textSecondary),
              ),
            ),
          ),
        if (onLogout != null)
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout_rounded, color: AppColorsConst.textSecondary),
          ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: AppColorsConst.border),
      ),
    );
  }
}
