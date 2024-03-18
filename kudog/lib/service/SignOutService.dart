import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/util/DioClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutService extends ChangeNotifier {
  void signOut() async {
    try {
      SharedPreferences sharedPreference =
          await SharedPreferences.getInstance();
      DioClient dioClient = DioClient();
      await dioClient.delete("/auth/logout");
      sharedPreference.remove("access_token");
      sharedPreference.remove("refresh_token");
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }
}
