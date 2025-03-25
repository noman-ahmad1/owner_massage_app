/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V8
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2025-present initappz.
*/
import 'package:jiffy/jiffy.dart';

class AnalyticsModel {
  int? count;
  String? dayName;
  String? day;
  double? total;

  AnalyticsModel({this.count, this.dayName, this.day, this.total});

  AnalyticsModel.fromJson(Map<String, dynamic> json) {
    count = int.parse(json['count'].toString());
    dayName = Jiffy.parse(json['day_name'].toString()).format(pattern: 'EEEE, dd');
    day = Jiffy.parse(json['day'].toString()).yMMMMd;
    total = double.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['day_name'] = dayName;
    data['day'] = day;
    data['total'] = total;
    return data;
  }
}
