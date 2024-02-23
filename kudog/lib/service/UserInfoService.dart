import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/UserModel.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoService extends ChangeNotifier {
  User user = User(
    name: "",
  );
  bool usersub = false;

  void getUserSubscribing() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/users/subscribe",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("토글 상태는 현재 : ${response.data}");
      usersub = response.data == 'true';
      print("usersub는 현재 : ${usersub}");

    } catch (e) {
      print("GET 요청 에러");
      print(e.toString());
    }
  }

  void putUserSubscribing() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");
      Response response = await Dio().put(
        "https://api.kudog.devkor.club/users/subscribe",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }
  }

  void getUserInfo() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");
      print(token);

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
        print(response.data);
        user = User.fromJson(response.data);
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
}
