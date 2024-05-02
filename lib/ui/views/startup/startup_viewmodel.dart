import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:ma_meteo/app/app.locator.dart';
import 'package:ma_meteo/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 1));
    const storage = FlutterSecureStorage();
    String? userAccessToken = await storage.read(key: "access_token");
    // simple management considering fake login
    if (userAccessToken != null) {
      _navigationService.replaceWithHomeView();
    } else {
      _navigationService.replaceWithLoginView();
    }
  }
}
