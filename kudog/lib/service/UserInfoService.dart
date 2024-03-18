import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/UserModel.dart';
import 'package:kudog/util/DioClient.dart';

class UserInfoService extends ChangeNotifier {
  User user = User(
    name: "",
  );

  void getUserInfo() async {
    try {
      DioClient dioClient = DioClient();
      Response response = await dioClient.get("/users/info");

      user = User.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백 if (e.response?.statusCode == 404)
    }

    notifyListeners();
  }
}
