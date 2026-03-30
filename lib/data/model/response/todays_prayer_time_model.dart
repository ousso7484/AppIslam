// class TodaysPrayerTimeModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   TodaysPrayerTimeModel({this.status, this.message, this.data});
//
//   TodaysPrayerTimeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? date;
//   String? sunrise;
//   String? fajrAzan;
//   String? fajrJamat;
//   String? zuhrAzan;
//   String? zuhrJamat;
//   String? asrAzan;
//   String? asrJamat;
//   String? maghribAzan;
//   String? maghribJamat;
//   String? ishaAzan;
//   String? ishaJamat;
//   bool? isJumma;
//   String? sehriEnd;
//   String? iftarStart;
//
//   Data(
//       {this.date,
//       this.sunrise,
//       this.fajrAzan,
//       this.fajrJamat,
//       this.zuhrAzan,
//       this.zuhrJamat,
//       this.asrAzan,
//       this.asrJamat,
//       this.maghribAzan,
//       this.maghribJamat,
//       this.ishaAzan,
//       this.ishaJamat,
//       this.isJumma,
//       this.sehriEnd,
//       this.iftarStart});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     sunrise = json['sunrise'];
//     fajrAzan = json['fajr_azan'];
//     fajrJamat = json['fajr_jamat'];
//     zuhrAzan = json['zuhr_azan'];
//     zuhrJamat = json['zuhr_jamat'];
//     asrAzan = json['asr_azan'];
//     asrJamat = json['asr_jamat'];
//     maghribAzan = json['maghrib_azan'];
//     maghribJamat = json['maghrib_jamat'];
//     ishaAzan = json['isha_azan'];
//     ishaJamat = json['isha_jamat'];
//     isJumma = json['is_jumma'];
//     sehriEnd = json['sehri_end'];
//     iftarStart = json['iftar_start'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['date'] = date;
//     data['sunrise'] = sunrise;
//     data['fajr_azan'] = fajrAzan;
//     data['fajr_jamat'] = fajrJamat;
//     data['zuhr_azan'] = zuhrAzan;
//     data['zuhr_jamat'] = zuhrJamat;
//     data['asr_azan'] = asrAzan;
//     data['asr_jamat'] = asrJamat;
//     data['maghrib_azan'] = maghribAzan;
//     data['maghrib_jamat'] = maghribJamat;
//     data['isha_azan'] = ishaAzan;
//     data['isha_jamat'] = ishaJamat;
//     data['is_jumma'] = isJumma;
//     data['sehri_end'] = sehriEnd;
//     data['iftar_start'] = iftarStart;
//     return data;
//   }
// }
class PrayerTimeModel {
  bool? status;
  String? message;
  Data? data;

  PrayerTimeModel({this.status, this.message, this.data});

  PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? date;
  bool? isJumma;
  String? imsak;
  String? fajrStart;
  String? sunrise;
  String? zuhrStart;
  String? asrStart;
  String? maghribStart;
  String? ishaStart;

  Data(
      {this.date,
      this.isJumma,
      this.imsak,
      this.fajrStart,
      this.sunrise,
      this.zuhrStart,
      this.asrStart,
      this.maghribStart,
      this.ishaStart});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isJumma = json['is_jumma'];
    imsak = json['imsak'];
    fajrStart = json['fajr_start'];
    sunrise = json['sunrise'];
    zuhrStart = json['zuhr_start'];
    asrStart = json['asr_start'];
    maghribStart = json['maghrib_start'];
    ishaStart = json['isha_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['is_jumma'] = isJumma;
    data['imsak'] = imsak;
    data['fajr_start'] = fajrStart;
    data['sunrise'] = sunrise;
    data['zuhr_start'] = zuhrStart;
    data['asr_start'] = asrStart;
    data['maghrib_start'] = maghribStart;
    data['isha_start'] = ishaStart;
    return data;
  }
}
