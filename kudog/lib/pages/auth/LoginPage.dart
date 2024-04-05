import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/pages/auth/SignUpPage.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:provider/provider.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    return Consumer<SignInService>(
      builder: (context, signInService, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
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
                                color: Color(0xff423D3D),
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
                            color: Color(0xffF4F2F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "이메일",
                              fillColor: const Color(0xffF4F2F2),
                              hintStyle: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFFA4A4A4),
                              ),
                            ),
                          )),
                      // InputForm(
                      //   controller: emailController,
                      //   hint: "이메일",
                      //   ratio: 1,
                      // ),
                      // InputForm(
                      //     controller: passwordController, hint: "비밀번호", ratio: 1),
                      Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: Color(0xffF4F2F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: Colors.black,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "비밀번호",
                              fillColor: const Color(0xffF4F2F2),
                              hintStyle: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFFA4A4A4),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NavigationPageWidget()));
                            } else {
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
                                          Text("로그인 실패"),
                                        ],
                                      ),
                                      content: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "아이디와 비밀번호를 확인해주십시오.",
                                          ),
                                        ],
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
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 4),
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF3A46),
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
                                    color: Colors.white,
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
                                  color: Color(0xFF787474),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '|',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF787474),
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
                                      color: Color(0xFF787474),
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
        // onTap: () {
        //   setState(() {
        //     _isFocused = !_isFocused;
        //   });
        // },
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
