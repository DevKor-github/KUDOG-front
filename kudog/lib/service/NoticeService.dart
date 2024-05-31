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
  NoticeList _mainNoticeList = NoticeList();

  List<MajorCategory> bookmarkMajorCategoryList = [];
  NoticeList get mainNoticeList {
    return _mainNoticeList;
  }

  NoticeList _scrapNoticeList = NoticeList();
  NoticeList get scrapNoticeList {
    return _scrapNoticeList;
  }

  NoticeList _subscribeNoticeList = NoticeList();
  NoticeList get subscribeNoticeList {
    return _subscribeNoticeList;
  }

  Map<int, Notice> _noticeMap = Map();
  Notice? noticeInfo(int noticeId) {
    if (_noticeMap.containsKey(noticeId)) return _noticeMap[noticeId]!;
    return null;
  }

  void _addNoticeMap(dynamic json, {String key = 'notices'}) {
    json[key].forEach((val) {
      Notice notice = Notice.fromJson(val);
      _noticeMap.putIfAbsent(notice.id, () => notice);
    });
  }

  void _setNoticeScrapped(String result, int noticeId, int scrapBoxId) {
    if (result == 'true') {
      _noticeMap[noticeId]!.scrapped = true;
      _noticeMap[noticeId]!.scrapBoxId.add(scrapBoxId);
    } else if (result == 'false') {
      _noticeMap[noticeId]!.scrapBoxId.remove(scrapBoxId);
      if (_noticeMap[noticeId]!.scrapBoxId.isEmpty)
        _noticeMap[noticeId]!.scrapped = false;
    }
  }

  NoticeDetail noticeDetail = NoticeDetail();

  List<Subscribe> _subscribeList = List.empty();
  List<Subscribe> get subscribeList {
    return _subscribeList;
  }

  ScrapList _scrapList = ScrapList();
  ScrapList get scrapList {
    return _scrapList;
  }

  List<String> _providers = [];
  Map<String, List<String>> _categories = {};
  List<String> get providers {
    return _providers;
  }

  Map<String, List<String>> get categories {
    return _categories;
  }

  //모든 공지사항을 가져옵니다.
  Future<void> getAllNotices(Filter filter, {bool add = false}) async {
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
        if (add) {
          _mainNoticeList.addFromJson(response.data, key: 'records');
        } else
          _mainNoticeList = NoticeList.fromJson(response.data, key: 'records');
        _addNoticeMap(response.data, key: 'records');
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

  //학과와 카테고리 필터가 적용된 공지사항을 가져옵니다.
  Future<void> getFilteredNotices(Filter filter, {bool add = false}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");
      String _categories = filter.categories!.join(",");
      String _providers = filter.providers!.join(",");
      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?categories=$_categories&providers=$_providers&start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&pageSize=${filter.pageSize}&keyword=${filter.keyword}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        if (add)
          _mainNoticeList.addFromJson(response.data, key: 'records');
        else
          _mainNoticeList = NoticeList.fromJson(response.data, key: 'records');
        _addNoticeMap(response.data, key: 'records');
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

  //해당 학과의 공지사항만 가져옵니다.
  Future<void> getProviderNotices(Filter filter, {bool add = false}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");
      String _providers = filter.providers!.join(",");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?&providers=$_providers&start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&pageSize=${filter.pageSize}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        if (add)
          _mainNoticeList.addFromJson(response.data, key: 'records');
        else
          _mainNoticeList = NoticeList.fromJson(response.data, key: 'records');
        _addNoticeMap(response.data, key: 'records');
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

  //카테고리가 적용된 공지사항을 가져옵니다.
  Future<void> getCategoryNotices(Filter filter, {bool add = false}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");
      String _categories = filter.categories!.join(",");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?&categories=$_categories&start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&pageSize=${filter.pageSize}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        if (add)
          _mainNoticeList.addFromJson(response.data);
        else
          _mainNoticeList = NoticeList.fromJson(response.data);
        _addNoticeMap(response.data);
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

  //키워드로 검색한 공지사항을 가져옵니다.
  Future<void> getSearchedNotices(Filter filter, {bool add = false}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/notice/list?start_date=${filter.startDate}&end_date=${filter.endDate}&page=${filter.page}&pageSize=${filter.pageSize}&keyword=${filter.keyword}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        if (add)
          _mainNoticeList.addFromJson(response.data, key: 'records');
        else
          _mainNoticeList = NoticeList.fromJson(response.data, key: 'records');
        _addNoticeMap(response.data, key: 'records');
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

  //단일 notice와 그 세부사항을 가져옵니다
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

  //해당 id를 가진 구독함의 공지사항들을 가져옵니다.
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
        _subscribeNoticeList = NoticeList.fromJson(response.data);
        _addNoticeMap(response.data);
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

  //구독 리스트를 가져옵니다.
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

        _subscribeList = List<Subscribe>.empty(growable: true);

        for (Map<String, dynamic> item in response.data['records']) {
          _subscribeList.add(Subscribe.fromJson(item));
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

  //구독함을 추가합니다.
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
        _subscribeList.add(Subscribe(
            name: name,
            email: email,
            provider: provider,
            id: response.data['id'],
            categories: categories));
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

  //기존의 구독함 정보를 수정합니다.
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
        int idx = _subscribeList.indexWhere((element) => element.id == boxId);
        _subscribeList[idx] = Subscribe(
            name: name,
            email: email,
            provider: provider,
            id: boxId,
            categories: List<String>.from(categories));
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

  //기존의 구독함을 삭제합니다.
  Future<void> deleteSubscribes(List<int> subscribeIdList) async {
    bool result = true;
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
          result = false;
        } else {
          print("DELETE 요청 실패");
          print("Status Code : ${response.statusCode}");
          result = false;
        }
      }

      if (result) {
        Set<int> set = subscribeIdList.toSet();
        _subscribeList.removeWhere((element) {
          return set.contains(element.id);
        });
      }
    } catch (e) {
      print("DELETE 요청 에러");
      print(e.toString());
    }

    notifyListeners();
  }

  //스크랩 리스트를 가져옵니다.
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
        _scrapList = ScrapList.fromJson(response.data, key: 'records');
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

  //새 스크랩함을 추가합니다.
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
        _scrapList.scraps.add(Scrap(
            name: name,
            description: description,
            id: response.data['id'],
            noticeCount: 0));
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

  //기존의 스크랩함을 수정합니다.
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
        int idx =
            _scrapList.scraps.indexWhere((element) => element.id == boxId);
        _scrapList.scraps[idx] = Scrap(
            name: name,
            description: description,
            id: boxId,
            noticeCount: _scrapList.scraps[idx].noticeCount);
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

  //기존의 스크랩함을 삭제합니다.
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
          Set<int> set = scrapIdList.toSet();
          _scrapList.scraps.removeWhere((element) {
            return set.contains(element.id);
          });
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

  //해당 id의 스크랩 박스에 들어있는 모든 공지사항을 가져옵니다.
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
        _scrapNoticeList = NoticeList.fromJson(response.data, key: 'notices');
        _addNoticeMap(response.data);
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

  //스크랩 박스로 공지사항을 보관합니다. (또는 이미 보관중인 공지사항을 제거)
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
        _setNoticeScrapped(response.data, noticeId, scrapBoxId);
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

  Future<void> getBookmarkProvider() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      Response response = await Dio().get(
        "https://api.kudog.devkor.club/category/providers/bookmarks",
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
          bookmarkMajorCategoryList.add(MajorCategory.fromJson(item));
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
}
