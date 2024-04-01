import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';

class ViewSubscribeFilterPageWidget extends StatefulWidget {
  const ViewSubscribeFilterPageWidget({Key? key}) : super(key: key);

  @override
  _ViewSubscribeFilterPageWidgetState createState() =>
      _ViewSubscribeFilterPageWidgetState();
}

class _ViewSubscribeFilterPageWidgetState
    extends State<ViewSubscribeFilterPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> majors = ["전체", "정보대학", "공과대학", "디자인조형학부", "미디어학부", "경영대학"];
  List<String> categories = [
    "학부",
    "대학원",
    "교내 장학",
    "교외 장학",
    "근로 장학",
    "학사 일정",
    "학사자료실",
    "자유게시판",
    "공모전",
    "채용정보",
    "행사"
  ];

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
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('구독 설정'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          child: ListView(children: [
            Container(
              margin: EdgeInsets.only(bottom: 21),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이름',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: gray4,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 21),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이메일',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: gray4,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Container(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                            '학과',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          margin: EdgeInsets.only(
                            right: 12,
                          )),
                      Icon(Icons.edit_outlined)
                    ],
                  ),
                ),
                Row(
                  children: [
                    MajorCard(major: majors[0]),
                    MajorCard(major: majors[1]),
                    MajorCard(major: majors[2])
                  ],
                ),
                Row(
                  children: [
                    MajorCard(major: majors[3]),
                    MajorCard(major: majors[4]),
                    MajorCard(major: majors[5])
                  ],
                )
              ],
            )),
            Container(
                margin: EdgeInsets.only(bottom: 26),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              '카테고리',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            CategoryCard(category: categories[0]),
                            CategoryCard(category: categories[1]),
                            CategoryCard(category: categories[2]),
                            CategoryCard(category: categories[3]),
                            CategoryCard(category: categories[4])
                          ],
                        ),
                        Column(
                          children: [
                            CategoryCard(category: categories[5]),
                            CategoryCard(category: categories[6]),
                            CategoryCard(category: categories[7]),
                            CategoryCard(category: categories[8]),
                            CategoryCard(category: categories[9])
                          ],
                        )
                      ],
                    )
                  ],
                )),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  minimumSize: Size.fromHeight(40),
                  backgroundColor: red1),
              child: const Text(
                '저장',
                style: TextStyle(color: white),
              ),
            )
          ]),
        ));
  }
}
