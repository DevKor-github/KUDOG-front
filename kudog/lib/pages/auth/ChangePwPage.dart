import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/ChangePwService.dart';
import 'package:provider/provider.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/pages/auth/SignUpPage.dart' show Message;

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
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
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
            padding: EdgeInsetsDirectional.fromSTEB(18, 40, 18, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40),
                  height: 22,
                  child: Text(
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

                PWInputForm(
                  controller: newPasswordController,
                  type: "비밀번호",
                  label: "ⓘ 6-16자 / 영문 소문자, 숫자 사용가능",
                ),
                PWInputForm(
                  controller: confirmPasswordController,
                  type: newPasswordController.text,
                  label: "ⓘ 한 번 더 입력해주세요.",
                ),
















                /*
                Container(
                  margin: EdgeInsets.fromLTRB(18, 18, 18, 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 47,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(24, 12, 22, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(208),
                        border: Border.all(color: Color(0xFFCDCDCD), width: 2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              style: TextStyle(color: Color(0xFFA4A4A4)),
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
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
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
                  margin: EdgeInsets.fromLTRB(18, 18, 18, 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 47,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(24, 12, 22, 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(208),
                        border: Border.all(color: Color(0xFFCDCDCD), width: 2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              style: TextStyle(color: Color(0xFFA4A4A4)),
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
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
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
                */


                Container(
                  margin: EdgeInsets.fromLTRB(18, 28, 18, 18),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 47,
                    child: GestureDetector(
                      onTap: () {
                        if (isValidPassword(newPasswordController.text) &&
                            newPasswordController.text == confirmPasswordController.text) {
                          changePwService.ChangePw(
                              widget.email, newPasswordController.text);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginPageWidget()));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFCE4040),
                          borderRadius: BorderRadius.circular(58),
                        ),
                        child: Text(
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

  void savePassword(String password) {
    print("Password saved: $password");
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
            obscureText: true,
            obscuringCharacter: "●",
            style: TextStyle(color: Color(0xFFA4A4A4)),
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
