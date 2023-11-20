import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/MailModel.dart';

class SignUpService extends ChangeNotifier {
  bool isVerified = false;
  bool isKorea = false;
  bool isSend = false;
  Future<void> SignUp(SignUpUser user) async {
    Map<String, dynamic> data = user.toJson();
    try {
      Response response =
          await Dio().post("http://54.180.85.164:3050/auth/signup", data: data);
      if (response.statusCode == 200) {
        print("POST 요청 성공");
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }
  }

  void SendEmail(SendMail mail) async {
    Map<String, dynamic> data = mail.toJson();
    try {
      Response response = await Dio()
          .post("http://54.180.85.164:3050/mail/verify/send", data: data);
      if (response.statusCode == 200) {
        isSend = true;
        isKorea = true;
        print("POST 요청 성공");
      } else if (response.statusCode == 400) {
        isKorea = false;
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }
  }

  void VerifyEmail(VerifyMail mail) async {
    Map<String, dynamic> data = mail.toJson();
    try {
      Response response = await Dio()
          .post("http://54.180.85.164:3050/mail/verify/check", data: data);
      if (response.statusCode == 200) {
        print("POST 요청 성공");
        isVerified = true;
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
