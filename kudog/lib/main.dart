import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/SelectCategoryPage.dart';

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
      initialRoute: "/SelectCategory",
      home: SelectCategoryPageWidget(),
    );
  }
}
