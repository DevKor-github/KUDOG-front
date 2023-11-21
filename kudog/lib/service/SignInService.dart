import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInService extends ChangeNotifier {
  late UserToken userToken;
  bool successLogin = false;
  void Signin(LoginUser user) async {
    SharedPreferences sharedPrefernce = await SharedPreferences.getInstance();
    Map<String, dynamic> data = user.toJson();
    try {
      Response response = await Dio()
          .post("https://api.kudog.devkor.club/auth/login", data: data);

      if (response.statusCode == 201) {
        print("POST 요청 성공");

        successLogin = true;
        userToken = UserToken.fromJson(response.data);
        sharedPrefernce.setString("access_token", userToken.accessToken!);
        sharedPrefernce.setString("refresh_token", userToken.refreshToken!);
        print("로그인 함수: " + sharedPrefernce.getString("access_token")!);
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }
  }

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

class UserLoginProvider with ChangeNotifier {
  //로그인 페이지에서 사용
  bool _UserloginState = false;
  // 시작할때 user login 정보 load
  loadUserLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(
        "user state modal shared preferences value : ${prefs.getBool('UserLogin')}");
    if ((prefs.getBool('UserLogin') ?? 0) == 0) {
      prefs.setBool('UserLogin', _UserloginState);
    } else {
      _UserloginState = prefs.getBool('UserLogin')!;
    }
  }

  bool get getUserLoginState => _UserloginState;

  setUserLoginStateTrue() {
    _UserloginState = true;
  }

  setUserLoginStateFalse() {
    _UserloginState = false;
  }
}
//로그인 페이지에서 사용
// Provider.of<UserLoginProvider>(context,
//                                     listen: false)
//                                 .setUserLoginStateTrue();
