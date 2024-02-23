import 'package:flutter/material.dart';
import 'package:kudog/model/UserModel.dart';
import 'package:kudog/pages/auth/ChangeMyInfoPage.dart';
import 'package:kudog/pages/auth/DeleteUserPage.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:kudog/service/SignOutService.dart';
import 'package:kudog/service/UserInfoService.dart';
import 'package:provider/provider.dart';

class ViewMyPageWidget extends StatefulWidget {
  const ViewMyPageWidget({Key? key}) : super(key: key);

  @override
  _ViewMyPageWidgetState createState() => _ViewMyPageWidgetState();
}

class _ViewMyPageWidgetState extends State<ViewMyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserInfoService>(context, listen: false).getUserInfo();
    Provider.of<UserInfoService>(context, listen: false).getUserSubscribing();
  }

  @override
  void didPop() {
    Provider.of<UserInfoService>(context, listen: false).getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserInfoService, SignOutService>(
        builder: (context, userInfoService, signOutService, child) {
      User userInfo = userInfoService.user;
      bool usersubstate = userInfoService.usersub;

      return Scaffold(
        backgroundColor: Color(0xFFCE4040),
        body: Column(
          children: [
            Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xFFCE4040),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 88,
                      margin: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/icon_6.png",
                            width: 21.21,
                            height: 21.34,
                            color: Colors.white,
                          ),
                          Image.asset(
                            "assets/images/icon_7.png",
                            width: 36.79,
                            height: 21.34,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '마이페이지',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 88,
                      margin: EdgeInsets.all(15),
                      child: Image.asset(
                        "assets/images/icon_8.png",
                        width: 36.79,
                        height: 21.34,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userInfo.name!,
                            style: TextStyle(
                              fontFamily: "Noto Sans KR",
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF444444),
                            ),
                          ),
                          Container(
                            child: IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(39),
                                  border: Border.all(
                                      color: Color(0xFFA4A4A4), width: 1),
                                ),
                                padding: EdgeInsets.fromLTRB(13, 6.27, 12, 6.27),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangemyinfoPageWidget()),
                                    );
                                  },
                                  child: Text(
                                    "편집",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: "Noto Sans KR",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67 / 788,
                      decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
                      padding: EdgeInsets.fromLTRB(24, 19, 24, 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "공지사항 메일 수신",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),
                          ),
                          CustomSwitch(
                            value: usersubstate,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                              });
                              Provider.of<UserInfoService>(context, listen: false).putUserSubscribing();
                              Provider.of<UserInfoService>(context, listen: false).getUserSubscribing();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 26),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67 / 788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "서비스 소개",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67 / 788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "FAQ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67 / 788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "문의하기",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "Noto Sans KR",
                              color: Color(0xFF444444),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 67 / 788,
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: InkWell(
                        onTap: () {
                          signOutService.SignOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginPageWidget()));
                        }, //Pop 반복
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "로그아웃",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontFamily: "Noto Sans KR",
                                color: Color(0xFF444444),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 200),
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DeleteUserPageWidget()),
                          );
                        },
                          child: Text(
                              "회원 탈퇴하기",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                fontFamily: "Noto Sans KR",
                                color: Color(0xFFCDCDCD),
                              )
                          )
                      )

                    ),
                  ],
                ),
              ),
            ),
          ],
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
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.value
              ? Color(0xFFCE4040)
              : Color(0xFFA4A4A4),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: widget.value ? 30.0 : 0.0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
