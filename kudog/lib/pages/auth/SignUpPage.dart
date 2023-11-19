import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/MailModel.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({Key? key}) : super(key: key);

  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedValue1 = "1학년";
  String selectedValue2 = "23학번";
  String selectedMajor = "컴퓨터학과";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController subscribeController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();

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
                                  Container(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          EmailInputForm(
                                              controller: codeController,
                                              type: "인증번호",
                                              label: "ⓘ 인증번호를 입력해주세요."),
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
                                      ))
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
                      InputForm(
                        controller: subscribeController,
                        type: "비밀번호",
                        label: "ⓘ 6-16자 / 영문 소문자, 숫자 사용가능",
                      ),
                      InputForm(
                        controller: subscribeController,
                        type: "",
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
                              },
                              items: <String>[
                                '컴퓨터학과',
                                '데이터과학과'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                                      value: selectedValue2,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue2 = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        '14학번',
                                        '15학번',
                                        '16학번',
                                        '17학번',
                                        '18학번',
                                        '19학번',
                                        '20학번',
                                        '21학번',
                                        '22학번',
                                        '23학번',
                                      ].map<DropdownMenuItem<String>>(
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
                                      value: selectedValue1,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue1 = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        '1학년',
                                        '2학년',
                                        '3학년',
                                        '4학년',
                                        '5학년',
                                        '6학년',
                                      ].map<DropdownMenuItem<String>>(
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
                                          major: "컴퓨터학과",
                                          studentId: "19",
                                          grade: 3);
                                      signupService.SignUp(user);
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
                                                    "이메일 인증 후 후원 글을 작성할 수 있습니다.",
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
