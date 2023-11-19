import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/AuthModel.dart';

class SignInService extends ChangeNotifier {
  late UserToken userToken;
  Future<void> SignIn(LoginUser user) async {
    Map<String, dynamic> data = user.toJson();
    try {
      Response response =
          await Dio().post("http://54.180.85.164:3050/auth/login", data: data);
      if (response.statusCode == 200) {
        print("POST 요청 성공");
        userToken = UserToken.fromJson(response.data);
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }
  }
}
