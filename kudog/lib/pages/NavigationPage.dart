import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/alarm/ViewAlarmPage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/my/ViewMyPage.dart';
import 'package:kudog/pages/scrab/ViewScrabPage.dart';
import 'package:kudog/pages/subscribe/ViewSubscribePage.dart';

import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/util/Filter.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavigationPageWidget extends StatefulWidget {
  const NavigationPageWidget({
    super.key,
  });
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ViewScrabPageWidget(),
      ViewSubscribePageWidget(),
      ViewHomePageWidget(),
      ViewAlarmPageWidget(),
      ViewMyPageWidget()
    ];

    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline, size: 30), label: "스크랩"),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline, size: 30), label: "구독함"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30), label: "홈"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined, size: 30),
              label: "알림"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 30), label: "마이"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: const Color(0xffC6C6C6),
        selectedItemColor: const Color(0xffFF3B47),
        showUnselectedLabels: true,
      ),
    );
  }
}
