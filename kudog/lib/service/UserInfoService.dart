import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/UserInfoModel.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoService extends ChangeNotifier {
  UserInfo user = UserInfo(
    name: "",
  );
  bool isSuccess = false;
  Future<void> getUserInfo() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/users/info",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        user = UserInfo.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getUserInfo();
      } else if (response.statusCode == 404) {
        print("GET 요청 실패");
        print("존재하지 않는 유저");
      } else {
        print("GET 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("GET 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> modifyUserInfo(UserInfo _userInfo) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");
      Map<String, dynamic> data = _userInfo.toJson();
      Response response = await Dio().put(
        "https://api.kudog.devkor.club/users/info",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("PUT 요청 성공");
        isSuccess = true;
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        getUserInfo();
      } else if (response.statusCode == 404) {
        print("PUT 요청 실패");
        print("존재하지 않는 유저");
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }
}
