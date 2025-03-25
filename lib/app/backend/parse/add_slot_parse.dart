/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V8
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2025-present initappz.
*/
import 'package:owner/app/backend/api/api.dart';
import 'package:owner/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:owner/app/util/constance.dart';

class AddSlotParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddSlotParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onCreateTimeSlot(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.createTimeSlot, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> onUpdateSlots(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.updateSlot, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getSlotbyId(var id) async {
    var response = await apiService.postPrivate(AppConstants.getSlotInfoById, {"id": id}, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}
