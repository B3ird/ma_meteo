import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:ma_meteo/app/app.bottomsheets.dart';
import 'package:ma_meteo/app/app.dialogs.dart';
import 'package:ma_meteo/app/app.locator.dart';
import 'package:ma_meteo/app/app.router.dart';
import 'package:ma_meteo/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  initializeDateFormatting('fr_FR', null);
  Intl.defaultLocale = "fr_FR";
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Routes.startupView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: kcPrimaryColor,
            selectionColor: kcPrimaryColor,
            selectionHandleColor: kcPrimaryColorDark,
          ),
        ));
  }
}
