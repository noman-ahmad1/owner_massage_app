/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V8
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2025-present initappz.
*/
import 'package:image_picker/image_picker.dart';
import 'package:owner/app/backend/api/api.dart';
import 'package:owner/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:owner/app/util/constance.dart';

class AddServicesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddServicesParser({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> onSubmit(dynamic body) async {
    var response = await apiService.postPrivate(AppConstants.serviceCreate, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getServiceByID(var body) async {
    var response = await apiService.postPrivate(AppConstants.getServiceByID, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> onUpdateService(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateService, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService.uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '0';
  }
}
