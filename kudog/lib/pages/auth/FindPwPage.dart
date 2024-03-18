import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/ChangePwPage.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:provider/provider.dart';

class FindpwPageWidget extends StatefulWidget {
  const FindpwPageWidget({Key? key}) : super(key: key);

  @override
  _FindpwPageWidgetState createState() => _FindpwPageWidgetState();
}

class _FindpwPageWidgetState extends State<FindpwPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _codeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _showTimer = false;
  int _timerCount = 180;
  String userEmail = "";

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timerCount == 0) {
          setState(() {
            _showTimer = false;
          });
          timer.cancel();
        } else {
          setState(() {
            _timerCount--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePwService>(
        builder: (context, changePwService, child) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: const Text(
            '비밀번호 찾기',
            style: TextStyle(
              fontFamily: "NotoSans-Regular",
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18, 40, 18, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 40),
                  height: 22,
                  child: const Text(
                    "이메일",
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF7E7E7E),
                      decorationColor: Color(0xFFD9D9D9),
                      decorationThickness: 0.2,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(18, 18, 8, 8), // 여기에서 수정
                          child: SizedBox(
                            height: 47,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(24, 12, 22, 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(208),
                                border: Border.all(
                                    color: const Color(0xFFCDCDCD), width: 2),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "ⓘ 학교 이메일로 입력해 주세요",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Noto Sans KR',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xFFA4A4A4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 111,
                        height: 47,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _showTimer = true;
                              _timerCount = 180;
                              userEmail = emailController.text;
                            });
                            startTimer();
                            changePwService.RequestCode(emailController.text);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(58),
                              border: Border.all(
                                  color: const Color(0xFFCE4040), width: 2),
                            ),
                            child: const Text(
                              "인증번호 받기",
                              style: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFFCE4040),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showTimer)
                  Container(
                    padding: const EdgeInsets.only(left: 50),
                    child: const Row(
                      children: [],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: const Row(
                    children: [
                      Text(
                        'ⓘ 학교 이메일로 입력해주세요.',
                        style: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Color(0xFFCE4040),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFD9D9D9),
                          decorationThickness: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(18, 18, 8, 8), // 여기에서 수정
                          child: SizedBox(
                            height: 47,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(24, 12, 22, 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(208),
                                border: Border.all(
                                    color: const Color(0xFFCDCDCD), width: 2),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _codeController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "ⓘ 인증번호를 입력해주세요",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Noto Sans KR',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xFFA4A4A4),
                                          )),
                                    ),
                                  ),
                                  Text(
                                    '${(_timerCount ~/ 60).toString().padLeft(2, '0')}:${(_timerCount % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xFFCE4040),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 111,
                        height: 47,
                        child: InkWell(
                          onTap: () {
                            changePwService.VerifyCode(_codeController.text);
                            if (changePwService.isVerified) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ChangepwPageWidget(email: userEmail),
                              ));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(58),
                              border: Border.all(
                                  color: const Color(0xFFCE4040), width: 2),
                            ),
                            child: const Text(
                              "확인",
                              style: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFFCE4040),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: const Row(
                    children: [
                      Text(
                        'ⓘ 잘못된 인증번호입니다.',
                        style: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Color(0xFFCE4040),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFD9D9D9),
                          decorationThickness: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
