import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kudog/model/ScrapBoxModel.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/ScrapBoxService.dart';
import 'package:kudog/service/SignOutService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:kudog/service/WithdrawalService.dart';
import 'package:provider/provider.dart';

class ViewMyPageWidget extends StatefulWidget {
  const ViewMyPageWidget({Key? key}) : super(key: key);

  @override
  _ViewMyPageWidgetState createState() => _ViewMyPageWidgetState();
}

class _ViewMyPageWidgetState extends State<ViewMyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> bookmarkMajors = ["컴퓨터학과", "디자인조형학부", "미디어학부"];
  String userName = '';
  int subscribeCount = 0;
  int scrapCount = 0;
  @override
  void initState() {
    super.initState();
    loadUserInfo();
    loadSubscribeCount();
  }

  Future<void> loadUserInfo() async {
    await Provider.of<UserInfoService>(context, listen: false).getUserInfo();
    setState(() {
      userName =
          Provider.of<UserInfoService>(context, listen: false).user.name!;
    });
  }

  Future<void> loadSubscribeCount() async {
    await Provider.of<NoticeService>(context, listen: false).getSubscribes();
    setState(() {
      subscribeCount = Provider.of<NoticeService>(context, listen: false)
          .subscribeList
          .length;
    });
  }

  Future<void> loadScrapCount() async {
    await Provider.of<ScrapBoxService>(context, listen: false).getScrapBoxes();
    setState(() {
      List<ScrapBox> scrapBoxes =
          Provider.of<ScrapBoxService>(context, listen: false).scrapBoxes;
      for (int i = 0; i < scrapBoxes.length; i++) {
        scrapCount += scrapBoxes[i].noticeCount!;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignOutService, WithdrawalService>(
        builder: (context, signOutService, withdrawalService, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Color(0xA5F9F8F8),
                  Color(0xBAF2F1F1),
                  Color(0xFFE1E1E1),
                  Color(0xFFE1E1E1)
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("마이페이지",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                          Container(width: 20)
                        ],
                      )),
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 26),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0C8B8B8B),
                                      blurRadius: 10,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Image.asset(
                                            "assets/images/my_post_icon.png")),
                                    Container(
                                        width: 300,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                child: Text(
                                                  userName,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF1B1616),
                                                    fontSize: 18,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.08,
                                                  ),
                                                )),
                                            Container(
                                              child: Text(
                                                "구독함   ${subscribeCount} | 스크랩  ${scrapCount}",
                                                style: TextStyle(
                                                  color: Color(0xFF787474),
                                                  fontSize: 12,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        child: Icon(
                                            color: Color(0xffCCC9C9),
                                            Icons.settings_outlined))
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 26),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x0C8B8B8B),
                                      blurRadius: 10,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '즐겨찾는 학과',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF1B1616),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 35,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: bookmarkMajors.length,
                                          itemBuilder: (context, index) {
                                            return BookmarkMajorCard(
                                                name: bookmarkMajors[index]);
                                          }),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '메일 수신 시간',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF1B1616),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        height: 44,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFFAF8F8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'AM',
                                              style: TextStyle(
                                                color: Color(0xFF423C3C),
                                                fontSize: 14,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Icon(Icons.lock_clock_outlined)
                                          ],
                                        )),
                                    GestureDetector(
                                        child: Container(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 11),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFE85C64),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '수정',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                                margin: EdgeInsets.only(bottom: 20),
                              ),
                              SimpleBox(name: "피드백"),
                              SimpleBox(name: "인스타그램")
                            ],
                          )),
                      Container(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await signOutService.SignOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPageWidget()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text(
                                  '로그아웃',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF787474),
                                    fontSize: 12,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                  onTap: () async {
                                    await withdrawalService.Withdrawal();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPageWidget()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text(
                                    '탈퇴하기',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF787474),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                '개인정보 처리 방침',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFCCC9C9),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ))
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ));
    });
  }
}

class BookmarkMajorCard extends StatelessWidget {
  const BookmarkMajorCard({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 105,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: ShapeDecoration(
        color: Color(0x7FFFD8DA),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFFF4F59)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFF3A46),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleBox extends StatelessWidget {
  const SimpleBox({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.height * 0.9,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: 24,
            height: 24,
            child: Icon(color: Color(0xff787474), Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
