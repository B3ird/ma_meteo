import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ma_meteo/app/app.dialogs.dart';
import 'package:ma_meteo/app/app.locator.dart';
import 'package:ma_meteo/ui/common/app_strings.dart';
import 'package:ma_meteo/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('requestLogout -', () {
      test('When called, should show custom confirm dialog', () {
        final dialogService = getAndRegisterDialogService();

        final model = getModel();
        model.requestLogout();
        verify(dialogService.showCustomDialog(
            variant: DialogType.logout,
            title: ksHomeDialogLogoutTitle,
            description: ksHomeDialogLogoutDescription,
            mainButtonTitle: ksHomeDialogLogoutConfirm,
            secondaryButtonTitle: ksHomeDialogLogoutCancel));
      });
    });
  });
}
