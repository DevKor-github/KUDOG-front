import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/util/DioClient.dart';
import 'package:provider/provider.dart';
import 'package:kudog/model/UserModel.dart';

class FixSubscribePageWidget extends StatefulWidget {
  final List<String> lowerCategoryNames;
  final List<int> subIdList;
  final List<int> unsubIdList;

  const FixSubscribePageWidget({
    Key? key,
    required this.lowerCategoryNames,
    required this.subIdList,
    required this.unsubIdList,
  }) : super(key: key);

  @override
  _FixSubscribePageWidgetState createState() => _FixSubscribePageWidgetState();
}

class _FixSubscribePageWidgetState extends State<FixSubscribePageWidget> {
  late List<bool> isSelected;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> iconStates = [false, false, false];
  late Dio dio;
  List<String> upperCategories = ["전체"];
  List<String> lowerCategories = [];
  List<int> lowerCategoryIds = [];

  late String subscribeEmail;
  TextEditingController subscribeEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.lowerCategoryNames.length, (index) {
      int categoryId = index + 1;
      return widget.subIdList.contains(categoryId);
    });
    dio = Dio();
    Provider.of<CategoryService>(context, listen: false).getUpperCategoryList();
    Provider.of<UserInfoService>(context, listen: false).getUserInfo();
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  void changeSubscription(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  Widget _buildSubscriptionButton(int index) {
    String buttonText = widget.lowerCategoryNames[index];

    return Container(
      child: ElevatedButton(
        onPressed: () => changeSubscription(index),
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: isSelected[index]
                ? Colors.transparent
                : const Color(0xFFCDCDCD),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(208),
          ),
          backgroundColor: isSelected[index]
              ? const Color.fromRGBO(206, 64, 64, 0.65)
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            buttonText,
            style: TextStyle(
              color: isSelected[index] ? Colors.white : const Color(0xFF696969),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveChanges() async {
    List<int> subscribeIds = [];
    List<int> unsubscribeIds = [];

    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        int categoryId = i + 1;
        if (!widget.subIdList.contains(categoryId)) {
          subscribeIds.add(categoryId);
        }
      } else {
        int categoryId2 = i + 1;
        if (!widget.unsubIdList.contains(categoryId2)) {
          unsubscribeIds.add(categoryId2);
        }
      }
    }
    Map<String, dynamic> requestBody = {
      "subscribeIds": subscribeIds,
      "unsubscribeIds": unsubscribeIds,
    };

    try {
      DioClient dioClient = DioClient();
      Response response = await dioClient.put(
        "/category/subscribe",
        data: requestBody,
      );
    } on DioError catch (e) {
      //TODO: 에러피드백
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
    return Consumer<UserInfoService>(
        builder: (context, userInfoservice, child) {
      User userInfo = userInfoservice.user;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(55, 12, 0, 0),
                      child: Text(
                        '구독용 이메일',
                        style: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF7E7E7E),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                      padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFCDCDCD),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        userInfo.subscriberEmail ?? '',
                        style: const TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F5F5),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                alignment: WrapAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < widget.lowerCategoryNames.length;
                                      i++)
                                    _buildSubscriptionButton(i),
                                ],
                              ),
                            ),
                            Container(
                              width: 167,
                              height: 47,
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  saveChanges();
                                  Navigator.pop(context);
                                  Provider.of<CategoryService>(context,
                                          listen: false)
                                      .getUpperCategoryList();
                                  Provider.of<CategoryService>(context,
                                          listen: false)
                                      .getFullLowerCategoryList();
                                  Provider.of<CategoryService>(context,
                                          listen: false)
                                      .getSubList();
                                  Provider.of<NoticeService>(context,
                                          listen: false)
                                      .getSubscribedNotices(1);
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 2.0,
                                    color: Color(0xFFCE4040),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(58),
                                  ),
                                  backgroundColor: const Color(0xFFF5F5F5),
                                ),
                                child: const Text(
                                  "변경사항 저장",
                                  style: TextStyle(
                                    color: Color(0xFFCE4040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
