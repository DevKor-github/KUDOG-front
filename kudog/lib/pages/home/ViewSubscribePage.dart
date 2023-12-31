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
  List<int> subscribeIds = [1, 3, 5]; // 서버로 받아올 거임.
  //List<int> subscribeIds = [];
  List<int> unsubscribeIds = [2, 4, 6];
  //List<int> unsubscribeIds = [];
  late List<Notice> noticeList;

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(subscriptionButtonText.length, (index) => false);
    dio = Dio();
    Provider.of<NoticeService>(context, listen: false).getAllNotices();
    Provider.of<NoticeService>(context, listen: false)
        .getUpperCategoryNotice(1, 0);
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  Future<void> saveChanges() async {
    List<int> subscribeIds = [1, 3, 5]; // 서버로 받아올 거임.
    //List<int> subscribeIds = [];
    List<int> unsubscribeIds = [];

    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        subscribeIds.add(i + 1);
      } else {
        unsubscribeIds.add(i + 1);
      }
    }

    List<String> sortedCategories = [];
    subscribeIds.forEach((id) {
      sortedCategories.add(subscriptionButtonText[id - 1]);
    });

    unsubscribeIds.forEach((id) {
      sortedCategories.add(subscriptionButtonText[id - 1]);
    });

    Map<String, dynamic> requestBody = {
      "subscribeIds": subscribeIds,
      "unsubscribeIds": unsubscribeIds,
    };
    print("requestBody: $requestBody");

    try {
      Response response = await dio.put(
        "https://api.kudog.devkor.club/category/subscribe",
        data: requestBody,
      );

      // Handle the response if needed
      print(response.data);
    } catch (error) {
      // Handle the error
      print(error);
    }
  }

  List<String> subscriptionButtonText = [
    "KUPID 전체 ㅇㅇㅇ",
    "학사일정",
    "장학금",
    "무슨무슨 학부",
    "경영대학",
    "무슨학부ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryService, NoticeService>(
        builder: (context, categoryService, noticeService, child) {
      noticeList = noticeService.selectedNoticeList.notices!;
      List<Notice> filteredNoticeList = noticeList
          .where((notice) => subscribeIds.contains(notice.id))
          .toList();

      return Scaffold(
        backgroundColor: Color(0xFFCE4040),
        body: Column(
          children: [
            Container(
              height: 64,
              decoration: BoxDecoration(
                color: Color(0xFFCE4040),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 88,
                    margin: EdgeInsets.all(15),
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
                  Text(
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
                    margin: EdgeInsets.all(15),
                    child: ImageIcon(
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
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: ShapeDecoration(
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
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FixSubscribePageWidget(),
                                  ));
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
                                for (int id in subscribeIds)
                                  _buildSubscriptionItem(id),
                                for (int id in unsubscribeIds)
                                  _buildSubscriptionItem(id),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: filteredNoticeList.length == 0
                            ? Column()
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: filteredNoticeList.length,
                                itemBuilder: (context, index) {
                                  print(filteredNoticeList[index].title!);
                                  return noticeCard(notice: noticeList[index]);
                                },
                              ))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSubscriptionItem(int id) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(208),
          color: subscribeIds.contains(id) ? Color(0xFFCE4040) : Colors.white,
          border: Border.all(
            width: 1.0,
            color: subscribeIds.contains(id)
                ? Colors.transparent
                : Color(0xFFCDCDCD),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
          child: Text(
            subscriptionButtonText[id - 1],
            style: TextStyle(
              color:
                  subscribeIds.contains(id) ? Colors.white : Color(0xFF696969),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
