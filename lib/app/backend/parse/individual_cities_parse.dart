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

class IndividualCitiesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  IndividualCitiesParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getAllCities() async {
    var response = await apiService.getPrivate(AppConstants.getAllCities, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateCities(String cityIds) async {
    var response = await apiService.postPrivate(AppConstants.updateIndividual, {"id": sharedPreferencesManager.getString('id'), "cid": cityIds}, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
