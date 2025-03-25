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
import 'package:owner/app/util/constance.dart';
import 'package:get/get.dart';

class ServicesCategorisParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ServicesCategorisParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> selectCategories(var body) async {
    var response = await apiService.postPrivate(AppConstants.getSelectedCategories, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> individualCategories(var body) async {
    var response = await apiService.postPrivate(AppConstants.getIndividualCategories, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  bool getType() {
    return sharedPreferencesManager.getString('type') == 'salon' ? true : false;
  }

  Future<Response> updateCate(String cateIds) async {
    var response = await apiService.postPrivate(AppConstants.salonUpdate, {"id": sharedPreferencesManager.getString('id'), "categories": cateIds}, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
