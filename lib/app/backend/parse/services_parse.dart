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

class ServicesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ServicesParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getServices(var body) async {
    var response = await apiService.postPrivate(AppConstants.getMyServices, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> servicesDestroy(var body) async {
    var response = await apiService.postPrivate(AppConstants.servicesDestroy, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getFreelancerId() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> onUpdateServices(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateService, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ?? AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ?? AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ?? AppConstants.defaultCurrencySymbol;
  }
}
