import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/home/ViewPostDetailPage.dart';
import 'package:kudog/pages/my/ViewMyPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/NotificationService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/service/SignOutService.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:kudog/service/WithdrawalService.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  // await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoticeService()),
    ChangeNotifierProvider(create: (context) => SignInService()),
    ChangeNotifierProvider(create: (context) => SignUpService()),
    ChangeNotifierProvider(create: (context) => ChangePwService()),
    ChangeNotifierProvider(create: (context) => UserInfoService()),
    ChangeNotifierProvider(create: (context) => CategoryService()),
    ChangeNotifierProvider(create: (context) => SignOutService()),
    ChangeNotifierProvider(create: (context) => WithdrawalService()),
    ChangeNotifierProvider(create: (context) => TokenService()),
    ChangeNotifierProvider(create: (context) => NotificationService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Kudog",
        debugShowCheckedModeBanner: false,
        home: LoginPageWidget()
        // home: ViewPostDetailPageWidget(
        //     notice: Notice(
        //         id: 1,
        //         title: "2023학년도 제1학기 복수전공 면접",
        //         scrapped: false,
        //         date: "2023-11-07",
        //         mappedCategory: "학사일정",
        //         provider: "컴퓨터학과",
        //         scrapBoxId: [1, 2, 3]))
        );
  }
}
