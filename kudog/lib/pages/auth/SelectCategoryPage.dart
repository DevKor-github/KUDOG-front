import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/etc/TextStyles.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/SignInService.dart';
import 'package:provider/provider.dart';

class SelectCategoryPageWidget extends StatefulWidget {
  const SelectCategoryPageWidget(
      {super.key, required this.email, required this.password});
  final String email;
  final String password;
  @override
  _SelectCategoryPageWidgetState createState() =>
      _SelectCategoryPageWidgetState();
}

class _SelectCategoryPageWidgetState extends State<SelectCategoryPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? keywordController = TextEditingController();
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
    return Consumer<SignInService>(builder: (context, signInservice, child) {
      return GestureDetector(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: secondaryBackground,
          appBar: AppBar(
            backgroundColor: secondaryBackground,
            iconTheme: const IconThemeData(color: primaryText),
            automaticallyImplyLeading: true,
            title: const Text('카테고리 구독',
                style: TextStyle(
                    fontFamily: "NotoSans-Regular",
                    color: primaryText,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            actions: const [],
            centerTitle: false,
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                    child: SizedBox(
                      width: 370,
                      child: TextFormField(
                        controller: keywordController,
                        autofocus: true,
                        autofillHints: const [AutofillHints.email],
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: '검색어를 입력하세요.',
                          labelStyle: const TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: secondaryText,
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
                          contentPadding:
                              const EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                        style: bodyMedium,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            LoginUser user = LoginUser(
                                email: widget.email, password: widget.password);
                            signInservice.Signin(user);
                            if (signInservice.successLogin) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginPageWidget())); //로그인 페이지로 가도록 수정
                            }
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
                            "쿠독 시작하기",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
