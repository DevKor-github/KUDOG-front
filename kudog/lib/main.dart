import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MainApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoticeService()),
    ChangeNotifierProvider(create: (context) => SignInService()),
    ChangeNotifierProvider(create: (context) => SignUpService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      // routes: namedRoutes,
      // initialRoute: "/ViewMainPage",
      home: SignUpPageWidget(),
    );
  }
}
