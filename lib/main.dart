import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wms_mobile/providers/auth_provider.dart';
import 'package:wms_mobile/utils/constants/app_colors_const.dart';
import 'package:wms_mobile/utils/enums.dart';
import 'package:wms_mobile/views/screens/home_screen.dart';
import 'package:wms_mobile/views/screens/login_screen.dart';
import 'package:wms_mobile/views/screens/operation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColorsConst.bg,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const WmsMobileApp());
}

class WmsMobileApp extends StatelessWidget {
  const WmsMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider()..init(),
      child: MaterialApp(
        title: 'WMS Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColorsConst.primary,
            brightness: Brightness.dark,
            primary: AppColorsConst.primary,
            onPrimary: AppColorsConst.onPrimary,
            surface: AppColorsConst.surface,
            onSurface: AppColorsConst.text,
            error: AppColorsConst.error,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColorsConst.bg,
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        ),
        home: const _StartScreen(),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/operation') {
            final op = settings.arguments as WarehouseOp;
            return MaterialPageRoute(
              builder: (_) => OperationScreen(operation: op),
            );
          }
          return null;
        },
      ),
    );
  }
}

class _StartScreen extends StatelessWidget {
  const _StartScreen();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.ready) {
      return const Scaffold(
        backgroundColor: AppColorsConst.bg,
        body: Center(
          child: CircularProgressIndicator(color: AppColorsConst.primary),
        ),
      );
    }

    if (auth.isLoggedIn) return const HomeScreen();
    return const LoginScreen();
  }
}
