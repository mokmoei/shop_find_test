import 'package:find_shop_test/core/utils/date_time_utils.dart';

class ShopModel {
  String siteId;
  String siteDesc;
  String siteAddress;
  String siteTel;
  Location location;
  DateTime siteCloseTime;
  DateTime siteOpenTime;
  double distance;

  ShopModel({
    required this.siteId,
    required this.siteDesc,
    required this.siteAddress,
    required this.siteTel,
    required this.location,
    required this.siteCloseTime,
    required this.siteOpenTime,
    this.distance = 0,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    final siteOpenTime =
        AppDateTimeUtil.convertTimeStringToDateTime(json['site_open_time']);
    final siteCloseTime =
        AppDateTimeUtil.convertTimeStringToDateTime(json['site_close_time']);
    return ShopModel(
      siteId: json['site_id'],
      siteDesc: json['site_desc'],
      siteAddress: json['site_address'],
      siteTel: json['site_tel'],
      location: (json['location'] != null
          ? Location.fromJson(json['location'])
          : null)!,
      siteCloseTime: siteCloseTime,
      siteOpenTime: siteOpenTime,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['site_id'] = siteId;
    data['site_desc'] = siteDesc;
    data['site_address'] = siteAddress;
    data['site_tel'] = siteTel;
    data['location'] = location.toJson();
    data['site_close_time'] = siteCloseTime;
    data['site_open_time'] = siteOpenTime;
    return data;
  }

  bool isOpen(DateTime dateNow) {
    if (siteOpenTime == siteCloseTime) {
      // open 24/7
      return true;
    } else if (siteCloseTime.isAfter(siteOpenTime)) {
      // open 8.00 close 16.00
      return AppDateTimeUtil.compareTimeInRange(
        dateNow,
        siteOpenTime,
        siteCloseTime,
      );
    } else {
      // case open 22.00 close 20.00
      // now 14.00
      final timeOpen1 = AppDateTimeUtil.compareTimeInRange(
        dateNow,
        siteOpenTime.subtract(const Duration(days: 1)),
        siteCloseTime,
      );
      // now 23.00
      final timeOpen2 = AppDateTimeUtil.compareTimeInRange(
        dateNow,
        siteOpenTime,
        siteCloseTime.add(const Duration(days: 1)),
      );
      return timeOpen1 || timeOpen2;
    }
  }
}

class Location {
  final String type;
  final double latitude;
  final double longitude;

  const Location({
    this.type = '',
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final List<double> coordinates = json['coordinates'].cast<double>();
    return Location(
      type: json['type'],
      longitude: coordinates.first,
      latitude: coordinates.last,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = [longitude, latitude];
    return data;
  }
}
