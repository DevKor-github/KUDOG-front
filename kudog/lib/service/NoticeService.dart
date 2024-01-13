import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeService extends ChangeNotifier {
  NoticeDetail noticeDetail = NoticeDetail();
  NoticeList noticeList = NoticeList(notices: []); // 현재 화면에 보여지는 notice 전달
  NoticeList scrappedNoticeList = NoticeList(notices: []);
  SelectedNoticeList selectedNoticeList = SelectedNoticeList(notices: []);
  NoticeList searchedNoticeList = NoticeList(notices: []);
  SelectedNoticeList subscribedNoticeList = SelectedNoticeList(notices: []);
  void getAllNotices(int page) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/bydate?page=$page",
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
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getAllNotices(1);
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

  void getNotice(int id) async {
    //단일 notice 가져오기
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
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getNotice(id);
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
    //상위 카테고리에 맞는 notice 가져오기
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
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getUpperCategoryNotice(page, upperCategoryId);
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

  void getLowerCategoryNotice(int page, int lowerCategoryId) async {
    //하위 카테고리에 맞는 notice 가져오기
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/$lowerCategoryId/bydate?page=$page",
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
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getLowerCategoryNotice(page, lowerCategoryId);
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
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getScrappedNotices(page);
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

  Future<String> scrapNotice(int noticeId) async {
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
        print("PUT 요청 성공");
        return response.data;
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
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
        return response.data;
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
        throw Exception;
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
      throw Exception;
    }
  }

  void searchNotices(String keyword) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/search?keyword=$keyword",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        searchedNoticeList = NoticeList.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        searchNotices(keyword);
      } else {
        print("GET 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("GET 요청 에러");
      print(e.toString());
    }
  }

  void getSubscribedNotices(int page) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list/subscribe-categories?page=$page",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        subscribedNoticeList = SelectedNoticeList.fromJson(response.data);
        print(subscribedNoticeList);
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        getSubscribedNotices(page);
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
