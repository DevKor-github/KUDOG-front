import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/MailModel.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';
import 'package:charcode/ascii.dart';
import 'package:charcode/html_entity.dart';
import 'package:dio/dio.dart';



class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Dio _dio = Dio();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login(String email, String password) async {
    try {
      final Map<String, dynamic> data = {
        'email' : emailController.text,
        'password' : passwordController.text,
      };

      final response = await _dio.post(
        'http://54.180.85.164/login',
        data: FormData.fromMap(data),
      );

      if (response.statusCode == 200) {
        print('login success');
      }
      else {
        print('fail : ${response.data}');
      }
    } catch (error) {
        print('ERROR! : ${error}');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpService>(builder: (context, signupService, child) {
      return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 64,
                  decoration:   BoxDecoration(
                    color: Color(0xFFCE4040),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 88,
                        margin: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icon_6.png",
                              width: 21.21,
                              height: 21.34,
                              color: Colors.white,
                            ),
                            Image.asset(
                              "assets/images/icon_7.png",
                              width: 36.79,
                              height: 21.34,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(60, 80, 30, 30),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        child: Text(
                          "공지사항 쿠독 시작하기",
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF7E7E7E),
                            decoration: TextDecoration.underline, // 텍스트 주위에 선 추가
                            decorationColor: Color(0xFFD9D9D9), // 텍스트 테두리 색상
                            decorationThickness: 0.2, // 텍스트 테두리 두께
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 357,
                  height: 47,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(208),
                      border: Border.all(color: Color(0xFFCDCDCD), width: 2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 62,
                          child: Image.asset('assets/images/icon_17.png'),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "example@korea.ac.kr",
                              hintStyle: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFFA4A4A4),
                              ),
                            ),
                          ),
                        ),
                      ], // children
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 357,
                  height: 47,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(208),
                      border: Border.all(color: Color(0xFFCDCDCD), width: 2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 62,
                          child: Image.asset('assets/images/icon_18.png'),
                        ),


                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "비밀번호",
                              hintStyle: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFFA4A4A4),

                              ),
                            ),
                            obscureText: true,
                            obscuringCharacter: '●',
                            style: TextStyle(color: Color(0xFFA4A4A4)),

                          ),
                        ),
                      ], // children
                    ),
                  ),
                ),


                SizedBox(height: 30),
                Container(
                  width: 357,
                  height: 47,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFCE4040),
                    borderRadius: BorderRadius.circular(58),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _login();
                    }
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "또는",
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xFFD33434),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 357,
                  height: 47,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(58),
                    border: Border.all(color: Color(0xFFCE4040), width: 2),
                  ),
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFFCE4040),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "비밀번호 찾기",
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFFD33434),
                    ),
                  ),
                ),

              ],
            )

          ],
        ),
      );
    });
  }
}
