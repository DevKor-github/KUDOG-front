import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MainApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoticeService()),
    ChangeNotifierProvider(create: (context) => SignInService()),
    ChangeNotifierProvider(create: (context) => SignUpService()),
    ChangeNotifierProvider(create: (context) => ChangePwService()),
    ChangeNotifierProvider(create: (context) => UserInfoService()),
    ChangeNotifierProvider(create: (context) => CategoryService()),
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
      home: LoginPageWidget(),
    );
  }
}
