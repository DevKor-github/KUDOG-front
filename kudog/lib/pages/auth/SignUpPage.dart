import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({Key? key}) : super(key: key);

  @override
  _SignUpPageWidgetState createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    Text("회원가입",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Container(width: 20)
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  children: [
                    signUpForm(
                        headText: "이름",
                        hintText: "이름",
                        controller: nameController),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                '이메일',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF484848),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputForm(
                                    controller: emailController,
                                    hint: "학교 이메일 입력",
                                    ratio: 0.72),
                                smallClickButton(text: "인증번호")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputForm(
                                    controller: emailController,
                                    hint: "6자리 인증번호",
                                    ratio: 0.72),
                                smallClickButton(text: "확인")
                              ],
                            ),
                          ]),
                    ),
                    signUpForm(
                        headText: "비밀번호",
                        hintText: "비밀번호",
                        controller: pwController),
                    signUpForm(
                        headText: "비밀번호 확인",
                        hintText: "비밀번호 확인",
                        controller: pwConfirmController),
                    clickButton(text: "회원가입")
                  ],
                ))
          ],
        ));
  }
}

class signUpForm extends StatelessWidget {
  const signUpForm(
      {super.key,
      required this.headText,
      required this.hintText,
      required this.controller});
  final String headText;
  final String hintText;
  final TextEditingController controller;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            headText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF484848),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        InputForm(controller: controller, hint: hintText, ratio: 1)
      ]),
    );
  }
}

class smallClickButton extends StatelessWidget {
  const smallClickButton({super.key, required this.text});
  final String text;
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(left: 15),
          // padding: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width * 0.19,
          height: MediaQuery.of(context).size.height * 0.067,
          decoration: ShapeDecoration(
            color: Color(0xFFFF3A46),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ));
  }
}
