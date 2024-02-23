import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChangePwService extends ChangeNotifier {
  bool isVerified = false;
  int firstId = 0; //정상 작동 ; 1, 그렇지 않으면 : 0
  int secondId = 0; //정상 작동 ; 1, 그렇지 않으면 : 0
  String firstAnswer = ""; //페이지에서 보여줘야할 에러/성공 메시지
  String secondAnswer = ""; //페이지에서 보여줘야할 에러/성공 메시지

  void RequestCode(String portalEmail) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["portalEmail"] = portalEmail;
    try {
      Response response = await Dio().post(
          "https://api.kudog.devkor.club/auth/change-password/request",
          data: data);
      if (response.statusCode == 201) {
        firstId = 1;
        firstAnswer = "이메일 전송 성공. 3분 안에 인증 코드를 입력해주세요.";
        print("POST 요청 성공");
      } else if (response.statusCode == 400) {
        firstAnswer = "korea.ac.kr 이메일을 입력하세요.";
      } else if (response.statusCode == 404) {
        firstAnswer = "해당 이메일의 유저가 존재하지 않습니다.";
      } else if (response.statusCode == 429) {
        firstAnswer = "잠시 후에 다시 시도해주세요.";
      } else if (response.statusCode == 510) {
        firstAnswer = "알 수 없는 이유로 메일 전송에 실패했습니다. 잠시 후에 다시 시도해주세요.";
      } else {
        firstAnswer = "알 수 없는 이유로 메일 전송에 실패했습니다. 잠시 후에 다시 시도해주세요.";
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      firstAnswer = "알 수 없는 이유로 메일 전송에 실패했습니다. 잠시 후에 다시 시도해주세요.";
      print("POST 요청 에러");
      print(e.toString());
    }
  }

  void ChangePw(String email, String pw) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["portalEmail"] = email;
    data["password"] = pw;
    try {
      Response response = await Dio().put(
          "https://api.kudog.devkor.club/auth/change-password/request",
          data: data);
      if (response.statusCode == 200) {
        print("PUT 요청 성공");
      } else if (response.statusCode == 400) {
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }
  }

  void VerifyCode(String code) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["code"] = code;
    print(data);
    try {
      Response response = await Dio().post(
          "https://api.kudog.devkor.club/auth/change-password/verify",
          data: data);
      if (response.statusCode == 201) {
        secondId = 1;
        secondAnswer = "인증 성공, 비밀번호를 10분간 변경할 수 있습니다.";
        isVerified = true;
        print("POST 요청 성공");
        print(response);
      } else if (response.statusCode == 400) {
        secondAnswer = "인증 코드가 일치하지 않습니다.";
      } else if (response.statusCode == 408) {
        secondAnswer = "인증 요청 이후 3분이 지났습니다. 다시 메일 전송을 해주세요.";
      } else {
        secondAnswer = "알 수 없는 이유로 메일 전송에 실패했습니다. 잠시 후에 다시 시도해주세요.";
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
      print("답은 : ${secondAnswer}");
    } catch (e) {
      secondAnswer = "알 수 없는 이유로 메일 전송에 실패했습니다. 잠시 후에 다시 시도해주세요.";
      print("POST 요청 에러");
      print(e.toString());
    }
  }
}
