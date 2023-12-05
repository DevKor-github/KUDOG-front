import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/AuthModel.dart';

class SignUpService extends ChangeNotifier {
  bool isSend = false;
  String firstAnswer = "";
  int firstId = 0; //정상작동 : 1, 그렇지 않으면 : 0
  int secondId = 0;
  String secondAnswer = "";
  Future<void> SignUp(SignUpUser user) async {
    Map<String, dynamic> data = user.toJson();
    try {
      Response response = await Dio()
          .post("https://api.kudog.devkor.club/auth/signup", data: data);
      if (response.statusCode == 201) {
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

  Future<void> SendEmail(String address) async {
    // Map<String, dynamic> data = mail.toJson();
    print(address);
    try {
      Response response = await Dio().post(
          "https://api.kudog.devkor.club/mail/verify/send",
          data: {"email": address});
      if (response.statusCode == 201) {
        isSend = true;
        firstId = 1;
        firstAnswer = "ⓘ 인증번호를 발송했습니다.";
        print("POST 요청 성공");
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          firstAnswer = "korea.ac.kr형식의 이메일을 입력하세요.";
          print(e.response!.statusCode);
          print("POST 요청 실패");
        } else if (e.response!.statusCode == 409) {
          firstAnswer = "ⓘ 사용 중인 이메일입니다.";
          print(e.response!.statusCode);
          print("POST 요청 실패");
        } else if (e.response!.statusCode == 429) {
          firstAnswer = "ⓘ 잠시 후 요청하시기 바랍니다.";
          print(e.response!.statusCode);
          print("POST 요청 실패");
        } else {
          firstAnswer = "ⓘ 잠시 후 요청하시기 바랍니다.";
          print(e.response!.statusCode);
          print("POST 요청 실패");
          print("Status Code : ${e.response!.statusCode}");
        }
      }
    }
  }

  void VerifyEmail(String address, String code) async {
    try {
      Response response = await Dio().post(
          "https://api.kudog.devkor.club/mail/verify/check",
          data: {"email": address, "code": code});
      if (response.statusCode == 200) {
        print("POST 요청 성공");
        secondId = 1;
        secondAnswer = "ⓘ 인증되었습니다.";
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          secondAnswer = "ⓘ 인증 번호가 틀립니다.";
          print("POST 요청 실패");
        } else if (e.response!.statusCode == 404) {
          secondAnswer = "ⓘ 해당 메일이 존재하지 않습니다.";
          print("POST 요청 실패");
        } else if (e.response!.statusCode == 408) {
          secondAnswer = "ⓘ 다시 번호를 요청하세요.";
          print("POST 요청 실패");
        } else if (e.response!.statusCode == 409) {
          secondAnswer = "ⓘ 이미 인증된 이메일입니다.";
          print("POST 요청 실패");
        } else {
          secondAnswer = "ⓘ 잠시 후 시도해주세요.";
          print("POST 요청 실패");
          print("Status Code : ${e.response!.statusCode}");
        }
      }
      secondAnswer = "ⓘ 잠시 후 시도해주세요.";
      print("POST 요청 에러");
      print(e.toString());
    }
  }
}
