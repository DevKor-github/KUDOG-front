import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/NotificationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService extends ChangeNotifier {
  List<Records> notificationRecords = [];
  List<Records> newNotificationRecords = [];
  Map<String, List<Records>> groupedByDate = {};
  Future<void> getAllNotifications() async {
    notificationRecords.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");
    try {
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notifications?page=1&pageSize=10",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("GET 요청 성공");
        for (Map<String, dynamic> item in response.data["records"]) {
          Records _record = Records.fromJson(item);
          String date = _record.date!.substring(0, 10);
          if (groupedByDate.containsKey(date)) {
            groupedByDate[date]!.add(_record);
          } else {
            groupedByDate[date] = [_record];
          }
          notificationRecords.add(_record);
        }
      } else {
        print("GET 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("GET 요청 에러");
      print(e.toString());
    }
  }

  Future<void> getNewNotifications() async {
    newNotificationRecords.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString("access_token");
    try {
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notifications/new?page=1&pageSize=10",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("GET 요청 성공");
        for (Map<String, dynamic> item in response.data["records"]) {
          Records _record = Records.fromJson(item);

          newNotificationRecords.add(_record);
        }
      } else {
        print("GET 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("GET 요청 에러");
      print(e.toString());
    }
  }
}
