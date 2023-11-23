import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/pages/home/ViewHotPage.dart';
import 'package:kudog/pages/home/ViewMyPage.dart';
import 'package:kudog/pages/home/ViewScrabPage.dart';
import 'package:kudog/pages/home/ViewSubscribePage.dart';

var namedRoutes = {
  '/SignInPage': (context) => SignUpPageWidget(),
  '/ViewMyPage': (context) => ViewMyPageWidget(),
  '/ViewScrabPage': (context) => ViewScrabPageWidget(),
  '/ViewHotPage': (context) => ViewHotPageWidget(),
  '/ViewSubscribePage': (context) => ViewSubscribePageWidget()
};
