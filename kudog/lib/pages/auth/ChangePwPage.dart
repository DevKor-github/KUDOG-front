import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:provider/provider.dart';

class ChangepwPageWidget extends StatefulWidget {
  final String email;

  const ChangepwPageWidget({Key? key, required this.email}) : super(key: key);

  @override
  _ChangepwPageWidgetState createState() => _ChangepwPageWidgetState();
}

class _ChangepwPageWidgetState extends State<ChangepwPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Provider.of<ChangePwService>(context, listen: false).RequestCode();
    //Provider.of<ChangePwService>(context, listen: false).VerifyCode();
    //Provider.of<ChangePwService>(context, listen: false).ChangePw();
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
            '비밀번호 변경',
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
                    "새 비밀번호",
                    style: TextStyle(
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF7E7E7E),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFD9D9D9),
                      decorationThickness: 0.2,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
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
                              controller: newPasswordController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              style: const TextStyle(color: Color(0xFFA4A4A4)),
                              obscuringCharacter: '●',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                newPasswordController.clear();
                              });
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: 14,
                              height: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: const Row(
                    children: [
                      Text(
                        'ⓘ 6-16자 영문 소문자, 숫자를 사용하세요.',
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
                  margin: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
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
                              controller: confirmPasswordController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              style: const TextStyle(color: Color(0xFFA4A4A4)),
                              obscuringCharacter: '●',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                confirmPasswordController.clear();
                              });
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: 14,
                              height: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: const Row(
                    children: [
                      Text(
                        'ⓘ 비밀번호가 일치하지 않습니다.',
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
                  margin: const EdgeInsets.fromLTRB(18, 28, 18, 18),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 47,
                    child: GestureDetector(
                      onTap: () {
                        if (isValidPassword(newPasswordController.text) &&
                            newPasswordController.text ==
                                confirmPasswordController.text) {
                          savePassword(newPasswordController.text);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFCE4040),
                          borderRadius: BorderRadius.circular(58),
                        ),
                        child: InkWell(
                          onTap: () {
                            changePwService.ChangePw(
                                widget.email, newPasswordController.text);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginPageWidget()));
                          },
                          child: const Text(
                            "비밀번호 저장",
                            style: TextStyle(
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  bool isValidPassword(String password) {
    RegExp regex = RegExp(r'^[a-z0-9]{6,16}$');
    return regex.hasMatch(password);
  }

  void savePassword(String password) {}
}
