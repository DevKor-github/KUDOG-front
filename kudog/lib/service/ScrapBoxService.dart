import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/ScrapBoxModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScrapBoxService extends ChangeNotifier {
  List<ScrapBox> scrapBoxes = [];
  Future<void> getScrapBoxes() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/scrap/box",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        for (Map<String, dynamic> item in response.data) {
          print(ScrapBox.fromJson(item));
          scrapBoxes.add(ScrapBox.fromJson(item));
        }
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
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
