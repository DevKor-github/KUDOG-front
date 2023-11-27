import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/pages/home/ViewMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({Key? key}) : super(key: key);

  @override
  _StartPageWidgetState createState() => _StartPageWidgetState();
}

class _StartPageWidgetState extends State<StartPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? accessToken = "";
  String? refreshToken = "";

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString("access_token");
    refreshToken = sharedPreferences.getString("refresh_token");
    if (accessToken != "" && refreshToken != "") {
      bool isLoggedIn = _validateTokens();
      if (isLoggedIn) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ViewMainPageWidget()));
        });
      } else {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPageWidget()));
        });
      }
    }
  }

  bool _validateTokens() {
    //임시 : 토큰 유효성 검사 필요
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(top: 80),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.09, color: Color(0xFFCD4040)),
                    borderRadius: BorderRadius.circular(16.34),
                  ),
                ),
                child: Center(
                    child: Text(
                  '교내 공지사항을 카테고리별로 구독하여\n메일로 받아 보세요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w600,
                  ),
                ))),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset("assets/images/main.png"),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '고려대학교 ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      height: 0.06,
                    ),
                  ),
                  TextSpan(
                    text: '공지사항 메일 구독',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                    ),
                  ),
                  TextSpan(
                    text: ' 서비스',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      height: 0.06,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset("assets/images/main2.png"))
          ],
        )));
  }
}
