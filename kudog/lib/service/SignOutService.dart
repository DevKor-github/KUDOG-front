import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutService extends ChangeNotifier {
  void SignOut() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {
      String? token = sharedPreference.getString("access_token");
      Response response = await Dio().delete(
        "https://api.kudog.devkor.club/auth/logout",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('DELETE 요청 성공');
        sharedPreference.remove("access_token");
        sharedPreference.remove("refresh_token");
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        SignOut();
      } else {
        print('DELETE 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('DELETE 요청 에러');
      print(e.toString());
    }

    notifyListeners();
  }
}
