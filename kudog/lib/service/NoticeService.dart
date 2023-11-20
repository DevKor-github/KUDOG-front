import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';

class NoticeService extends ChangeNotifier {
  NoticeDetail noticeDetail = NoticeDetail(); //가져오는 공지 - id로 인덱싱(API 호출)
  List<Notice> noticeList = []; //가져오는 모든 공지

  void getAllNotices(int page) async {
    try {
      Response response = await Dio().get(
        "http://54.180.85.164:3050/notice/list/bydate?page=${page}",
      );

      if (response.statusCode == 200) {
        print("GET 요청 성공");
        for (Map<String, dynamic> item in response.data) {
          Notice notice = Notice.fromJson(item);
          noticeList.add(notice);
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

  Future<void> getNotice(int id) async {
    try {
      Response response = await Dio().get(
        "http://54.180.85.164:3050/notice/info/${id}",
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
}
