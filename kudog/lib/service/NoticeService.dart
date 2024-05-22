import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudog/etc/TempToken.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/model/ScrapModel.dart';
import 'package:kudog/model/SubscribeListModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeService extends ChangeNotifier {
  NoticeList noticeList = NoticeList();
  NoticeDetail noticeDetail = NoticeDetail();
  List<Subscribe> subscribeList = List.empty();
  ScrapList scrapList = ScrapList();
  Future<void> getAllNotices(Filter filter) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&pageSize=10",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        noticeList = NoticeList.fromJson(response.data, key: 'records');
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

  Future<void> getFilteredNotices(Filter filter) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");
      String _categories = filter.categories!.join(",");
      String _providers = filter.providers!.join(",");
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?categories=$_categories&providers=$_providers&start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&keyword=${filter.keyword}",
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

  Future<void> getProviderNotices(Filter filter) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");
      String _providers = filter.providers!.join(",");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?&providers=$_providers&start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}",
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

  Future<void> getCategoryNotices(Filter filter) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");
      String _categories = filter.categories!.join(",");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?&categories=$_categories&start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}",
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

  Future<void> getSearchedNotices(Filter filter) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&keyword=${filter.keyword}",
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

  Future<void> getSubscribedNotices(int boxId, DateTime date) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      String dateFormat = DateFormat('yyyy-MM-dd').format(date);

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/subscribe/box/${boxId}?date=${dateFormat}",
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

  void addSubscribedNotices(int page) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?page=$page",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        //subscribeList.addFromJson(response.data);
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
        addSubscribedNotices(page);
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

  Future<void> getSubscribes() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/subscribe/box?page=1&pageSize=10",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");

        subscribeList = List<Subscribe>.empty(growable: true);

        for (Map<String, dynamic> item in response.data['records']) {
          subscribeList.add(Subscribe.fromJson(item));
        }
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
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

  Future<void> addSubscribes(name, email, provider, categories) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      String sendTime = DateFormat.Hm().format(DateTime.now());
      Response response = await Dio().post(
        "https://api.kudog.devkor.club/subscribe/box",
        data: {
          'name': name,
          'email': email,
          'provider': provider,
          'categories': categories,
          'sendTime': sendTime
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 && response.data != null) {
        print("POST 요청 성공");
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> editSubscribes(boxId, name, email, provider, categories) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      String sendTime = DateFormat.Hm().format(DateTime.now());

      print({
        'name': name,
        'email': email,
        'provider': provider,
        'categories': categories,
        'sendTime': sendTime,
        'boxid': boxId
      });
      Response response = await Dio().put(
        "https://api.kudog.devkor.club/subscribe/box/${boxId}",
        data: {
          'name': name,
          'email': email,
          'provider': provider,
          'categories': categories,
          'sendTime': sendTime
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("PUT 요청 성공");
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteSubscribes(List<int> subscribeIdList) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      for (int i = 0; i < subscribeIdList.length; i++) {
        Response response = await Dio().delete(
          "https://api.kudog.devkor.club/subscribe/box/${subscribeIdList[i]}",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200) {
          print("DELETE 요청 성공");
        } else if (response.statusCode == 401) {
          print("ACCESS_TOKEN 만료");
          TokenService().refreshToken();
        } else {
          print("DELETE 요청 실패");
          print("Status Code : ${response.statusCode}");
        }
      }
    } catch (e) {
      print("DELETE 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> getScraps() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/scrap/box?page=1&pageSize=10",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        scrapList = ScrapList.fromJson(response.data, key: 'records');
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
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

  Future<void> addScrap(name, description) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().post(
        "https://api.kudog.devkor.club/scrap/box",
        data: {
          'name': name,
          'description': description,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 && response.data != null) {
        print("POST 요청 성공");
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> editScrap(boxId, name, description) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().put(
        "https://api.kudog.devkor.club/scrap/box/${boxId}",
        data: {
          'name': name,
          'description': description,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("PUT 요청 성공");
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteScraps(List<int> scrapIdList) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      for (int i = 0; i < scrapIdList.length; i++) {
        Response response = await Dio().delete(
          "https://api.kudog.devkor.club/scrap/box/${scrapIdList[i]}",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200) {
          print("DELETE 요청 성공");
        } else if (response.statusCode == 401) {
          print("ACCESS_TOKEN 만료");
          TokenService().refreshToken();
        } else {
          print("DELETE 요청 실패");
          print("Status Code : ${response.statusCode}");
        }
      }
    } catch (e) {
      print("DELETE 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> getScrappedNotices(int boxId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/scrap/box/${boxId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        noticeList = NoticeList.fromJson(response.data, key: 'notices');
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
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

  Future<void> addToScrap(int noticeId, int scrapBoxId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().put(
        "https://api.kudog.devkor.club/notice/${noticeId}/scrap/${scrapBoxId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("PUT 요청 성공");
      } else if (response.statusCode == 401) {
        print("ACCESS_TOKEN 만료");
        TokenService().refreshToken();
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }
}
