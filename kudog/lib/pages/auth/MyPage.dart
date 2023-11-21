import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/AuthModel.dart';
import 'package:kudog/model/MailModel.dart';
import 'package:kudog/service/SignUpService.dart';
import 'package:provider/provider.dart';
import 'package:charcode/ascii.dart';
import 'package:charcode/html_entity.dart';
import 'package:dio/dio.dart';



class MyPageWidget extends StatefulWidget {
  const MyPageWidget({Key? key}) : super(key: key);

  @override
  _MyPageWidgetState createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Dio _dio = Dio();
  bool _isSwitched = false; // 스위치 상태를 관리할 변수

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
        backgroundColor: Color(0xFFCE4040),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 59,
                margin: EdgeInsets.only(left: 24, right: 24,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/minilogo.png', width: 58, height: 22.23,),
                    Text('마이페이지',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Noto Sans KR",
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),),
                    Image.asset('assets/bell.png', width: 16, height: 21.89, alignment: Alignment.centerRight,),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * 729/788,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -4),
                      blurRadius: 8,
                      color: Color.fromRGBO(105, 56, 56, 0.15),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child:
                Column(
                  children: [
                    SizedBox(height: 38),
                    Container(
                      padding: EdgeInsets.only(left: 24, right: 24,),
                      child : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("홍길동",
                            style: TextStyle(
                              fontFamily: "Noto Sans KR",
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF444444),
                            ),),
                          Container(
                            width: 48,
                            height: 27.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(39),
                              border: Border.all(color: Color(0xFFA4A4A4), width: 1),
                            ),
                            padding: EdgeInsets.fromLTRB(13, 4, 12, 6.27),
                            child: Text("편집",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily: "Noto Sans KR",
                              ),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67/788,
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6)),
                      padding: EdgeInsets.fromLTRB(24, 19, 24, 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children : [
                          Text("공지사항 메일 수신",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),),
                          CustomSwitch(
                            value: _isSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 26),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67/788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("서비스 소개",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),),
                          Image.asset('assets/right_sign.png', width: 13, height: 19,),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67/788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("FAQ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),),
                          Image.asset('assets/right_sign.png', width: 13, height: 19,),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67/788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("문의하기",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),),
                          Image.asset('assets/right_sign.png', width: 13, height: 19,),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67/788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("로그아웃",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),),
                          Image.asset('assets/right_sign.png', width: 13, height: 19,),
                        ],
                      ),
                    ),
                  ],
                ),


              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/subscribe_gray.png'),
              Image.asset('assets/hot_gray.png'),
              Image.asset('assets/home_gray.png'),
              Image.asset('assets/bookmark_gray.png'),
              Image.asset('assets/mypage_red.png'),
            ],
          ),
        ),
      );
    });
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 60, // 스위치의 가로 크기 조절
        height: 30, // 스위치의 세로 크기 조절
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), // 버튼의 모양을 원하는 대로 조절
          color: widget.value ? Color(0xFFCE4040) : Color(0xFFA4A4A4), // 활성 및 비활성 상태에 따른 색상 설정
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: widget.value ? 30.0 : 0.0, // 버튼의 위치를 움직이는 애니메이션
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // 원 모양 버튼
                  color: Colors.white, // 버튼의 색상
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
