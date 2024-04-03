import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
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
                  LoginForm(controller: emailController, hint: "이메일"),
                  LoginForm(controller: passwordController, hint: "비밀번호"),
                  GestureDetector(
                      onTap: () {},
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
                              '로그인',
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
                          Text(
                            '회원가입',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF787474),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0.15,
                            ),
                          )
                        ],
                      ))
                ]),
              )
            ],
          )),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Color(0xffF4F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: controller,
          decoration: InputDecoration(
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
        ));
  }
}
