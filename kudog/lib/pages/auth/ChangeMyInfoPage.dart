import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/etc/Category.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/UserModel.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangemyinfoPageWidget extends StatefulWidget {
  const ChangemyinfoPageWidget({Key? key}) : super(key: key);

  @override
  _ChangemyinfoPageWidgetState createState() => _ChangemyinfoPageWidgetState();
}

class _ChangemyinfoPageWidgetState extends State<ChangemyinfoPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<_PWInputFormState> pwInputFormKey =
      GlobalKey<_PWInputFormState>();

  final Dio _dio = Dio();
  String selectedMajor = ''; // 기본값 설정
  String selectedGrade = ''; // 기본값 설정
  String selectedId = ''; // 기본값 설정

  late String name;
  late String email;
  late String subscribeEmail;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController subscribeController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    User userInfo = Provider.of<UserInfoService>(context, listen: false).user;
    nameController.text = userInfo.name ?? '';
    emailController.text = userInfo.portalEmail ?? '';
    subscribeController.text = userInfo.subscriberEmail ?? '';
    Majors.sort((a, b) => a.compareTo(b));
    selectedMajor = userInfo.major ?? '';
    print(selectedMajor);
    selectedId = userInfo.studentId ?? '';
    selectedGrade = '${userInfo.grade?.toString()}학년' ?? '1';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateUserInfo() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("access_token");

      if (pwController.text != '' && pwConfirmController.text != '') {
        bool isPassed = pwInputFormKey.currentState?.isPassed ?? false;
        bool isSame = pwInputFormKey.currentState?.isSame ?? false;

        if (RegExp(r'^[a-z0-9]{6,16}$').hasMatch(pwController.text) &&
            pwController.text == pwConfirmController.text) {
          final response = await _dio.put(
            'https://api.kudog.devkor.club/users/info',
            data: {
              "name": nameController.text,
              "studentId": selectedId,
              "grade": int.parse(selectedGrade.substring(0, 1)),
              "major": selectedMajor,
              "subscriberEmail": subscribeController.text,
              "portalEmail": emailController.text,
              "password": pwController.text,
            },
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );
          if (response.statusCode == 200) {
            print("PUT 요청 성공");
            Navigator.pop(context);
            Provider.of<UserInfoService>(context, listen: false).getUserInfo();
          } else {
            print("PUT 요청 실패");
            print("Status Code : ${response.statusCode}");
          }
        } else {
          print("비밀번호 유효성 또는 일치하지 않음");
          print("비번${pwController.text}");
          print("비번확인${pwConfirmController.text}");
        }
      } else {
        final response = await _dio.put(
          'https://api.kudog.devkor.club/users/info',
          data: {
            "name": nameController.text,
            "studentId": selectedId,
            "grade": int.parse(selectedGrade.substring(0, 1)),
            "major": selectedMajor,
            "subscriberEmail": subscribeController.text,
            "portalEmail": emailController.text,
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }),
        );
        if (response.statusCode == 200) {
          print("PUT 요청 성공");
          Navigator.pop(context);
          Provider.of<UserInfoService>(context, listen: false).getUserInfo();
        } else {
          print("PUT 요청 실패");
          print("Status Code : ${response.statusCode}");
        }
      }

      print({
        "name": nameController.text,
        "studentId": selectedId,
        "grade": int.parse(selectedGrade.substring(0, 1)),
        "major": selectedMajor,
        "subscriberEmail": subscribeController.text,
        "portalEmail": emailController.text,
      });
    } catch (error) {
      print("PUT 요청 에러");
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignUpService, UserInfoService>(
        builder: (context, signupService, userInfoService, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          automaticallyImplyLeading: true,
          title: Text(
            '내 정보 수정하기',
            style: TextStyle(
              fontFamily: 'Noto Sans KR',
              color: Color(0xFF000000),
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
            padding: EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputForm(
                          controller: nameController, type: "이름", label: "이름"),
                      EmailInputForm(
                          controller: emailController,
                          type: "이메일",
                          label: "ⓘ 학교 이메일로 입력해주세요."),
                      InputForm(
                          controller: subscribeController,
                          type: "구독용 이메일",
                          label: "ⓘ 수신 받을 이메일을 입력해주세요"),
                      PWInputForm(
                        key: pwInputFormKey,
                        controller: pwController,
                        type: "비밀번호",
                        label: "ⓘ 6-16자 / 영문 소문자, 숫자 사용가능",
                      ),
                      PWInputForm(
                        controller: pwConfirmController,
                        type: pwController.text,
                        label: "ⓘ 한 번 더 입력해주세요.",
                        isPasswordConfirmation: true,
                        originalPassword: pwController.text,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
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
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        margin: EdgeInsetsDirectional.fromSTEB(6, 4, 6, 4),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFCDCDCD), width: 2.0),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedMajor,
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                          style: TextStyle(
                            color: Colors.black,
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
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                margin:
                                    EdgeInsetsDirectional.fromSTEB(6, 4, 6, 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFCDCDCD), width: 2.0),
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
                                  style: TextStyle(
                                    color: Colors.black,
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
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                margin:
                                    EdgeInsetsDirectional.fromSTEB(6, 4, 6, 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFCDCDCD), width: 2.0),
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
                                  items: Grades.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  itemHeight: 50,
                                  style: TextStyle(
                                    color: Colors.black,
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
                    width: 357,
                    child: ElevatedButton(
                        onPressed: updateUserInfo,
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          backgroundColor: Color(0xFFCE4040),
                        ),
                        child: Text(
                          "수정하기",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
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
  const PWInputForm({
    super.key,
    required this.controller,
    required this.type,
    required this.label,
    this.isPasswordConfirmation = false,
    this.originalPassword = '',
  });
  final TextEditingController controller;
  final String type;
  final String label;
  final bool isPasswordConfirmation;
  final String originalPassword;

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

  void updatePasswordValidation(bool passed, bool same) {
    setState(() {
      isPassed = passed;
      isSame = same;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                if (value.isEmpty) {
                  isPassed = false;
                } else if (RegExp(r'^[a-z0-9]{6,16}$').hasMatch(value)) {
                  isPassed = true;
                }
                if (widget.isPasswordConfirmation) {
                  isSame = widget.originalPassword == value;
                }
              });
            },
            controller: widget.controller,
            autofocus: true,
            autofillHints: [AutofillHints.email],
            obscureText: true,
            style: TextStyle(color: Color(0xFFA4A4A4)),
            obscuringCharacter: '●',
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
          visible: widget.type == "비밀번호" ? !isPassed : !isSame,
        )
      ],
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
