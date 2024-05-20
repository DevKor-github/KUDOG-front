import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:kudog/service/SignUpService.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool isSame = false;
  bool isSend = false; //인증이메일 보내졌는지
  bool isVerified = false; //코드 맞는지
  String firstAnswer = "";
  String secondAnswer = "";

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
    return Consumer<SignUpService>(builder: (context, signUpService, child) {
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
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: signUpForm(
                            headText: "이름",
                            hintText: "  이름",
                            controller: nameController),
                      ),
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
                                      hint: "  학교 이메일 입력",
                                      ratio: 0.72),
                                  GestureDetector(
                                      onTap: () async {
                                        await signUpService.SendEmail(
                                            emailController.text);
                                        if (signUpService.isSend) {
                                          setState(() {
                                            isSend = true;
                                            firstAnswer =
                                                signUpService.firstAnswer;
                                          });
                                        } else {
                                          setState(() {
                                            firstAnswer =
                                                signUpService.firstAnswer;
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 15),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.067,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFFF3A46),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "인증번호",
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
                                      ))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputForm(
                                      controller: codeController,
                                      hint: "  6자리 인증번호",
                                      ratio: 0.72),
                                  GestureDetector(
                                      onTap: () async {
                                        if (isSend) {
                                          await signUpService.VerifyEmail(
                                              emailController.text,
                                              codeController.text);
                                          if (signUpService.secondId == 1) {
                                            setState(() {
                                              isVerified = true;
                                              firstAnswer =
                                                  signUpService.secondAnswer;
                                            });
                                          } else {
                                            setState(() {
                                              firstAnswer =
                                                  signUpService.secondAnswer;
                                            });
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertMessage(
                                                    title: "인증 번호 전송 필요",
                                                    content:
                                                        "인증 번호가 전송되지 않았습니다.");
                                              });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 15),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.067,
                                        decoration: ShapeDecoration(
                                          color: isSend
                                              ? Color(0xFFFF3A46)
                                              : Color(0xffCCC9C9),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "확인",
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
                                      ))
                                ],
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Message(
                                        text: firstAnswer,
                                        color: isSend
                                            ? Color(0xFF06C755)
                                            : Color(0xffFF3B47),
                                        visible: true),
                                  ]),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: signUpForm(
                            headText: "비밀번호",
                            hintText: "  비밀번호",
                            controller: passwordController),
                      ),
                      signUpForm(
                          headText: "비밀번호 확인",
                          hintText: "  비밀번호 확인",
                          controller: passwordConfirmController),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Message(
                                text: secondAnswer,
                                color: Color(0xffFF3B47),
                                visible: passwordController.text ==
                                    passwordConfirmController.text),
                          ]),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    if (isVerified) {
                                      await signUpService.SignUp(SignUpUser(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text));
                                      if (signUpService.isSuccess) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                      '회원가입 완료!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1B1616),
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'Pretendard',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LoginPageWidget()));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 4),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color:
                                                              Color(0xffFF3B47),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "확인",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFFffffff),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Pretendard',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              );
                                            });
                                      } else {
                                        setState(() {
                                          secondAnswer =
                                              "ⓘ 앞서 입력한 비밀번호와 일치하지 않아요.";
                                        });
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertMessage(
                                                title: "이메일 인증 필요",
                                                content: "이메일 인증이 필요합니다.");
                                          });
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 4),
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFFF3A46),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "회원가입",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ))
                    ],
                  ))
            ],
          ));
    });
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
          padding: const EdgeInsets.fromLTRB(5, 4, 0, 2),
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

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Column(
        children: <Widget>[
          Text(title),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            content,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            foregroundColor: primary,
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: const Text("확인"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
