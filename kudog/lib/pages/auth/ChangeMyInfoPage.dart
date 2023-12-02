import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';

String selectedMajor = '컴퓨터학과'; // 기본값 설정
String selectedValue2 = '21학번'; // 기본값 설정
String selectedValue1 = '2학년'; // 기본값 설정

class ChangemyinfoPageWidget extends StatefulWidget {
  const ChangemyinfoPageWidget({Key? key}) : super(key: key);

  @override
  _ChangemyinfoPageWidgetState createState() => _ChangemyinfoPageWidgetState();
}

class _ChangemyinfoPageWidgetState extends State<ChangemyinfoPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Dio _dio = Dio();

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
              fontSize: 32,
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
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                        child: Text(
                          '이름',
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      Container(
                        width: 357,
                        child: TextFormField(
                          //controller: nameController,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '고은',
                            labelStyle: TextStyle(
                              fontFamily: 'Noto Sans KR',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000),
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
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                          ),
                        ),
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
                          '이메일',
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      Container(
                        width: 357,
                        child: Container(
                          width: 357,
                          child: TextFormField(
                            //controller: emailController,
                            autofocus: true,
                            autofillHints: [AutofillHints.email],
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'ⓘ 학교 이메일로 입력해주세요.',
                              labelStyle: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000),
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
                                  color: Color(0xFFCDCDCD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFCDCDCD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFCDCDCD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
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
                          '구독용 이메일',
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      Container(
                        width: 357,
                        child: TextFormField(
                          //controller: subscribeController,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'ⓘ 수신 받을 이메일을 입력해주세요.',
                            labelStyle: TextStyle(
                              fontFamily: 'Noto Sans KR',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000),
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
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
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
                          '비밀번호 변경',
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Container(
                          width: 357,
                          child: TextFormField(
                            //controller: pwController,
                            autofocus: true,
                            autofillHints: [AutofillHints.email],
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'ⓘ 6-16자 / 영문 소문자, 숫자 사용가능',
                              labelStyle: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA4A4A4),
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
                                  color: Color(0xFFCDCDCD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFCDCDCD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFCDCDCD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      Container(
                        width: 357,
                        child: TextFormField(
                          //controller: pwConfirmController,
                          autofocus: true,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'ⓘ 한 번 더 입력해주세요.',
                            labelStyle: TextStyle(
                              fontFamily: 'Noto Sans KR',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFA4A4A4),
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
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFCDCDCD),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
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
                            fontFamily: 'Noto Sans KR',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsetsDirectional.fromSTEB(6, 4, 6, 4),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFCDCDCD), width: 2.0),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: DropdownButton<String>(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMajor = newValue!;
                            });
                          },
                          items: <String>['컴퓨터학과', '데이터과학과']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          itemHeight: 50,
                          style: TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontSize: 16,
                          ),
                          icon: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: Color(0xFF7E7E7E),
                              size: 24,
                            ),
                          ),
                          dropdownColor: Color(0xFFFFFFFF),
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
                                    fontFamily: 'Noto Sans KR',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF7E7E7E),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin:
                                    EdgeInsetsDirectional.fromSTEB(6, 4, 6, 12),
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
                                    fontFamily: 'Noto Sans KR',
                                    fontSize: 16,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Color(0xFF7E7E7E),
                                    size: 24,
                                  ),
                                  dropdownColor: Color(0xFFFFFFFF),
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
                                    fontFamily: 'Noto Sans KR',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF7E7E7E),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin:
                                    EdgeInsetsDirectional.fromSTEB(6, 4, 6, 12),
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
                                    fontFamily: 'Noto Sans KR',
                                    fontSize: 16,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Color(0xFF7E7E7E),
                                    size: 24,
                                  ),
                                  dropdownColor: Color(0xFFFFFFFF),
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
                        onPressed: () {},
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
