import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kudog/etc/Category.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
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
  bool isChecked = false;
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
    const oneSecond = Duration(seconds: 1);
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
            iconTheme: const IconThemeData(color: primaryText),
            automaticallyImplyLeading: true,
            title: const Text(
              '회원가입',
              style: TextStyle(
                fontFamily: 'Noto Sans',
                color: Color(0xFF15161E),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 2,
          ),
          body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
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
                                  const Padding(
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
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12, 0, 0, 0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                startTimer();
                                                // SendMail mail = SendMail(
                                                //     email:
                                                //         emailController.text);
                                                signupService.SendEmail(
                                                    emailController.text);
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
                                              child: const Text(
                                                "인증번호 받기",
                                                style: TextStyle(
                                                    color: primary,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ))),
                                    ],
                                  ),
                                  Message(
                                      text: signupService.firstAnswer,
                                      color: signupService.firstId == 1
                                          ? const Color(0xFF06C755)
                                          : const Color(0xFFCE4040),
                                      visible: _timerVisible),
                                  Container(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CodeInputForm(
                                              // visible: _timerVisible &&
                                              //     signupService.firstId == 1,
                                              visible:
                                                  signupService.secondId == 1,
                                              value: _timerValue,
                                              controller: codeController,
                                              label: "ⓘ 인증번호를 입력해 주세요",
                                              isVerified:
                                                  signupService.firstId == 1),
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 0, 0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (signupService.firstId ==
                                                        1) {
                                                      stopTimer();

                                                      signupService.VerifyEmail(
                                                          emailController.text,
                                                          codeController.text);
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
                                                              title:
                                                                  const Column(
                                                                children: <Widget>[
                                                                  Text(
                                                                      "인증 번호 전송 필요"),
                                                                ],
                                                              ),
                                                              content:
                                                                  const Column(
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
                                                                  child:
                                                                      const Text(
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
                                                  child: const Text(
                                                    "확인",
                                                    style: TextStyle(
                                                        color: primary,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))),
                                        ],
                                      )),
                                  signupService.isSend
                                      ? Message(
                                          text: signupService.secondAnswer,
                                          color: signupService.secondId == 1
                                              ? const Color(0xFF06C755)
                                              : const Color(0xFFCE4040),
                                          visible: _noticeVisible)
                                      : const Padding(
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
                          const Padding(
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
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                6, 4, 6, 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFCDCDCD), width: 2.0),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedMajor,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMajor = newValue!;
                                });
                              },
                              items: Majors.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              itemHeight: 50,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Readex Pro',
                                fontSize: 12,
                              ),
                              icon: const Icon(
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            18, 12, 0, 6),
                                    child: const Text(
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
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    margin:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            6, 4, 6, 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFCDCDCD),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedId,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedId = newValue!;
                                        });
                                      },
                                      items: Ids.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      itemHeight: 50,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12,
                                      ),
                                      icon: const Icon(
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
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            18, 12, 0, 6),
                                    child: const Text(
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
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    margin:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            6, 4, 6, 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFCDCDCD),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedGrade,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGrade = newValue!;
                                        });
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
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12,
                                      ),
                                      icon: const Icon(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      title: const Column(
                                        children: <Widget>[
                                          Text("KUDOG 개인정보 처리방침"),
                                        ],
                                      ),
                                      content: const SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                "KUDOG은 정보주체의 자유와 권리 보호를 위해 개인정보 보호법 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 개인정보 보호법 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 및 공개합니다."),
                                            Divider(
                                              color: Colors.black, // 구분선 색상 설정
                                              thickness: 1.0, // 구분선 두께 설정
                                            ),
                                            Text(
                                              "개인정보의 처리 목적",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "KUDOG은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다."),
                                            Text(
                                                "1. 회원 가입 및 관리\n회원제 서비스 제공에 따른 유저 식별 및 인증 목적으로 개인정보를 처리합니다."),
                                            Text(
                                                "2. 서비스 제공\n이메일 전송 서비스 제공을 위한 목적으로 이메일 주소를 수집하여 사용합니다."),
                                            Text(
                                              "\n처리하는 개인정보 항목",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "KUDOG은 다음의 개인정보 항목을 처리하고 있습니다."),
                                            Text(
                                                "1. 회원 가입 및 관리 \n - 필수 항목 : 이메일 주소, 닉네임, 대학 전공, 학년, 입학년도"),
                                            Text("2. 서비스 제공\n- 필수 항목 : 이메일 주소"),
                                            Text(
                                              "\n개인정보의 처리 및 보유 기간",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "1. KUDOG은 법령에 따른 개인정보 보유, 이용 기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유, 이용기간 내에서 개인정보를 처리, 보유합니다."),
                                            Text(
                                                "2. 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다\n- 회원 가입 및 관리 : 앱 탈퇴 / 서비스 종료 시까지\n- 서비스 제공 : 앱 탈퇴 / 서비스 종료 시까지"),
                                            Text(
                                              "\n개인정보의 파기 절차 및 방법",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "1. KUDOG은 개인정보 보유기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다."),
                                            Text(
                                                "2. 개인 정보 파기의 절차 및 방법은 다음과 같습니다.\n- 파기 절차\nKUDOG은 파기 사유가 발생 시 해당 유저의 모든 개인정보를 즉각 데이터베이스에서 삭제합니다.\n - 파기 방법\nKUDOG은 개인정보를 암호화하여 본 서비스 소유의 데이터베이스에 저장하고 있습니다. 해당 데이터는 파일 형태로 기록되지 않도록 로그와 함께 즉각 삭제합니다."),
                                            Text(
                                              "\n정보 주체와 법정 대리인의 권리, 의무 및 행사 방법",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "1. 정보 주체는 KUDOG에 대해 언제든지 개인정보 열람, 정정, 삭제, 처리정지 요구 등의 권리를 행사할 수 있습니다."),
                                            Text(
                                                "2. 권리 행사는 KUDOG에 대해 이메일, 개인정보 보호 책임자 등의 연락 방법을 통하여 하실 수 있으며, KUDOG은 이에 대해 즉각 조치합니다."),
                                            Text(
                                              "\n개인정보의 안전성 확보 조치",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "KUDOG은 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n- 기술적 조치 : 서버, 데이터베이스 접근 권한 관리, JWT 인증 시스템, 개인정보의 암호화"),
                                            Text(
                                              "\n개인정보 보호 책임자",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "1. KUDOG은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보 주체의 불만 처리 및 피해 구제 등을 위하여 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다. 해당 연락처를 통해 개인정보 열람 청구 업무도 신청할 수 있습니다."),
                                            Text(
                                                "- 개인정보 보호 책임자\n- 연락처 : devkor.apply@gmail.com"),
                                            Text(
                                              "\n동의 거부 관리",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                                "사용자는 본 안내에 따른 개인정보 수집 및 이용에 대하여 동의를 거부할 권리가 있습니다. 다만, 개인 정보 수집 동의 거부 시 서비스 사용이 불가능할 수 있습니다.\n이 개인정보 처리 방침은 2024년 1월 16일부터 적용됩니다."),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.all(20.0),
                                            foregroundColor: primary,
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          child: const Text("확인"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "개인정보 처리 방침    ",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  "동의",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: isChecked
                                  ? const Icon(Icons.check_box_outlined)
                                  : const Icon(Icons.check_box_outline_blank))
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                              onPressed: signupService.secondId == 1 &&
                                      nameController.text != "" &&
                                      subscribeController.text != "" &&
                                      emailController.text != "" &&
                                      pwController.text != "" &&
                                      selectedMajor != "" &&
                                      selectedId != "" &&
                                      selectedGrade != "" //모든 정보를 다 기입해야 회원가입
                                  ? () {
                                      if (!isChecked) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                title: const Column(
                                                  children: <Widget>[
                                                    Text("개인정보 처리방침 동의"),
                                                  ],
                                                ),
                                                content: const Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "개인정보 처리방침에 동의해주시기 바랍니다.",
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
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 20),
                                                    ),
                                                    child: const Text("확인"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        SignUpUser user = SignUpUser(
                                            name: nameController.text,
                                            subscriberEmail:
                                                subscribeController.text,
                                            portalEmail: emailController.text,
                                            password: pwController.text,
                                            major: selectedMajor,
                                            studentId: selectedId,
                                            grade: int.parse(selectedGrade[0]));
                                        signupService.SignUp(user);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPageWidget()));
                                      }
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
                                              title: const Column(
                                                children: <Widget>[
                                                  Text("정보 미기입"),
                                                ],
                                              ),
                                              content: const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "모든 정보를 입력하시기 바랍니다",
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
                                                  child: const Text("확인"),
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
                              child: const Text(
                                "회원가입",
                                style: TextStyle(
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
        padding: const EdgeInsets.only(left: 15),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.55,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFFCDCDCD)),
            borderRadius: BorderRadius.circular(208),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.38,
              child: TextFormField(
                controller: widget.controller,
                autofocus: true,
                autofillHints: const [AutofillHints.email],
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.label,
                  labelStyle: const TextStyle(
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
                    child: Text(
                      formatTime(widget.value),
                      style: const TextStyle(
                        color: Color(0xFFDA4949),
                        fontSize: 14,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Visibility(
                    visible: widget.visible,
                    child: Image.asset("assets/images/verified.png",
                        width: 14, height: 14, color: const Color(0xff06C755)),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: TextFormField(
        controller: controller,
        autofocus: true,
        autofillHints: const [AutofillHints.email],
        obscureText: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Readex Pro',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: primaryText,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFCDCDCD),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: alternate,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: alternate,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          filled: true,
          fillColor: secondaryBackground,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
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
          padding: const EdgeInsets.fromLTRB(20, 4, 0, 2),
          child: Text(
            text,
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
                padding: const EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                child: Text(
                  type,
                  style: const TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: secondaryText,
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            autofillHints: const [AutofillHints.email],
            obscureText: false,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: primaryText,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFCDCDCD),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              filled: true,
              fillColor: secondaryBackground,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
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
                padding: const EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                child: Text(
                  widget.type,
                  style: const TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: secondaryText,
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            onChanged: (value) {
              if (RegExp(r'^[a-z0-9]{6,16}$').hasMatch(value)) {
                isPassed = true;
              }
            },
            controller: widget.controller,
            autofocus: true,
            autofillHints: const [AutofillHints.email],
            obscureText: true,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(
                fontFamily: 'Readex Pro',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: primaryText,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFCDCDCD),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              filled: true,
              fillColor: secondaryBackground,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Message(
            text: widget.type == "비밀번호"
                ? '6-16자 영문 소문자, 숫자를 사용하세요.'
                : '비밀번호가 일치하지 않습니다.',
            color: const Color(0xFFCE4040),
            visible: widget.type == "비밀번호" ? !isPassed : !isSame)
      ],
    );
  }
}
