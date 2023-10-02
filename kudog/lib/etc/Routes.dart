import 'package:kudog/pages/ViewHomePage.dart';
import 'package:kudog/pages/ViewHotPage.dart';
import 'package:kudog/pages/ViewMainPage.dart';
import 'package:kudog/pages/ViewMyPage.dart';
import 'package:kudog/pages/ViewScrabPage.dart';
import 'package:kudog/pages/ViewSubscribePage.dart';
import 'package:kudog/pages/auth/SelectCategoryPage.dart';
import 'package:kudog/pages/auth/SignInPage.dart';

var namedRoutes = {
  '/SelectCategoryPage': (context) => SelectCategoryPageWidget(),
  '/SignInPage': (context) => SignInPageWidget(),
  '/ViewHomePage': (context) => ViewHomePageWidget(),
  '/ViewMyPage': (context) => ViewMyPageWidget(),
  '/ViewScrabPage': (context) => ViewScrabPageWidget(),
  '/ViewMainPage': (context) => ViewMainPageWidget(),
  '/ViewHotPage': (context) => ViewHotPageWidget(),
  '/ViewSubscribePage': (context) => ViewSubscribePageWidget()
};
