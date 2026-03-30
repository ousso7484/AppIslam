// ignore_for_file: deprecated_membe, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabi/controller/package_prayer_time_controller.dart';
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/helper/date_converter.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:zabi/helper/salat_waqt_service.dart';
import 'package:zabi/helper/translator_helper.dart';
import 'package:zabi/shimmer/all_shimmer_loder.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:zabi/view/screens/home/widget/bannder_widget.dart';
import 'package:zabi/view/screens/home/widget/feature_item_widget.dart';
import 'package:zabi/view/screens/home/widget/today_prayer_list_item.dart';

import '../../../controller/theme_controller.dart';
import '../../../data/repository/quran_setting_repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prayerTimeController = Get.find<PrayerTimeController>();
      final prefs = await SharedPreferences.getInstance();
      final isPrayerTme = prefs.getBool(AppConstants.isPrayerTme);
      final saveCityName = prefs.getString(AppConstants.saveCityName);
      prayerTimeController.fetchPrayerTime(
          isManualPrayerTme: isPrayerTme ?? false,
          manualCity:
              saveCityName ?? prayerTimeController.currentAddress.toString());

      // prayerTimeController.cityCategoryListData();
    });
    Get.find<PrayerTimeController>().getLocation();
    Get.find<PrayerTimeController>().loadPrayerTimeSettings();
    Get.put(QuranSettingsRepo(
        sharedPreferences: Get.find(), apiClient: Get.find()));
    Get.put(SettingsController(quranSettingRepo: Get.find()));
    Get.find<SettingsController>().fetchMosqueSettingsData();
    SalatWaqtService.initializeSalatWaqt();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (settingsController) {
        return GetBuilder<PrayerTimeController>(
          builder: (prayerTimeController) {
            var mosqueSettingsLoading =
                settingsController.isMosqueSettingsLoading.value;
            var packagePrayerTimeLoading =
                prayerTimeController.isprayerTimeLoading.value;

            return Scaffold(
              // AppBar Start===>
              appBar: mosqueSettingsLoading ||
                      packagePrayerTimeLoading ||
                      settingsController.mosqueSettingsApiData == null
                  ? null
                  : AppBar(
                      backgroundColor: Get.isDarkMode
                          ? Theme.of(context).cardColor
                          : Theme.of(context).primaryColor,
                      elevation: 0,
                      centerTitle: false,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            settingsController
                                .mosqueSettingsApiData!.data!.mosqueName
                                .toString(),
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE + 2,
                              color: Get.isDarkMode
                                  ? null
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                          Row(
                            children: [
                              // Icon_Location image
                              SvgPicture.asset(
                                Images.Icon_Location,
                                height: 14,
                                fit: BoxFit.fill,
                                color: Theme.of(context).hintColor,
                              ),

                              const SizedBox(width: 3),

                              // address
                              Expanded(
                                child: Text(
                                  Get.find<PrayerTimeController>()
                                          .saveLocalStoreCity ??
                                      prayerTimeController.currentAddress
                                          .toString(),
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        settingsController.mosqueSettingsApiData!.data!
                                    .showBannerIcon ==
                                true
                            ? IconButton(
                                onPressed: () {
                                  Get.toNamed(RouteHelper.donationTypeList);
                                },
                                icon: Get.isDarkMode
                                    ? SvgPicture.asset(
                                        Images.Icon_Donated,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : SvgPicture.asset(
                                        Images.Icon_Donated,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        color: Theme.of(context).cardColor,
                                      ))
                            : const SizedBox(),
                        IconButton(
                          tooltip: "light_or_dark_mode".tr,
                          icon: Get.isDarkMode
                              ? SvgPicture.asset(
                                  Images.Icon_day_mode,
                                  height: 25,
                                  fit: BoxFit.fill,
                                  color: Get.isDarkMode
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                                )
                              : SvgPicture.asset(
                                  Images.Icon_dark_mode,
                                  height: 25,
                                  fit: BoxFit.fill,
                                  color: Theme.of(context).cardColor,
                                ),
                          onPressed: () {
                            Get.find<ThemeController>().toggleTheme();
                          },
                        ),
                      ],
                    ),
              // Body Start===>
              body: SafeArea(
                top: false,
                child: mosqueSettingsLoading ||
                        packagePrayerTimeLoading ||
                        settingsController.mosqueSettingsApiData == null
                    ? const DashbordShimmerScreen()
                    : SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Banner Prayer Time Section
                            const BannerWidget(),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            // Sheri and iftar section =====>
                            // mosqueSettingsApiData!.data!.ramadanSchedule ==
                            //         true
                            //     ? const Column(
                            //         children: [
                            //           RamadanScheduleWidget(),
                            //           SizedBox(
                            //               height: Dimensions
                            //                   .PADDING_SIZE_EXTRA_SMALL),
                            //         ],
                            //       )
                            //     : const SizedBox(),

                            //Todays prayer time section start
                            GetBuilder<PrayerTimeController>(
                              builder: (autometicPrayerTimeController) {
                                final is24HourFormat =
                                    Get.find<PrayerTimeController>()
                                        .is24HourFormat
                                        .value;
                                final automaticPrayerTimeData =
                                    autometicPrayerTimeController
                                        .prayerTimeModel?.data;

                                String resolvePrayerTime(
                                  String? automaticTime,
                                ) {
                                  return translateText(
                                      DateConverter.formatPrayerTime(
                                          automaticTime ?? "00:00",
                                          is24HourFormat));
                                }

                                Widget buildPrayerRow({
                                  required String icon,
                                  required String prayerName,
                                  String? adhan,
                                  String? jamah,
                                  bool isSunrise = false,
                                  String? sunriseStart,
                                }) {
                                  return TodaysprayerWidget(
                                    iconImage: icon,
                                    prayerName: prayerName,
                                    adhan: adhan ?? "00:00",
                                    jamah: jamah ?? "00:00",
                                    isSunrise: isSunrise,
                                    sunriseStart: sunriseStart ?? "00:00",
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() => Text(
                                            "${"todays_Prayer_Time_in".tr} ${autometicPrayerTimeController.saveAddress.value.isNotEmpty ? autometicPrayerTimeController.saveAddress.value.toString() : autometicPrayerTimeController.currentAddress.value}",
                                            textAlign: TextAlign.left,
                                            style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )),
                                      const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              buildPrayerRow(
                                                icon: Images.Icon_Fajr,
                                                prayerName: 'fajr'.tr,
                                                adhan: resolvePrayerTime(
                                                  automaticPrayerTimeData
                                                          ?.fajrStart ??
                                                      "00:00",
                                                ),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_DEFAULT),
                                              buildPrayerRow(
                                                icon: Images.Sunrise,
                                                prayerName: 'sunrise'.tr,
                                                isSunrise: true,
                                                sunriseStart: resolvePrayerTime(
                                                  automaticPrayerTimeData
                                                          ?.sunrise ??
                                                      "00:00",
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          Row(
                                            children: [
                                              buildPrayerRow(
                                                icon: Images.Icon_Dhuhr,
                                                prayerName:
                                                    automaticPrayerTimeData
                                                                ?.isJumma ==
                                                            true
                                                        ? 'jumuah'.tr
                                                        : 'dhuhr'.tr,
                                                adhan: resolvePrayerTime(
                                                  automaticPrayerTimeData
                                                          ?.zuhrStart ??
                                                      "00:00",
                                                ),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_DEFAULT),
                                              buildPrayerRow(
                                                icon: Images.Icon_Asr,
                                                prayerName: 'asr'.tr,
                                                adhan: resolvePrayerTime(
                                                  automaticPrayerTimeData
                                                          ?.asrStart ??
                                                      "00:00",
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          Row(
                                            children: [
                                              buildPrayerRow(
                                                icon: Images.Icon_Maghrib,
                                                prayerName: 'magrib'.tr,
                                                adhan: resolvePrayerTime(
                                                  automaticPrayerTimeData
                                                          ?.maghribStart ??
                                                      "00:00",
                                                ),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_DEFAULT),
                                              buildPrayerRow(
                                                icon: Images.Icon_Isha,
                                                prayerName: 'isha'.tr,
                                                adhan: resolvePrayerTime(
                                                  automaticPrayerTimeData
                                                          ?.ishaStart ??
                                                      "00:00",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT),

                            // Donation banner section
                            settingsController.mosqueSettingsApiData!.data!
                                        .showDonationBanner ==
                                    true
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                RouteHelper.donationTypeList);
                                          },
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color:
                                                    Theme.of(context).cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_DEFAULT),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Get.isDarkMode
                                                          ? Colors.grey[850]!
                                                          : Colors.grey[200]!,
                                                      spreadRadius: 1,
                                                      blurRadius: 5)
                                                ],
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    settingsController
                                                        .mosqueSettingsApiData!
                                                        .data!
                                                        .donationBanner
                                                        .toString(),
                                                  ),
                                                  fit: BoxFit.fitWidth,
                                                  onError: (_, __) =>
                                                      const AssetImage(
                                                    Images.Donate_Now,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                    ],
                                  )
                                : SizedBox(),

                            // Feature item section
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.PADDING_SIZE_DEFAULT),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_DEFAULT),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Get.isDarkMode
                                            ? Colors.grey[850]!
                                            : Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_GRID_SMALL),
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    primary: false,
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    addAutomaticKeepAlives: false,
                                    children: [
                                      // audio section ===>
                                      FeatureItemWidget(
                                        itemName: "audio_quran".tr,
                                        itemIconPath: Images.Iocn_Audio,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.recters);
                                        },
                                      ),
                                      // hadith section ===>
                                      FeatureItemWidget(
                                        itemName: "hadith".tr,
                                        itemIconPath: Images.Icon_Hadith,
                                        onPressed: () {
                                          Get.toNamed(
                                              RouteHelper.hadithBookName);
                                        },
                                      ),
                                      // Allah name  section ===>
                                      FeatureItemWidget(
                                        itemName: "allah_name".tr,
                                        itemIconPath: Images.Icon_Allah_99_name,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.sifatName);
                                        },
                                      ),
                                      // dua section ===>
                                      FeatureItemWidget(
                                        itemName: "dua".tr,
                                        itemIconPath: Images.Icon_Dua,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.dua);
                                        },
                                      ),
                                      // dikir section ===>
                                      FeatureItemWidget(
                                        itemName: "dikir".tr,
                                        itemIconPath: Images.Icon_Dikir,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.dhikr);
                                        },
                                      ),
                                      // quibla section ===>
                                      FeatureItemWidget(
                                        itemName: "compass".tr,
                                        itemIconPath: Images.Icon_Qibla,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.compass);
                                        },
                                      ),

                                      // near by mosque section ===>
                                      FeatureItemWidget(
                                        itemName: "nearby".tr,
                                        itemIconPath: Images.Icon_near_mosque,
                                        onPressed: () {
                                          Get.toNamed(RouteHelper.nearByMosque);
                                        },
                                      ),
                                      // Zakat section ===>
                                      FeatureItemWidget(
                                        itemName: "zakat".tr,
                                        itemIconPath: Images.Icon_Zakat,
                                        onPressed: () {
                                          Get.toNamed(
                                              RouteHelper.zakatCalculator);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT),
                          ],
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
