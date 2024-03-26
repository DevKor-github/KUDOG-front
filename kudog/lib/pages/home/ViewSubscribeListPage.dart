import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/home/FixSubscribePage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewSubscribeListPageWidget extends StatefulWidget {
  const ViewSubscribeListPageWidget({Key? key}) : super(key: key);

  @override
  _ViewSubscribeListPageWidgetState createState() =>
      _ViewSubscribeListPageWidgetState();
}

class _ViewSubscribeListPageWidgetState
    extends State<ViewSubscribeListPageWidget> {
  late List<bool> isSelected;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> iconStates = [false, false, false];
  late Dio dio;
  List<Notice> noticeList = [];
  int currentPage = 1;

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

  @override
  void initState() {
    super.initState();
    dio = Dio();
    Provider.of<CategoryService>(context, listen: false).getUpperCategoryList();
    Provider.of<CategoryService>(context, listen: false)
        .getFullLowerCategoryList();
    Provider.of<CategoryService>(context, listen: false).getSubList();
    Provider.of<NoticeService>(context, listen: false)
        .getSubscribedNotices(currentPage);
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  void onPageClick(int page) {
    setState(() {
      currentPage = page;
    });
    Provider.of<NoticeService>(context, listen: false)
        .getSubscribedNotices(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryService, NoticeService>(
        builder: (context, categoryService, noticeService, child) {
      noticeList = noticeService.subscribedNoticeList.notices!;
      int totalPage = noticeService.subscribedNoticeList.totalPage ?? 1;
      List<int> subIdList = categoryService.subIdList;
      List<int> unsubIdList = categoryService.unsubIdList;
      List<String> subNameList = categoryService.subNameList;
      List<String> fullLowerCategoryList =
          categoryService.fullLowerCategoryList;
      isSelected =
          List.generate(fullLowerCategoryList.length, (index) => false);
      Widget _buildSubscriptionItem(int id) {
        if (id <= fullLowerCategoryList.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(208),
                color:
                    subIdList.contains(id) ? Color(0xFFCE4040) : Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: subIdList.contains(id)
                      ? Colors.transparent
                      : Color(0xFFCDCDCD),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: Text(
                  fullLowerCategoryList[id - 1],
                  style: TextStyle(
                    color: subIdList.contains(id)
                        ? Colors.white
                        : Color(0xFF696969),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }

      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              SizedBox(
                height: 28,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => {},
                      child: Row(children: [
                        Text('구독함 A',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000))),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Color(0xFF000000),
                        )
                      ])),
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.settings_rounded),
                  )
                ],
              ),
              SizedBox(
                height: 27,
              ),
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Color(0xFFF4F2F2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        iconSize: 24,
                        onPressed: () => {},
                        icon: Icon(Icons.chevron_left_rounded)),
                    Text(
                      "2021.10.11",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                        onPressed: () => {},
                        icon: Icon(Icons.chevron_right_rounded))
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Expanded(
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: noticeList.length,
                      itemBuilder: (context, index) {
                        return noticeCard(notice: noticeList[index]);
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              totalPage,
                              (index) => InkWell(
                                onTap: () => onPageClick(index + 1),
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: currentPage == index + 1
                                        ? Color.fromRGBO(206, 64, 64, 0.65)
                                        : Color(0xFFCDCDCD),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )))
                ]),
              ),
            ],
          ),
        ),
      );
    });
  }
}
