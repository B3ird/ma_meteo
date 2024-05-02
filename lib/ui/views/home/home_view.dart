import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:stacked/stacked.dart';
import 'package:ma_meteo/ui/common/app_colors.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcPrimaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                  height: 80,
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    viewModel.screenTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kcSnow,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => viewModel.requestLogout(),
                  child: SvgPicture.asset(
                    "assets/icons/logout.svg",
                    colorFilter:
                        const ColorFilter.mode(kcSnow, BlendMode.srcIn),
                    height: 32,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/marker.svg",
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(kcWineRed, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: viewModel.selectedLocationName,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: kcNight,
                  ),
                  dropdownColor: kcNight,
                  elevation: 16,
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? value) {
                    viewModel.setLocation(value);
                  },
                  items: viewModel.availableLocationsName
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: kcSnow,
                          fontSize: 24,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            if (viewModel.loading)
              const Expanded(
                child: Center(
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      color: kcSnow,
                      strokeWidth: 6,
                    ),
                  ),
                ),
              ),
            if (!viewModel.loading && viewModel.noResult)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      ksHomeNoResult,
                      style: TextStyle(
                        color: kcSnow,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcSnow,
                      ),
                      onPressed: () => viewModel.retry(),
                      child: const Text(
                        ksHomeRefresh,
                        style: TextStyle(
                          color: kcPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if (!viewModel.loading && !viewModel.noResult)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return viewModel.refresh();
                  },
                  child: GroupedListView<dynamic, String>(
                    elements: viewModel.forecasts,
                    groupBy: (element) => element.day,
                    groupSeparatorBuilder: (String groupByValue) => Container(
                      padding: const EdgeInsets.all(4),
                      color: kcSnow,
                      child: Text(
                        viewModel.getFormatedDateFromGroupByValue(groupByValue),
                        style: const TextStyle(
                            color: kcPrimaryColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    itemBuilder: (context, dynamic element) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: kcCloud,
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 24,
                              bottom: 24,
                            ),
                            child: Text(
                              element.hour,
                              style: const TextStyle(
                                  color: kcNight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(width: 16),
                          FadeInImage.assetNetwork(
                              width: 64,
                              height: 64,
                              placeholder: 'assets/logo.png',
                              image: element.iconUrl),
                          const SizedBox(width: 16),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    "${element.temperature.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                        color: kcSnow,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "°C",
                                    style: TextStyle(
                                        color: kcSnow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w100),
                                  )
                                ]),
                              ]),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              "${element.description}",
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: kcSnow,
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ]),
                    itemComparator: (item1, item2) =>
                        item1.date.compareTo(item2.date),
                    useStickyGroupSeparators: true,
                    floatingHeader: false,
                    order: GroupedListOrder.ASC, // optional
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
