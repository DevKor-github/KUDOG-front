import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/home/FixSubscribePage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/home/ViewSubscribeListPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewSubscribePageWidget extends StatefulWidget {
  const ViewSubscribePageWidget({Key? key}) : super(key: key);

  @override
  _ViewSubscribePageWidgetState createState() =>
      _ViewSubscribePageWidgetState();
}

class _ViewSubscribePageWidgetState extends State<ViewSubscribePageWidget> {
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
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '관심있는 소식만 빠르게 모아보세요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                      onPressed: () => {},
                      child: Text(
                        '편집',
                        style: TextStyle(color: Color(0xFFFF4F59)),
                      ))
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Expanded(
                  child: Column(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewSubscribeListPageWidget()));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage("assets/images/artboard.png"),
                            ),
                            Icon(Icons.settings_rounded)
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "디조짱",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                  margin: EdgeInsets.only(right: 4),
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  height: 26,
                                  child: Text('컴퓨터학부',
                                      style: TextStyle(
                                          color: Color(0xFFFF3B47),
                                          fontWeight: FontWeight.w500)),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Color(0xFFFFD8DA)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      color: Color(0xFFFFFFFF))),
                            ),
                            Flexible(
                              child: Container(
                                  margin: EdgeInsets.only(right: 4),
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  height: 26,
                                  child: Text('디자인조형학부',
                                      style: TextStyle(
                                          color: Color(0xFFFF3B47),
                                          fontWeight: FontWeight.w500)),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      color: Color(0x80FF3B47))),
                            ),
                          ],
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Color(0xffF4F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton.icon(
                      icon: Icon(Icons.create_new_folder_outlined),
                      label: Text('구독함 추가'),
                      onPressed: () => {},
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                              color: Color(0xFF787474),
                              width: 1.0,
                              style: BorderStyle.solid)))),
                )
              ])),
            ],
          ),
        ),
      );
    });
  }
}
