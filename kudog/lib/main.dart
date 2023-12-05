import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/ChangeMyInfoPage.dart';
import 'package:kudog/pages/auth/ChangepwPage.dart';
import 'package:kudog/pages/auth/SelectCategoryPage.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/pages/auth/FindPwPage.dart';
import 'package:kudog/pages/auth/ChangepwPage.dart';
import 'package:kudog/pages/home/FixSubscribePage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/home/ViewMyPage.dart';
import 'package:kudog/pages/home/ViewSubscribePage.dart';
import 'package:kudog/pages/home/ViewMainPage.dart';
import 'package:kudog/pages/home/ViewScrabPage.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:kudog/service/SignOutService.dart';
import 'package:provider/provider.dart';
import 'package:kudog/pages/start/StartPage.dart';

void main() {
  // runApp(const MainApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoticeService()),
    ChangeNotifierProvider(create: (context) => SignInService()),
    ChangeNotifierProvider(create: (context) => SignUpService()),
    ChangeNotifierProvider(create: (context) => ChangePwService()),
    ChangeNotifierProvider(create: (context) => UserInfoService()),
    ChangeNotifierProvider(create: (context) => CategoryService()),
    ChangeNotifierProvider(create: (context) => SignOutService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Kudog",
      debugShowCheckedModeBanner: false,
      // routes: namedRoutes,
      // initialRoute: "/ViewMainPage",
      home: StartPageWidget(),
    );
  }
}
