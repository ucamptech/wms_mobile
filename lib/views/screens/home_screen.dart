import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_mobile/providers/auth_provider.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums.dart';
import 'package:wms_mobile/views/components/common/app_bar_component.dart';
import 'package:wms_mobile/views/components/common/bottom_nav_component.dart';
import 'package:wms_mobile/views/components/home/empty_tab_component.dart';
import 'package:wms_mobile/views/components/home/operations_menu_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppTab _tab = AppTab.scan;

  Future<void> _logout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColorsConst.card,
        title: const Text('Sign out?', style: TextStyle(color: AppColorsConst.text)),
        content: const Text(
          'You will need to sign in again.',
          style: TextStyle(color: AppColorsConst.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColorsConst.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Sign out',
              style: TextStyle(color: AppColorsConst.primary),
            ),
          ),
        ],
      ),
    );

    if (ok == true && mounted) {
      await context.read<AuthProvider>().logout();
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget _body() {
    switch (_tab) {
      case AppTab.scan:
        return const OperationsMenuComponent();
      case AppTab.stock:
        return const EmptyTabComponent(
          icon: Icons.inventory_2_outlined,
          title: 'Stock lookup',
          subtitle: '',
        );
      case AppTab.log:
        return const EmptyTabComponent(
          icon: Icons.timeline_rounded,
          title: 'Activity log',
          subtitle: '',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthProvider>().session;
    if (session == null) {
      return const Scaffold(backgroundColor: AppColorsConst.bg);
    }

    return Scaffold(
      backgroundColor: AppColorsConst.bg,
      appBar: AppBarComponent(
        title: 'WMS Mobile',
        subtitle: '${session.username} · ${session.role}',
        onLogout: _logout,
      ),
      body: Column(
        children: [
          Expanded(child: _body()),
          BottomNavComponent(
            current: _tab,
            onChanged: (tab) => setState(() => _tab = tab),
          ),
        ],
      ),
    );
  }
}
