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

class ChatParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ChatParser({required this.sharedPreferencesManager, required this.apiService});

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getChatRooms(var uid, var participants) async {
    return await apiService.postPrivate(AppConstants.getChatRooms, {'sender_id': uid, 'receiver_id': participants}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> createChatRooms(var uid, var participants) async {
    return await apiService.postPrivate(AppConstants.createChatRooms, {'sender_id': uid, 'receiver_id': participants, 'status': 1}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getChatList(var roomId) async {
    return await apiService.postPrivate(AppConstants.getChatList, {'room_id': roomId}, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> sendMessage(var param) async {
    return await apiService.postPrivate(AppConstants.sendMessage, param, sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> sendNotification(var body) async {
    var response = await apiService.postPrivate(AppConstants.sendNotification, body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}
