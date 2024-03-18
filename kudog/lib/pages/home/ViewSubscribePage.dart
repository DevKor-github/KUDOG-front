import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/home/FixSubscribePage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
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
      List<String> fullLowerCategoryList =
          categoryService.fullLowerCategoryList;
      isSelected =
          List.generate(fullLowerCategoryList.length, (index) => false);
      Widget buildSubscriptionItem(int id) {
        if (id <= fullLowerCategoryList.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(208),
                color:
                    subIdList.contains(id) ? const Color(0xFFCE4040) : Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: subIdList.contains(id)
                      ? Colors.transparent
                      : const Color(0xFFCDCDCD),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: Text(
                  fullLowerCategoryList[id - 1],
                  style: TextStyle(
                    color: subIdList.contains(id)
                        ? Colors.white
                        : const Color(0xFF696969),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }

      return Scaffold(
        backgroundColor: const Color(0xFFCE4040),
        body: Column(
          children: [
            Container(
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFCE4040),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 88,
                    margin: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/icon_6.png",
                          width: 21.21,
                          height: 21.34,
                          color: Colors.white,
                        ),
                        Image.asset(
                          "assets/images/icon_7.png",
                          width: 36.79,
                          height: 21.34,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '구독',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 88,
                    margin: const EdgeInsets.all(15),
                    child: const ImageIcon(
                      AssetImage(
                        "assets/images/icon_8.png",
                      ),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FixSubscribePageWidget(
                                      lowerCategoryNames: fullLowerCategoryList,
                                      subIdList: subIdList,
                                      unsubIdList: unsubIdList,
                                    ),
                                  ));
                              currentPage = 1;
                            },
                            child: Image.asset(
                              "assets/images/Categoryadd.png",
                              width: 36.79,
                              height: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int id in subIdList)
                                  buildSubscriptionItem(id),
                                for (int id in unsubIdList)
                                  buildSubscriptionItem(id),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: noticeList.isEmpty
                          ? const Column()
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: noticeList.length,
                                    itemBuilder: (context, index) {
                                      return noticeCard(
                                          notice: noticeList[index]);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        totalPage,
                                        (index) => InkWell(
                                          onTap: () => onPageClick(index + 1),
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: currentPage == index + 1
                                                  ? const Color.fromRGBO(
                                                      206, 64, 64, 0.65)
                                                  : const Color(0xFFCDCDCD),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              (index + 1).toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
