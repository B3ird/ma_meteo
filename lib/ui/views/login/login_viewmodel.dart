import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:ma_meteo/app/app.router.dart';
import 'package:ma_meteo/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../services/user_service.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  final _bottomSheetService = locator<BottomSheetService>();

  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  Map<String, String> formErrors = {};

  void validForm() async {
    bool verified = verifyForm();
    if (verified) {
      bool logged = await login(
        mail: mailController.text,
        password: passwordController.text,
      );
      if (logged) {
        _navigationService.replaceWithHomeView();
      }
    }
  }

  Future<bool> login({
    required String mail,
    required String password,
  }) async {
    bool logged = await _userService.logIn(mail: mail, password: password);
    return logged;
  }

  bool verifyForm() {
    bool isValid = true;
    formErrors.clear();
    if (!EmailValidator.validate(mailController.text)) {
      formErrors["mail"] = ksLoginInvalidMail;
    }
    if (!validPassword(passwordController.text)) {
      formErrors["password"] = ksLoginInvalidPassword;
    }
    isValid = formErrors.isEmpty;
    notifyListeners();
    return isValid;
  }

  bool validPassword(String password) {
    bool valid = true;
    if (password.length < 8) {
      //is equal or longer than 8 characters
      valid = false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      //contain at least one uppercase
      valid = false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      //contain at least one number
      valid = false;
    }
    return valid;
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksLoginBottomSheetTitle,
      description: ksLoginBottomSheetDescription,
    );
  }
}
