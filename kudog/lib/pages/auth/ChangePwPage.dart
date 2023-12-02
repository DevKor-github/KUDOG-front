import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';

class ChangepwPageWidget extends StatefulWidget {
  const ChangepwPageWidget({Key? key}) : super(key: key);

  @override
  _ChangepwPageWidgetState createState() => _ChangepwPageWidgetState();
}

class _ChangepwPageWidgetState extends State<ChangepwPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpService>(builder: (context, signupService, child) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: 405,
              height: 720,
              color: Colors.white,
            ),
            Positioned(
              width: 14,
              height: 22.38,
              top: 59.69,
              left: 32,
              child: Image.asset('assets/left_sign.png'),
            ),
            Positioned(
              width: 184,
              height: 46,
              top: 51,
              left: 77,
              child: Text(
                "비밀번호 변경",
                style: TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              width: 73,
              height: 22,
              top: 123,
              left: 49,
              child: Text(
                "새 비밀번호",
                style: TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF7E7E7E),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFFD9D9D9),
                  decorationThickness: 0.2,
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 24,
              child: SizedBox(
                width: 357,
                height: 47,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(24, 12, 22, 12), // 질문
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(208),
                    border: Border.all(color: Color(0xFFCDCDCD), width: 2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                          style: TextStyle(color: Color(0xFFA4A4A4)),
                          obscuringCharacter: '●',
                        ),
                      ),
                      Container(
                          child: Image.asset(
                        'assets/cancel.png',
                        width: 14,
                        height: 14,
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 205,
                left: 54,
                child: Image.asset(
                  'assets/red_i.png',
                  width: 12,
                  height: 12,
                )),
            Positioned(
              top: 202,
              left: 74,
              child: Text(
                '6-16자 영문 소문자, 숫자를 사용하세요.',
                style: TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFFCE4040),
                  decoration: TextDecoration.underline, // 텍스트 주위에 선 추가
                  decorationColor: Color(0xFFD9D9D9), // 선의 색상
                  decorationThickness: 0.2,
                ),
              ),
            ),
            Positioned(
              top: 229,
              left: 24,
              child: SizedBox(
                width: 357,
                height: 47,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(24, 12, 22, 12), // 질문
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(208),
                    border: Border.all(color: Color(0xFFCDCDCD), width: 2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                          style: TextStyle(color: Color(0xFFA4A4A4)),
                          obscuringCharacter: '●',
                        ),
                      ),
                      Container(
                          child: Image.asset(
                        'assets/cancel.png',
                        width: 14,
                        height: 14,
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 284,
                left: 54,
                child: Image.asset(
                  'assets/red_i.png',
                  width: 12,
                  height: 12,
                )),
            Positioned(
              top: 281,
              left: 74,
              child: Text(
                '비밀번호가 일치하지 않습니다.',
                style: TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: Color(0xFFCE4040),
                  decoration: TextDecoration.underline, // 텍스트 주위에 선 추가
                  decorationColor: Color(0xFFD9D9D9), // 선의 색상
                  decorationThickness: 0.2,
                ),
              ),
            ),
            Positioned(
              top: 322,
              left: 22,
              child: SizedBox(
                width: 357,
                height: 47,
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.fromLTRB(159, 13, 159, 13), // 수치 맞는지 질문
                  decoration: BoxDecoration(
                    color: Color(0xFFCE4040),
                    borderRadius: BorderRadius.circular(58),
                  ),
                  child: Text(
                    "비밀번호 저장",
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
