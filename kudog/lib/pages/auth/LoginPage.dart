import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/util/DioClient.dart';
import 'package:kudog/util/Filter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? accessToken = "";
  String? refreshToken = "";

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString("access_token");
    refreshToken = sharedPreferences.getString("refresh_token");
    print(accessToken);

    if (accessToken != null && refreshToken != null) {
      //토큰이 있을 때
      if (await _validateTokens()) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String sevenDaysAgo = DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(Duration(days: 7)));
        //유효한 토큰일 때
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => NavigationPageWidget(idx: 2)));
        });
      } else {}
    }
  }

  Future<bool> _validateTokens() async {
    try {
      DioClient dioClient = DioClient();
      await dioClient.get("/users/info");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInService>(
      builder: (context, signInService, child) {
        return Scaffold(
          backgroundColor: Color(0xffFF4F59),
          body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 170,
                            ),
                            Container(
                              child: Image.asset(
                                "assets/images/login_icon.png",
                                width: 120,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "관심있는 소식만 모아서 \n빠르게 보내드려요.",
                                style: TextStyle(
                                  color: Color(0xffF4F2F2),
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                      child: Column(children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 1,
                            padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: Color(0xffE5A4A7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xFFF4F2F2),
                                fontSize: 14.0,
                              ),
                              cursorColor: const Color(0xffF4F2F2),
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "아이디",
                                fillColor: const Color(0xffF4F2F2),
                                hintStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFFF4F2F2),
                                ),
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 1,
                            padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: Color(0xffE5A4A7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xFFF4F2F2),
                                fontSize: 14.0,
                              ),
                              obscureText: true,
                              cursorColor: const Color(0xffF4F2F2),
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "비밀번호",
                                fillColor: const Color(0xffF4F2F2),
                                hintStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFFF4F2F2),
                                ),
                              ),
                            )),
                        GestureDetector(
                            onTap: () async {
                              LoginUser user = LoginUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                              await signInService.Signin(user);
                              if (signInService.successLogin) {
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now());
                                String sevenDaysAgo = DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()
                                        .subtract(Duration(days: 7)));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NavigationPageWidget(idx: 2)));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  alignment: Alignment
                                                      .center, // 이미지들이 서로 겹치도록 정렬
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/signup_success_background.png', // 기울어진 이미지 URL 또는 로컬 이미지 경로
                                                      width: 200,
                                                      height: 200,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/signup_success_foreground.png', // 위에 겹쳐질 이미지 URL 또는 로컬 이미지 경로
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '로그인 실패',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF1B1616),
                                                fontSize: 18,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                        actions: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 4),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                decoration: ShapeDecoration(
                                                  color: Color(0xffFF3B47),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "확인",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFffffff),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'Pretendard',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 4),
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: ShapeDecoration(
                                color: Color(0xFFffffff),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "로그인",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xffFF3B47),
                                      fontSize: 18,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '비밀번호 찾기',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFF4F2F2),
                                    fontSize: 12,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '|',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFF4F2F2),
                                    fontSize: 12,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPageWidget()));
                                    },
                                    child: Text(
                                      '회원가입',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF4F2F2),
                                        fontSize: 12,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w400,
                                        height: 0.15,
                                      ),
                                    ))
                              ],
                            )),
                      ]),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required this.controller,
      required this.hint,
      required this.ratio});
  final TextEditingController controller;
  final String hint;
  final double ratio;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width * ratio,
            // padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: Color(0xffF4F2F2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              cursorColor: Colors.black,
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xffFF3B47),
                  ),
                ),
                border: InputBorder.none,
                hintText: hint,
                fillColor: const Color(0xffF4F2F2),
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFFA4A4A4),
                ),
              ),
            )));
  }
}
