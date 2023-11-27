import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService extends ChangeNotifier {
  List<String> upperCategoryList = [];
  List<String> lowerCategoryList = [];
  List<int> lowerCategoryIdList = [];
  void getUpperCategoryList() async {
    upperCategoryList.clear();
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/provider",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      for (Map<String, dynamic> item in response.data) {
        UpperCategory upperCategory = UpperCategory.fromJson(item);
        upperCategoryList.add(upperCategory.name!);
      }

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        print(response.data);
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

  void getLowerCategoryList(int upperCategoryId) async {
    lowerCategoryList.clear();
    lowerCategoryIdList.clear();
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/category/by-provider/$upperCategoryId",
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
          LowerCategory lowerCategory = LowerCategory.fromJson(item);
          lowerCategoryList.add(lowerCategory.name!);
          lowerCategoryIdList.add(lowerCategory.id!);
        }
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
