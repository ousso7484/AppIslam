// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/controller/quran_controller.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/view/base/loading_indicator.dart';

void openBottomSheet(BuildContext context) {
  showModalBottomSheet(
    // backgroundColor: Theme.of(context).cardColor,
    enableDrag: false,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
        topRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
      ),
    ),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return GetBuilder<SettingsController>(
        builder: (settingsController) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // quran settings header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: null,
                        child: Text(
                          "",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                      Text(
                        'quran_settings'.tr,
                        textAlign: TextAlign.center,
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "close".tr,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),

                  // arabic font size
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        'arabic_font_size'.tr,
                        style: robotoMedium.copyWith(),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: settingsController.arabicFontSize.value,
                              min: 14.0,
                              max: 40.0,
                              onChanged: (newValue) {
                                settingsController
                                    .changeArabicFontSize(newValue);
                              },
                            ),
                          ),
                          Text(
                            settingsController.arabicFontSize.value
                                .toStringAsFixed(0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),

                  // translation font size
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        'translate_font_size'.tr,
                        style: robotoMedium.copyWith(),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: settingsController.translateFontSize.value,
                              min: 12.0,
                              max: 24.0,
                              onChanged: (newValue) {
                                settingsController
                                    .changeTranslateFontSize(newValue);
                              },
                            ),
                          ),
                          Text(
                            settingsController.translateFontSize.value
                                .toStringAsFixed(0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),

                  // arabic font size section
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        'arabic_font_style'.tr,
                        style: robotoMedium.copyWith(),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                          ),
                          child: settingsController
                                      .isSelectedFontLoading.value ==
                                  true
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: LoadingIndicator(),
                                ))
                              : DropdownButton<String>(
                                  menuMaxHeight: 500,
                                  value: settingsController.selectedFont.value,
                                  items: <String>[
                                    'Scheherazade New',
                                    'Amiri',
                                    'Amiri Quran',
                                    'Noto Nastaliq Urdu',
                                    'Noto Sans Arabic',
                                    'Noto Kufi Arabic',
                                    'Noto Naskh Arabic',
                                    'Gulzar',
                                    'Reem Kufi Ink',
                                    'Harmattan',
                                    'Lateef',
                                    'Mada',
                                    'Readex Pro',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    settingsController.changeArabicFont(value!);
                                  },
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),

                  // translation name start
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'translator_name'.tr,
                      style: robotoMedium.copyWith(),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        child: settingsController.isTranslateLoading.value ||
                                settingsController
                                    .allTranslationNameList.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Text(
                                    "--",
                                    style: robotoMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Obx(
                                () => settingsController
                                            .isTranslateDropdownLoading.value ==
                                        true
                                    ? const Center(
                                        child: Padding(
                                        padding: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        child: LoadingIndicator(),
                                      ))
                                    : DropdownButton(
                                        menuMaxHeight: 500,
                                        value: settingsController
                                                    .translateDropdown.value ==
                                                ""
                                            ? "${settingsController.allTranslationNameList[0]['id']}. ${settingsController.allTranslationNameList[0]['full_name']}"
                                            : settingsController
                                                .translateDropdown.value
                                                .toString(),
                                        items: settingsController
                                            .allTranslationNameList
                                            .map((translation) {
                                          return DropdownMenuItem(
                                            value:
                                                "${translation["id"]}. ${translation["full_name"]}",
                                            child: Text(
                                              "${translation['language']}:  ${translation['full_name']}",
                                              style: robotoMedium.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          'select_a_translator'.tr,
                                          style: robotoMedium,
                                        ),
                                        onChanged: (value) {
                                          for (var i = 0;
                                              i <
                                                  settingsController
                                                      .allTranslationNameList
                                                      .length;
                                              i++) {
                                            var apiTranslator =
                                                "${settingsController.allTranslationNameList[i]['id']}. ${settingsController.allTranslationNameList[i]['full_name']}";

                                            if (apiTranslator ==
                                                value.toString()) {
                                              // Store data locally
                                              settingsController
                                                      .selectedTranslatorId
                                                      .value =
                                                  settingsController
                                                      .allTranslationNameList[i]
                                                          ['id']
                                                      .toString();

                                              settingsController
                                                  .updateTranslateDropdownValue(
                                                      value,
                                                      settingsController
                                                          .selectedTranslatorId
                                                          .value);

                                              // Re call Api for update ui
                                              Get.find<QuranController>()
                                                  .fetchSuraDetaileData(
                                                      suraId: Get.find<
                                                              QuranController>()
                                                          .suraNumber
                                                          .toString(),
                                                      translatorId:
                                                          settingsController
                                                              .selectedTranslatorId
                                                              .value);
                                              Get.find<QuranController>()
                                                  .fetchSuraListData(
                                                      translatorId:
                                                          settingsController
                                                              .selectedTranslatorId
                                                              .value);
                                              Get.find<QuranController>()
                                                  .fetchJuzListData(
                                                      translatorId:
                                                          settingsController
                                                              .selectedTranslatorId
                                                              .value);
                                            }
                                          }
                                        },
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                      ),
                              ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
