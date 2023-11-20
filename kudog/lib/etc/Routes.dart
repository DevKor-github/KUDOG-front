import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/home/ViewHotPage.dart';
import 'package:kudog/pages/home/ViewMainPage.dart';
import 'package:kudog/pages/home/ViewMyPage.dart';
import 'package:kudog/pages/home/ViewScrabPage.dart';
import 'package:kudog/pages/home/ViewSubscribePage.dart';

var namedRoutes = {
  '/SignInPage': (context) => SignUpPageWidget(),
  '/ViewHomePage': (context) => ViewHomePageWidget(),
  '/ViewMyPage': (context) => ViewMyPageWidget(),
  '/ViewScrabPage': (context) => ViewScrabPageWidget(),
  '/ViewMainPage': (context) => ViewMainPageWidget(),
  '/ViewHotPage': (context) => ViewHotPageWidget(),
  '/ViewSubscribePage': (context) => ViewSubscribePageWidget()
};
