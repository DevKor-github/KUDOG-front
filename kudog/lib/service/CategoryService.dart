import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/util/DioClient.dart';

class CategoryService extends ChangeNotifier {
  List<String> upperCategoryList = [];
  List<String> lowerCategoryList = [];
  List<int> lowerCategoryIdList = [];

  List<int> subIdList = [];
  List<int> unsubIdList = [];
  List<String> subNameList = [];
  List<String> fullLowerCategoryList = [];
  List<int> fullList = List.generate(20, (index) => index + 1);

  List<String> majors = [];
  Map<String, List<String>> categories = {};

  void getUpperCategoryList() async {
    upperCategoryList.clear();
    try {
      DioClient dioClient = DioClient();
      Response response = await dioClient.get("/provider");
      for (Map<String, dynamic> item in response.data) {
        UpperCategory upperCategory = UpperCategory.fromJson(item);
        upperCategoryList.add(upperCategory.name!);
      }
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }

  Future<void> getLowerCategoryList(int upperCategoryId) async {
    lowerCategoryList.clear();
    lowerCategoryIdList.clear();
    try {
      DioClient dioClient = DioClient();

      Response response =
          await dioClient.get("/category/by-provider/$upperCategoryId");
      for (Map<String, dynamic> item in response.data) {
        LowerCategory lowerCategory = LowerCategory.fromJson(item);
        lowerCategoryList.add(lowerCategory.name!);
        lowerCategoryIdList.add(lowerCategory.id!);
      }
    } on DioError catch (e) {
      // TODO: 에러 피드백 if (e.response?.statusCode == 404)
    }

    notifyListeners();
  }

  void getFullLowerCategoryList() async {
    fullLowerCategoryList.clear();

    await getLowerCategoryList(1);
    fullLowerCategoryList.addAll(lowerCategoryList);
    await getLowerCategoryList(2);
    fullLowerCategoryList.addAll(lowerCategoryList);
    await getLowerCategoryList(3);
    fullLowerCategoryList.addAll(lowerCategoryList);

    notifyListeners();
  }

  void getSubList() async {
    try {
      DioClient dioClient = DioClient();
      Response response = await dioClient.get("/category/subscribe");
      subIdList.clear();
      subNameList.clear();

      List<Map<String, dynamic>> responseData =
          List<Map<String, dynamic>>.from(response.data);
      for (Map<String, dynamic> item in responseData) {
        subIdList.add(item['id']);
        subNameList.add(item['name']);
      }
      unsubIdList = fullList.where((id) => !subIdList.contains(id)).toList();
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/category/providers",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('GET 요청 성공');

        majors.clear();
        categories.clear();

        response.data.forEach((val) {
          majors.add(val['name']);

          List<dynamic> list = val['categories'];

          categories.putIfAbsent(val['name'], () {
            List<String> list = [];
            val['categories']
                .forEach((category) => {list.add(category['name'] as String)});
            return list;
          });
        });
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getUpperCategoryList(); //다시 수행
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
