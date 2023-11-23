import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kudog/etc/Category.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/MailModel.dart';
import 'package:kudog/pages/auth/SelectCategoryPage.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({Key? key}) : super(key: key);

  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedGrade = "1학년";
  String selectedId = "23학번";
  String selectedMajor = "컴퓨터학과";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController subscribeController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();

  int _timerValue = 180; // 3분을 초로 표현
  late Timer _timer;
  bool _timerVisible = false;
  bool _noticeVisible = false;
  bool isSame = false;

  @override
  void initState() {
    super.initState();
    Majors.sort((a, b) => a.compareTo(b));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    _noticeVisible = true;
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        setState(() {
          if (_timerValue < 1) {
            timer.cancel();
            _timerVisible = false;
          } else {
            _timerValue -= 1;
          }
        });
      },
    );
    _timerVisible = true;
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void stopTimer() {
    _timer.cancel();
    _timerVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpService>(builder: (context, signupService, child) {
      return GestureDetector(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          backgroundColor: secondaryBackground,
          appBar: AppBar(
            backgroundColor: secondaryBackground,
            iconTheme: IconThemeData(color: primaryText),
            automaticallyImplyLeading: true,
            title: Text(
              '회원가입',
              style: TextStyle(
                fontFamily: 'Noto Sans',
                color: Color(0xFF15161E),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2,
          ),
          body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputForm(
                              controller: nameController,
                              type: "이름",
                              label: "이름"),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18, 12, 0, 6),
                                    child: Text(
                                      '이메일',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: secondaryText,
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
                                                SendMail mail = SendMail(
                                                    email:
                                                        emailController.text);
                                                signupService.SendEmail(mail);
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
                                  !signupService.isKorea
                                      ? Message(
                                          text: "이메일이 유효하지 않습니다.",
                                          color: Color(0xFFCE4040),
                                          visible: _timerVisible)
                                      : Message(
                                          text: '인증번호를 발송했습니다.',
                                          color: Color(0xFF06C755),
                                          visible: _timerVisible),
                                  Container(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CodeInputForm(
                                              visible: _timerVisible &&
                                                  signupService.isKorea,
                                              value: _timerValue,
                                              controller: codeController,
                                              label: "ⓘ 인증번호를 입력해 주세요",
                                              isVerified:
                                                  signupService.isVerified),
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
                                                  onPressed: () {
                                                    stopTimer();
                                                    VerifyMail mail =
                                                        VerifyMail(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            code: codeController
                                                                .text);
                                                    signupService.VerifyEmail(
                                                        mail);
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
                                  signupService.isSend
                                      ? signupService.isVerified
                                          ? Message(
                                              text: '인증되었습니다.',
                                              color: Color(0xFF06C755),
                                              visible: _noticeVisible)
                                          : Message(
                                              text: '잘못된 인증번호입니다.',
                                              color: Color(0xFFCE4040),
                                              visible: _noticeVisible)
                                      : Padding(
                                          padding: EdgeInsets.all(0),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      InputForm(
                          controller: subscribeController,
                          type: "구독용 이메일",
                          label: "ⓘ 수신 받을 이메일을 입력해주세요"),
                      PWInputForm(
                        controller: pwController,
                        type: "비밀번호",
                        label: "ⓘ 6-16자 / 영문 소문자, 숫자 사용가능",
                      ),
                      PWInputForm(
                        controller: pwConfirmController,
                        type: pwController.text,
                        label: "ⓘ 한 번 더 입력해주세요.",
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                            child: Text(
                              '학과',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: secondaryText,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsetsDirectional.fromSTEB(6, 4, 6, 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFFCDCDCD), width: 2.0),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: DropdownButton<String>(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMajor = newValue!;
                                });
                                print(selectedMajor);
                              },
                              items: Majors.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              itemHeight: 50,
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 12,
                              ),
                              icon: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: secondaryText,
                                  size: 24,
                                ),
                              ),
                              dropdownColor: secondaryBackground,
                              elevation: 2,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18, 12, 0, 6),
                                    child: Text(
                                      '학번',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: secondaryText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 160,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        6, 4, 6, 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFCDCDCD), width: 2.0),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedId = newValue!;
                                        });
                                        print(selectedId);
                                      },
                                      items: Ids.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      itemHeight: 50,
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: secondaryText,
                                        size: 24,
                                      ),
                                      dropdownColor: secondaryBackground,
                                      elevation: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18, 12, 0, 6),
                                    child: Text(
                                      '학년',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: secondaryText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 160,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        6, 4, 6, 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFCDCDCD), width: 2.0),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: DropdownButton<String>(
                                      value: selectedGrade,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGrade = newValue!;
                                        });
                                        print(selectedGrade);
                                      },
                                      items:
                                          Grades.map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      itemHeight: 50,
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: secondaryText,
                                        size: 24,
                                      ),
                                      dropdownColor: secondaryBackground,
                                      elevation: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 12),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                              onPressed: signupService.isVerified
                                  ? () {
                                      SignUpUser user = SignUpUser(
                                          name: nameController.text,
                                          subscriberEmail:
                                              subscribeController.text,
                                          portalEmail: emailController.text,
                                          password: pwController.text,
                                          major: selectedMajor,
                                          studentId: selectedId,
                                          grade: int.parse(selectedGrade));
                                      signupService.SignUp(user);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectCategoryPageWidget(
                                                    email: emailController.text,
                                                    password: pwController.text,
                                                  )));
                                    }
                                  : () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              title: Column(
                                                children: <Widget>[
                                                  Text("이메일 인증 필요"),
                                                ],
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "이메일 인증 후 회원가입할 수 있습니다.",
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    foregroundColor: primary,
                                                    textStyle: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  child: Text("확인"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.transparent,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                backgroundColor: primary,
                              ),
                              child: Text(
                                "회원가입",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )))
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}

class CodeInputForm extends StatefulWidget {
  const CodeInputForm(
      {super.key,
      required this.visible,
      required this.value,
      required this.controller,
      required this.label,
      required this.isVerified});
  final bool visible;
  final int value;
  final TextEditingController controller;
  final String label;
  final bool isVerified;
  @override
  _CodeInputFormState createState() => _CodeInputFormState();
}

class _CodeInputFormState extends State<CodeInputForm> {
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
            widget.isVerified
                ? Visibility(
                    visible: widget.visible,
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
                : Visibility(
                    visible: widget.visible,
                    child: Container(
                        child: Image.asset("assets/images/verified.png",
                            width: 14, height: 14, color: Color(0xff06C755))),
                  ),
          ],
        ));
  }
}

class EmailInputForm extends StatelessWidget {
  const EmailInputForm(
      {super.key,
      required this.controller,
      required this.type,
      required this.label});
  final TextEditingController controller;
  final String type;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: TextFormField(
        controller: controller,
        autofocus: true,
        autofillHints: [AutofillHints.email],
        obscureText: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Readex Pro',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: primaryText,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFCDCDCD),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: alternate,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: alternate,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          filled: true,
          fillColor: secondaryBackground,
          contentPadding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message(
      {super.key,
      required this.text,
      required this.color,
      required this.visible});
  final String text;
  final Color color;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 4, 0, 2),
          child: Text(
            'ⓘ ' + text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required this.controller,
      required this.type,
      required this.label});
  final TextEditingController controller;
  final String type;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        type != ""
            ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                child: Text(
                  type,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: secondaryText,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
              ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            autofillHints: [AutofillHints.email],
            obscureText: false,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: primaryText,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFCDCDCD),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              filled: true,
              fillColor: secondaryBackground,
              contentPadding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}

class PWInputForm extends StatefulWidget {
  const PWInputForm(
      {super.key,
      required this.controller,
      required this.type,
      required this.label});
  final TextEditingController controller;
  final String type;
  final String label;

  @override
  _PWInputFormState createState() => _PWInputFormState();
}

class _PWInputFormState extends State<PWInputForm> {
  bool isPassed = false;
  bool isSame = false;

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
    isSame = widget.controller.text == widget.type;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.type == "비밀번호"
            ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                child: Text(
                  widget.type,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: secondaryText,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
              ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            onChanged: (value) {
              if (value == null) {
                isPassed = false;
              } else if (RegExp(r'^[a-z0-9]{6,16}$').hasMatch(value)) {
                isPassed = true;
              }
            },
            controller: widget.controller,
            autofocus: true,
            autofillHints: [AutofillHints.email],
            obscureText: false,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: primaryText,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFCDCDCD),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              filled: true,
              fillColor: secondaryBackground,
              contentPadding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Message(
            text: widget.type == "비밀번호"
                ? '6-16자 영문 소문자, 숫자를 사용하세요.'
                : '비밀번호가 일치하지 않습니다.',
            color: Color(0xFFCE4040),
            visible: widget.type == "비밀번호" ? !isPassed : !isSame)
      ],
    );
  }
}
