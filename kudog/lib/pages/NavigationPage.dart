import 'package:flutter/material.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/pages/alarm/ViewAlarmPage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/my/ViewMyPage.dart';
import 'package:kudog/pages/scrab/ViewScrabPage.dart';
import 'package:kudog/pages/subscribe/ViewSubscribePage.dart';

import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavigationPageWidget extends StatefulWidget {
  const NavigationPageWidget({super.key});
  @override
  _NavigationPageWidgetState createState() => _NavigationPageWidgetState();
}

class _NavigationPageWidgetState extends State<NavigationPageWidget> {
  int _selectedIndex = 2;
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String> tempLogin() async {
    //임시 로그인 : 로그인 페이지 미구현
    await Provider.of<SignInService>(context, listen: false)
        .Signin(LoginUser(email: "ryan0102@korea.ac.kr", password: "car0814"));
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    print("로그인: " + sharedPreference.getString("access_token")!);
    return sharedPreference.getString("access_token")!;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ViewScrabPageWidget(),
      ViewSubscribePageWidget(),
      ViewHomePageWidget(),
      ViewAlarmPageWidget(),
      ViewMyPageWidget()
    ];

    return FutureBuilder(
        future: tempLogin(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_outline, size: 30),
                      label: "스크랩"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.mail_outline, size: 30), label: "구독함"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined, size: 30), label: "홈"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_none_outlined, size: 30),
                      label: "알림"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_outlined, size: 30),
                      label: "마이"),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                unselectedItemColor: const Color(0xffC6C6C6),
                selectedItemColor: const Color(0xffFF3B47),
                showUnselectedLabels: true,
              ),
            );
          }
        });
  }
}
