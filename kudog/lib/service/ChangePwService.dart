import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChangePwService extends ChangeNotifier {
  void RequestCode(String portalEmail) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["portalEmail"] = portalEmail;
    try {
      Response response = await Dio().post(
          "https://api.kudog.devkor.club/auth/change-password/request",
          data: data);
      if (response.statusCode == 200) {
        print("POST 요청 성공");
      } else if (response.statusCode == 400) {
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }
  }

  void VeriyfyCode(String code) async {
    bool isVerified = false;
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["code"] = code;
    try {
      Response response = await Dio().post(
          "https://api.kudog.devkor.club/auth/change-password/request",
          data: data);
      if (response.statusCode == 200) {
        isVerified = true;
        print("POST 요청 성공");
      } else if (response.statusCode == 400) {
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
