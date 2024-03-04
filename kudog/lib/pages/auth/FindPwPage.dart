import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/ChangePwPage.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:provider/provider.dart';
import 'package:kudog/etc/Colors.dart';

import 'package:kudog/pages/auth/SignUpPage.dart';

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
  bool _showCodeAlert = false;
  int _timerCount = 180;
  String userEmail = "";

  late Timer _timer;
  bool isSame = false;
  bool _noticeVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    _noticeVisible = true;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_timerCount < 1) {
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
    _showTimer = true;
  }


  @override
  void dispose() {
    super.dispose();
  }

  void stopTimer() {
    _timer.cancel();
    _showTimer = false;
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
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
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
            padding: EdgeInsetsDirectional.fromSTEB(18, 40, 18, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40),
                  height: 22,
                  child: Text(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmailInputForm(
                        controller: emailController,
                        type: "이메일",
                        label: "ⓘ 학교 이메일로 입력해주세요."),
                    Container(
                        height: MediaQuery.of(context)
                            .size
                            .height *
                            0.05,
                        width: MediaQuery.of(context)
                            .size
                            .width *
                            0.35,
                        padding:
                        EdgeInsetsDirectional.fromSTEB(
                            12, 0, 0, 0),
                        child: ElevatedButton(
                            onPressed: () {
                              startTimer();
                              changePwService.RequestCode(emailController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 1.0,
                                color: primary,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      20.0)),
                              backgroundColor:
                              secondaryBackground,
                            ),
                            child: Text(
                              "인증번호 받기",
                              style: const TextStyle(
                                  color: primary,
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.w500),
                            ))),
                  ],
                ),
                Message(
                    text: changePwService.firstAnswer,
                    color: changePwService.firstId == 1
                        ? Color(0xFF06C755)
                        : Color(0xFFCE4040),
                    visible: _showTimer),
                Container(
                    padding: EdgeInsets.only(top: 6),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        CodeInputForm_find(
                            value: _timerCount,
                            controller: _codeController,
                            label: "ⓘ 인증번호를 입력해 주세요",
                            ),
                        Container(
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.05,
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.35,
                            padding: EdgeInsetsDirectional
                                .fromSTEB(12, 0, 0, 0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  _showCodeAlert = true;

                                  if (changePwService.firstId ==
                                      1) {
                                    stopTimer();

                                    changePwService.VerifyCode(_codeController.text).then((_) {
                                      if (changePwService.secondId == 1) {
                                        print("secondId == 1로 확인");
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ChangepwPageWidget(email: userEmail),
                                        ));
                                      }
                                    });

                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible:
                                        false,
                                        builder: (BuildContext
                                        context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    10.0)),
                                            title: Column(
                                              children: <Widget>[
                                                Text(
                                                    "인증 번호 전송 필요"),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Text(
                                                  "인증 번호가 전송되지 않았습니다.",
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton
                                                    .styleFrom(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(
                                                      20.0),
                                                  foregroundColor:
                                                  primary,
                                                  textStyle: const TextStyle(
                                                      fontSize:
                                                      20),
                                                ),
                                                child: Text(
                                                    "확인"),
                                                onPressed:
                                                    () {
                                                  Navigator.pop(
                                                      context);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                },
                                style:
                                ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: primary,
                                  ),
                                  shape:
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          20.0)),
                                  backgroundColor:
                                  secondaryBackground,
                                ),
                                child: Text(
                                  "확인",
                                  style: const TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w500),
                                ))),
                      ],
                    )),
                Message(
                    text: changePwService.secondAnswer,
                    color: changePwService.secondId == 1
                        ? Color(0xFF06C755)
                        : Color(0xFFCE4040),
                    visible: _showCodeAlert),
                /*changePwService.isVerified
                    ? Message(
                    text: changePwService.secondAnswer,
                    color: changePwService.secondId == 1
                        ? Color(0xFF06C755)
                        : Color(0xFFCE4040),
                    visible: _noticeVisible)
                    : Padding(
                  padding: EdgeInsets.all(0),
                ), */

                /*
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(18, 18, 8, 8), // 여기에서 수정
                          child: SizedBox(
                            height: 47,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(24, 12, 22, 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(208),
                                border: Border.all(
                                    color: Color(0xFFCDCDCD), width: 2),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
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
                                  color: Color(0xFFCE4040), width: 2),
                            ),
                            child: Text(
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
                    padding: EdgeInsets.only(left: 50),
                    child: Row(
                      children: [],
                    ),
                  ),
                Container(
                  padding: EdgeInsets.only(left: 50),
                  child: Row(
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
                          margin: EdgeInsets.fromLTRB(18, 18, 8, 8), // 여기에서 수정
                          child: SizedBox(
                            height: 47,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(24, 12, 22, 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(208),
                                border: Border.all(
                                    color: Color(0xFFCDCDCD), width: 2),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _codeController,
                                      decoration: InputDecoration(
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
                                    style: TextStyle(
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
                                  color: Color(0xFFCE4040), width: 2),
                            ),
                            child: Text(
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
                  padding: EdgeInsets.only(left: 50),
                  child: Row(
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
                ), */
              ],
            ),
          ),
        ),
      );
    });
  }
}




class CodeInputForm_find extends StatefulWidget {
  const CodeInputForm_find(
      {super.key,
        required this.value,
        required this.controller,
        required this.label});
  final int value;
  final TextEditingController controller;
  final String label;
  @override
  _CodeInputForm_findState createState() => _CodeInputForm_findState();
}

class _CodeInputForm_findState extends State<CodeInputForm_find> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.55,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Color(0xFFCDCDCD)),
            borderRadius: BorderRadius.circular(208),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.38,
              child: TextFormField(
                controller: widget.controller,
                autofocus: true,
                autofillHints: [AutofillHints.email],
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.label,
                  labelStyle: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: primaryText,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Visibility(
              visible: true,
              child: Container(
                child: Text(
                  formatTime(widget.value),
                  style: TextStyle(
                    color: Color(0xFFDA4949),
                    fontSize: 14,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}