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
  Future<void> getUpperCategoryList() async {
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
}
