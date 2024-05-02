import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ma_meteo/ui/common/app_colors.dart';
import 'package:ma_meteo/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logout_dialog_model.dart';

const double _graphicSize = 60;

class LogoutDialog extends StackedView<LogoutDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const LogoutDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LogoutDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        request.description!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: kcMediumGrey,
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xffffd259),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/logout.svg",
                    colorFilter:
                        const ColorFilter.mode(kcSnow, BlendMode.srcIn),
                    height: 32,
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => completer(DialogResponse(
                      confirmed: false,
                    )),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kcSnow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        request.secondaryButtonTitle ?? "Annuler",
                        style: const TextStyle(
                          color: kcPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  GestureDetector(
                    onTap: () => completer(DialogResponse(
                      confirmed: true,
                    )),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kcPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        request.mainButtonTitle ?? "Ok",
                        style: const TextStyle(
                          color: kcSnow,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  @override
  LogoutDialogModel viewModelBuilder(BuildContext context) =>
      LogoutDialogModel();
}
