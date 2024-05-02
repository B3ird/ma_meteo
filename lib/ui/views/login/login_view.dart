import 'package:flutter/material.dart';
import 'package:ma_meteo/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_strings.dart';
import '../../forms/field/field.dart';
import '../../forms/warning/warning.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 24,
                    bottom: 48,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.cover,
                        height: 172,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(height: 48),
                      if (viewModel.formErrors.isNotEmpty)
                        const Warning(
                          text: ksLoginWarning,
                          iconPath: "assets/icons/warning.svg",
                        ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: FieldWidget(
                          controller: viewModel.mailController,
                          errorText: viewModel.formErrors["mail"],
                          hintText: ksLoginMailHint,
                          iconPath: "assets/icons/mail.svg",
                          inputType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: FieldWidget(
                          controller: viewModel.passwordController,
                          errorText: viewModel.formErrors["password"],
                          hintText: ksLoginPasswordHint,
                          tooltip: ksLoginPasswordTooltip,
                          obscureText: true,
                          last: true,
                          inputType: TextInputType.visiblePassword,
                          iconPath: "assets/icons/pass.svg",
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kcSnow,
                              side: const BorderSide(
                                color: kcNight,
                                width: 2,
                              ),
                              shadowColor: Colors.transparent,
                              elevation: 4,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                              ),
                            ),
                            onPressed: () {
                              viewModel.validForm();
                            },
                            child: const Text(ksLoginLogin,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kcNight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
