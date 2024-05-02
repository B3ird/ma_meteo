import '../ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:ma_meteo/ui/views/home/home_view.dart';
import 'package:ma_meteo/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ma_meteo/ui/views/login/login_view.dart';
import 'package:ma_meteo/services/user_service.dart';
import 'package:ma_meteo/services/forecast_service.dart';
import 'package:ma_meteo/services/location_service.dart';

import '../ui/dialogs/logout/logout_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: ForecastService),
    LazySingleton(classType: LocationService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: LogoutDialog),
    // @stacked-dialog
  ],
)
class App {}
