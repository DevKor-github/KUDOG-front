import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeService extends ChangeNotifier {
  NoticeDetail noticeDetail = NoticeDetail();
  NoticeList noticeList = NoticeList(notices: []);
  NoticeList scrappedNoticeList = NoticeList(notices: []);
  SelectedNoticeList selectedNoticeList = SelectedNoticeList(notices: []);

  void getAllNotices() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/bydate",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        noticeList = NoticeList.fromJson(response.data);
        print(noticeList.notices);
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

  Future<void> getNotice(int id) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/info/${id}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("GET 요청 성공");
        noticeDetail = NoticeDetail.fromJson(response.data);
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

  void getUpperCategoryNotice(int page, int upperCategoryId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/provider/$upperCategoryId/bydate?page=$page",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        selectedNoticeList = SelectedNoticeList.fromJson(response.data);
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

  void getScrappedNotices(int page) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/scrap",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        scrappedNoticeList = NoticeList.fromJson(response.data);
        print(noticeList.notices);
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

  Future<bool> scrapNotice(int noticeId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().put(
        "https://api.kudog.devkor.club/notice/scrap/$noticeId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        return response.data;
      } else {
        print("GET 요청 실패");
        print("Status Code : ${response.statusCode}");
        throw Exception;
      }
    } catch (e) {
      print("GET 요청 에러");
      print(e.toString());
      throw Exception;
    }
  }
}
