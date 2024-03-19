import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/pages/home/ViewMainPage.dart';
import 'package:kudog/util/DioClient.dart';
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
      bool isLoggedIn = await _validateTokens();
      if (isLoggedIn) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ViewMainPageWidget()));
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPageWidget()));
        });
      }
    }
  }

  Future<bool> _validateTokens() async {
    try {
      DioClient dioClient = DioClient();
      await dioClient.get("/users/info");
      return true;
    } catch (e) {
      return false;
    }
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
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset("assets/images/main2.png"))
          ],
        )));
  }
}
