import 'package:flutter/material.dart';
import 'package:kudog/pages/ViewMainPage.dart';

void main() {
  runApp(const MainApp());
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
      home: ViewMainPageWidget(),
    );
  }
}
