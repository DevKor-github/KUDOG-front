import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';

class ViewPostDetailPageWidget extends StatefulWidget {
  const ViewPostDetailPageWidget({Key? key}) : super(key: key);

  @override
  _ViewPostDetailPageWidgetState createState() =>
      _ViewPostDetailPageWidgetState();
}

class _ViewPostDetailPageWidgetState extends State<ViewPostDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isClicked = false;
  void changeIcon() {
    setState(() {
      isClicked = !isClicked;
    });
  }

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
      key: scaffoldKey,
      backgroundColor: secondaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25, 52, 25, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 99,
                      height: 19,
                      child: Text(
                        'KUPID 전체',
                        style: TextStyle(
                          color: Color(0xFFCE4040),
                          fontSize: 12,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    Container(
                        child: Text(
                      '[서울 학부] 2022학년도 2학기 학부 2차 폐강 교과목 안내',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    )),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                height: 19.08,
                                child: Text(
                                  '교무처',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF7E7E7E),
                                    fontSize: 12,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: 100,
                                height: 19.08,
                                child: Text(
                                  '2022-09-15',
                                  style: TextStyle(
                                    color: Color(0xFF7E7E7E),
                                    fontSize: 12,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 19.08,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 0, 0),
                                  child: ImageIcon(
                                    size: 14,
                                    AssetImage("assets/images/icon_11.png"),
                                    color: Color(0xFF7E7E7E),
                                  )),
                              Container(
                                height: 19.08,
                                alignment: Alignment.topLeft,
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                child: Text(
                                  '142',
                                  style: TextStyle(
                                    color: Color(0xFF7E7E7E),
                                    fontSize: 12,
                                    fontFamily: 'Noto Sans KR',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Container(
                                  height: 19.08,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: ImageIcon(
                                    size: 14,
                                    AssetImage("assets/images/icon_12.png"),
                                    color: Color(0xFF7E7E7E),
                                  )),
                              Container(
                                  height: 19.08,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      3, 0, 0, 0),
                                  child: Text(
                                    '20',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF7E7E7E),
                                      fontSize: 12,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '1. 2022학년도 2학기 학부 2차 최종 폐강 교과목을 아래와 같이 안내합니다﻿.\n\n \n\n2. 2차 폐강 교과목을 신청한 학생들은 폐강 교과목이 자동 삭제처리 되오니, 폐강교과목 신청학생 수강신청 기간을 이용하여 수강신청 정정을 완료하여 주시기 바랍니다.\n\n URL: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'https://sugang.korea.ac.kr/\n',
                              style: TextStyle(
                                color: Color(0xFFCE4040),
                                fontSize: 16,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n\n\n3. 폐강교과목 신청학생 수강신청: 9.15(목) 18:30 ~ 9.16(금) 09:00 \n\n\n\n※ 2022-2학기 학부 2차 폐강 교과목 목록(서울)은 붙임 파일을 확인하여 주시기 바랍니다.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height: 66,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Color(0xFFCE4040),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x55000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: ImageIcon(
                            color: Color(0xffFFFFFF),
                            AssetImage(
                              "assets/images/icon_13.png",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          changeIcon();
                        },
                        child: Container(
                          child: ImageIcon(
                            color: Color(0xffFFFFFF),
                            AssetImage(
                              isClicked
                                  ? "assets/images/icon_15.png"
                                  : "assets/images/icon_16.png",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                        child: ImageIcon(
                          color: Color(0xffFFFFFF),
                          AssetImage(
                            "assets/images/icon_14.png",
                          ),
                        ),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
