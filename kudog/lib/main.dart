import 'package:flutter/material.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/service/SignOutService.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:kudog/service/WithdrawalService.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MainApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoticeService()),
    ChangeNotifierProvider(create: (context) => SignInService()),
    ChangeNotifierProvider(create: (context) => SignUpService()),
    ChangeNotifierProvider(create: (context) => ChangePwService()),
    ChangeNotifierProvider(create: (context) => UserInfoService()),
    ChangeNotifierProvider(create: (context) => CategoryService()),
    ChangeNotifierProvider(create: (context) => SignOutService()),
    ChangeNotifierProvider(create: (context) => WithdrawalService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Kudog",
        debugShowCheckedModeBanner: false,
        home: NavigationPageWidget());
  }
}
