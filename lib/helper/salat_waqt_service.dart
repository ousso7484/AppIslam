import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabi/controller/package_prayer_time_controller.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:zabi/view/screens/notification/widgets/salat_waqt.dart';
import 'package:zabi/view/screens/notification/widgets/salat_waqt_repository.dart';

import 'adhan_notification_service_helper.dart';

// class SalatWaqtService {
//   final SalatWaqtRepository _salatWaqtRepository;
//
//   SalatWaqtService() : _salatWaqtRepository = SalatWaqtRepository();
//
//   Future<Position> getLocation() async {
//     if (!await Geolocator.isLocationServiceEnabled()) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//
//     var permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   Future<DateTime?> getPrayerTimeByWaqt(SalatWaqt salatWaqt) async {
//     final mosqueSetting = await getMosqueSetting();
//     if (mosqueSetting?.data?.automaticPayerTime == true) {
//       return _getAutomaticPrayerTime(salatWaqt);
//     } else {
//       return _getServerPrayerTime(salatWaqt);
//     }
//   }
//
//   Future<DateTime?> _getAutomaticPrayerTime(SalatWaqt salatWaqt) async {
//     DartPluginRegistrant.ensureInitialized();
//     final position = await getLocation();
//     final coordinates = pt.Coordinates(position.latitude, position.longitude);
//     final timeZone = await FlutterTimezone.getLocalTimezone();
//
//     // final params = pt.PrayerCalculationMethod.karachi()
//     //   ..madhab = pt.PrayerMadhab.hanafi;
//     debugPrint(
//         "noti selectedPrayerMethod=> ${Get.find<PrayerTimeController>().selectedPrayerMethod}");
//     debugPrint(
//         "noti selectedPrayerName=> ${Get.find<PrayerTimeController>().selectedPrayerName}");
//     debugPrint(
//         "noti selectedMadhavMethod=> ${Get.find<PrayerTimeController>().selectedMadhavMethod}");
//
//     Get.find<PrayerTimeController>().selectedPrayerMethod.madhab =
//         Get.find<PrayerTimeController>().selectedMadhavMethod;
//
//     final prayerTimes = pt.PrayerTimes(
//       coordinates: coordinates,
//       calculationParameters:
//           Get.find<PrayerTimeController>().selectedPrayerMethod,
//       precision: true,
//       locationName: timeZone,
//     );
//
//     return _getPrayerTimeById(prayerTimes, salatWaqt.id);
//   }
//
//   DateTime? _getPrayerTimeById(pt.PrayerTimes prayerTimes, int id) {
//     return switch (id) {
//       1 => prayerTimes.fajrStartTime,
//       2 => prayerTimes.dhuhrStartTime,
//       3 => prayerTimes.asrStartTime,
//       4 => prayerTimes.maghribStartTime,
//       5 => prayerTimes.ishaStartTime,
//       int() => throw UnimplementedError(),
//     };
//   }
//
//   Future<DateTime?> _getServerPrayerTime(SalatWaqt salatWaqt) async {
//     final todaysPrayerTime = await getPrayerTimesFromServer();
//     if (todaysPrayerTime?.data == null) return null;
//
//     return switch (salatWaqt.id) {
//       1 => _parsePrayerTime(todaysPrayerTime!.data!.fajrAzan!),
//       2 => _parsePrayerTime(todaysPrayerTime!.data!.zuhrAzan!),
//       3 => _parsePrayerTime(todaysPrayerTime!.data!.asrAzan!),
//       4 => _parsePrayerTime(todaysPrayerTime!.data!.maghribAzan!),
//       5 => _parsePrayerTime(todaysPrayerTime!.data!.ishaAzan!),
//       int() => throw UnimplementedError(),
//     };
//   }
//
//   Future<MosqueSettingsModel?> getMosqueSetting() async {
//     try {
//       final apiClient = Get.find<ApiClient>();
//       final response = await apiClient.getData(AppConstants.MOSQUE_SETTINGS);
//
//       if (response.statusCode == 200) {
//         return MosqueSettingsModel.fromJson(response.body);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error fetching data: $e");
//       }
//     }
//     return null;
//   }
//
//   Future<TodaysPrayerTimeModel?> getPrayerTimesFromServer() async {
//     try {
//       final currentDate = DateTime.now();
//       final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
//       final apiClient = Get.find<ApiClient>();
//       final response = await apiClient
//           .getData(AppConstants.TODAYS_PRAYER_TIME + formattedDate);
//
//       if (response.statusCode == 200) {
//         return TodaysPrayerTimeModel.fromJson(response.body);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error fetching data: $e");
//       }
//     }
//     return null;
//   }
//
//   DateTime _parsePrayerTime(String time) {
//     final timeList = time.split(":");
//     final hour = int.parse(timeList[0]);
//     final min = int.parse(timeList[1]);
//     return DateTime(DateTime.now().year, DateTime.now().month,
//         DateTime.now().day, hour, min);
//   }
//
//   Future<void> updateSalatWaqt() async {
//     final salatWaqtList = await _salatWaqtRepository.getSalatWaqtList();
//     for (final element in salatWaqtList) {
//       element.time = (await getPrayerTimeByWaqt(element)) ?? element.time;
//       await _salatWaqtRepository.saveSalatWaqt(element);
//     }
//   }
//
//   static Future<void> initializeSalatWaqt() async {
//     final notificationServices = NotificationServiceImpl();
//     await notificationServices.initializeNotification();
//
//     final salatWaqtRepository = SalatWaqtRepository();
//     var salatWaqtList = await salatWaqtRepository.getSalatWaqtList();
//
//     if (salatWaqtList.isEmpty) {
//       await salatWaqtRepository.seedSalatWaqt();
//     }
//     final salatWaqtService = SalatWaqtService();
//     await salatWaqtService.updateSalatWaqt();
//
//     salatWaqtList = await salatWaqtRepository.getSalatWaqtList();
//     for (final salatWaqt in salatWaqtList) {
//       if (salatWaqt.isNotificationEnabled) {
//         Get.find<PrayerTimeController>().getLocation();
//         final time = salatWaqt.time.toLocal();
//         debugPrint(
//             'scheduledtime for ${salatWaqt.name}: ${salatWaqt.time.toIso8601String()}');
//         debugPrint(
//             'scheduledtime local for ${salatWaqt.name}: ${time.toIso8601String()}');
//         await notificationServices.scheduleNotification(
//           id: salatWaqt.id,
//           title: salatWaqt.name.toLowerCase().tr,
//           body:
//               '${'time_for'.tr} ${salatWaqt.name} ${'started_at'.tr} ${DateFormat.jm().format(time)}',
//           dateTime: time,
//           payload: time.toIso8601String(),
//         );
//       } else {
//         await notificationServices.cancelNotification(salatWaqt.id);
//       }
//     }
//   }
// }
class SalatWaqtService {
  final SalatWaqtRepository _salatWaqtRepository;

  SalatWaqtService() : _salatWaqtRepository = SalatWaqtRepository();

  Future<DateTime?> getPrayerTimeByWaqt(SalatWaqt salatWaqt) async {
    return _getPrayerTime(salatWaqt);
  }

  Future<DateTime?> _getPrayerTime(SalatWaqt salatWaqt) async {
    final prefs = await SharedPreferences.getInstance();
    final isPrayerTme = prefs.getBool(AppConstants.isPrayerTme);
    final saveCityName = prefs.getString(AppConstants.saveCityName);

    await Get.find<PrayerTimeController>().fetchPrayerTime(
        reload: false,
        isManualPrayerTme: isPrayerTme ?? false,
        manualCity: saveCityName ??
            Get.find<PrayerTimeController>().currentAddress.toString());

    final autometicPrayerTime =
        Get.find<PrayerTimeController>().prayerTimeModel;

    if (autometicPrayerTime == null || autometicPrayerTime.data == null) {
      Get.log("Automatic prayer time data is null");
      return null;
    }

    switch (salatWaqt.id) {
      case 1:
        return _parsePrayerTime(autometicPrayerTime.data!.fajrStart ?? "");
      case 2:
        return _parsePrayerTime(autometicPrayerTime.data!.zuhrStart ?? "");
      case 3:
        return _parsePrayerTime(autometicPrayerTime.data!.asrStart ?? "");
      case 4:
        return _parsePrayerTime(autometicPrayerTime.data!.maghribStart ?? "");
      case 5:
        return _parsePrayerTime(autometicPrayerTime.data!.ishaStart ?? "");
      default:
        throw UnimplementedError("Invalid salatWaqt id: ${salatWaqt.id}");
    }
  }

  DateTime _parsePrayerTime(String time) {
    if (time.isEmpty) {
      throw const FormatException("Time string is empty");
    }

    final timeList = time.split(":");
    final hour = int.parse(timeList[0]);
    final min = int.parse(timeList[1]);
    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, min);
  }

  Future<void> updateSalatWaqt() async {
    final salatWaqtList = await _salatWaqtRepository.getSalatWaqtList();

    for (final element in salatWaqtList) {
      try {
        element.time = (await getPrayerTimeByWaqt(element)) ?? element.time;
        await _salatWaqtRepository.saveSalatWaqt(element);
      } catch (e) {
        Get.log("Failed to update SalatWaqt ${element.id}: $e");
      }
    }
  }

  static Future<void> checkNotificationPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }

  static Future<void> initializeSalatWaqt() async {
    checkNotificationPermission();
    final adhanNotificationServices = AdhanNotificationServiceImpl();
    await adhanNotificationServices.initializeNotification();

    final salatWaqtRepository = SalatWaqtRepository();
    var salatWaqtList = await salatWaqtRepository.getSalatWaqtList();

    if (salatWaqtList.isEmpty) {
      await salatWaqtRepository.seedSalatWaqt();
    }

    final salatWaqtService = SalatWaqtService();
    await salatWaqtService.updateSalatWaqt();

    salatWaqtList = await salatWaqtRepository.getSalatWaqtList();
    for (final salatWaqt in salatWaqtList) {
      if (salatWaqt.isNotificationEnabled) {
        final time = salatWaqt.time.toLocal();
        Get.log(
            'Notification for ${salatWaqt.name}: ${time.toIso8601String().split('T')[0]} => ${time.toIso8601String().split('T')[1]}');

        await adhanNotificationServices.scheduleNotification(
          id: salatWaqt.id,
          title: salatWaqt.name.toLowerCase().tr,
          body:
              '${'time_for'.tr} ${salatWaqt.name} ${'started_at'.tr} ${DateFormat.jm().format(time)}',
          dateTime: time,
          payload: time.toIso8601String(),
        );
      } else {
        await adhanNotificationServices.cancelNotification(salatWaqt.id);
      }
    }
  }
}
