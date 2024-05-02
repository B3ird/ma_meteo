import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:ma_meteo/app/app.dialogs.dart';
import 'package:ma_meteo/app/app.locator.dart';
import 'package:ma_meteo/app/app.router.dart';
import 'package:ma_meteo/extensions/string.dart';
import 'package:ma_meteo/models/forecast_day.dart';
import 'package:ma_meteo/services/forecast_service.dart';
import 'package:ma_meteo/services/location_service.dart';
import 'package:ma_meteo/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/user.dart';
import '../../../services/user_service.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _forecastService = locator<ForecastService>();
  final _locationService = locator<LocationService>();

  final _dialogService = locator<DialogService>();

  bool loading = false;
  bool noResult = false;
  User? user;
  List<ForecastDay> forecasts = [];

  String get screenTitle => '$ksHomeWelcome ${user?.fullname}';

  LatLng paris = const LatLng(48.862725, 2.287592);
  List<String> availableLocationsName = ["Paris", "Ma position"];
  String? selectedLocationName;
  late LatLng location;

  HomeViewModel() {
    fetchUser();
    initLocation();
  }

  void initLocation() {
    selectedLocationName = availableLocationsName[0];
    setLocation(selectedLocationName);
    location = paris;
  }

  void setLocation(String? loc) {
    selectedLocationName = loc;
    rebuildUi();
    if (selectedLocationName == "Paris") {
      location = paris;
      fetchForecasts();
    } else {
      //mine location
      getUserLocation();
    }
  }

  void getUserLocation() async {
    Position position = await _locationService.determinePosition();
    LatLng latLng = LatLng(position.latitude, position.longitude);
    location = latLng;
    fetchForecasts();
  }

  void fetchUser() async {
    user = await _userService.getUser();
    rebuildUi();
  }

  void fetchForecasts() async {
    //reset states
    noResult = false;
    loading = true;
    rebuildUi();
    //call api
    try {
      forecasts = await _forecastService.fetchForecasts(location);
    } catch (err) {
      noResult = true;
    }
    if (forecasts.isEmpty) {
      noResult = true;
    }
    loading = false;
    rebuildUi();
  }

  Future<bool> refresh() async {
    fetchForecasts();
    return true;
  }

  void retry() {
    fetchForecasts();
  }

  void requestLogout() async {
    var confirmationResponse = await _dialogService.showCustomDialog(
        variant: DialogType.logout,
        title: ksHomeDialogLogoutTitle,
        description: ksHomeDialogLogoutDescription,
        mainButtonTitle: ksHomeDialogLogoutConfirm,
        secondaryButtonTitle: ksHomeDialogLogoutCancel);
    if (confirmationResponse?.confirmed == true) {
      logout();
    }
  }

  Future<void> logout() async {
    // delete all stored data
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    // go to login view
    _navigationService.replaceWithLoginView();
  }

  String getFormatedDateFromGroupByValue(String groupByValue) {
    var dateFromGroupValue = DateFormat('dd/MM/yyyy').parse(groupByValue);
    var formatedDate = DateFormat('EEEE dd/MM').format(dateFromGroupValue);
    return formatedDate.capitalize();
  }

}
