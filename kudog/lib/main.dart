import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:kudog/pages/auth/ChangepwPage.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
=======
>>>>>>> 267a1dd99a2cc8ad7a1cc5fd16f0fb780d386205
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/pages/auth/ChangepwPage.dart';
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
<<<<<<< HEAD
      title: "Changepw",
=======
      title: "Kudog",
>>>>>>> 267a1dd99a2cc8ad7a1cc5fd16f0fb780d386205
      debugShowCheckedModeBanner: false,
      // routes: namedRoutes,
      // initialRoute: "/ViewMainPage",
      home: ChangepwPageWidget(),
    );
  }
}
