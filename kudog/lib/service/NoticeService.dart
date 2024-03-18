import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/util/DioClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeService extends ChangeNotifier {
  NoticeDetail noticeDetail = NoticeDetail();
  NoticeList noticeList = NoticeList(notices: []); // 현재 화면에 보여지는 notice 전달
  ScrappedNoticeList scrappedNoticeList = ScrappedNoticeList(notices: []);
  SelectedNoticeList selectedNoticeList = SelectedNoticeList(notices: []);
  SearchedNoticeList searchedNoticeList = SearchedNoticeList(notices: []);
  SelectedNoticeList subscribedNoticeList = SelectedNoticeList(notices: []);
  Future<void> getAllNotices(int page) async {
    try {
      DioClient dioClient = DioClient();

      Response response = await dioClient.get("/notice/list/bydate?page=$page");
      noticeList = NoticeList.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }

  Future<void> getNotice(int id) async {
    try {
      DioClient dioClient = DioClient();

      Response response = await dioClient.get("/notice/info/$id");
      noticeDetail = NoticeDetail.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }
    notifyListeners();
  }

  Future<void> getUpperCategoryNotice(int page, int upperCategoryId) async {
    try {
      DioClient dioClient = DioClient();

      Response response = await dioClient
          .get("/notice/list/provider/$upperCategoryId/bydate?page=$page");
      selectedNoticeList = SelectedNoticeList.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }

  Future<void> getLowerCategoryNotice(int page, int lowerCategoryId) async {
    try {
      DioClient dioClient = DioClient();

      Response response = await dioClient
          .get("/notice/list/$lowerCategoryId/bydate?page=$page");

      selectedNoticeList = SelectedNoticeList.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }

  Future<void> getScrappedNotices() async {
    try {
      DioClient dioClient = DioClient();

      Response response = await dioClient.get("/notice/list/scrap");

      selectedNoticeList = SelectedNoticeList.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }

  Future<String> scrapNotice(int noticeId) async {
    try {
      DioClient dioClient = DioClient();

      Response<String> response =
          await dioClient.put("/notice/scrap/$noticeId");
      String? result = response.data;
      if (result == null) throw Exception();

      return result;
    } on DioError catch (e) {
      // TODO: 에러 피드백
      return 'false';
    }
  }

  Future<void> searchNotices(String keyword) async {
    try {
      DioClient dioClient = DioClient();

      Response response =
          await dioClient.get("/notice/list/search?keyword=$keyword");
      searchedNoticeList = SearchedNoticeList.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }
  }

  Future<void> getSubscribedNotices(int page) async {
    try {
      DioClient dioClient = DioClient();

      Response response =
          await dioClient.get("/notice/list/subscribe-categories?page=$page");
      subscribedNoticeList = SelectedNoticeList.fromJson(response.data);
    } on DioError catch (e) {
      // TODO: 에러 피드백
    }

    notifyListeners();
  }
}
