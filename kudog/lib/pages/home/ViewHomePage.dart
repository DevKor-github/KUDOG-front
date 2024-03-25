import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewHomePageWidget extends StatefulWidget {
  const ViewHomePageWidget({super.key});
  @override
  _ViewHomePageWidgetState createState() => _ViewHomePageWidgetState();
}

class _ViewHomePageWidgetState extends State<ViewHomePageWidget>
    with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  @override
  List<String> majorList = ["전체", "디자인조형학부", "컴퓨터학과", "미디어학부", "경영대학"];
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
        body: Container(
            child: Column(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            alignment: Alignment.center,
                            width: 32,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF4F1F1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              '알림',
                              style: TextStyle(
                                color: Color(0xFFFF4F59),
                                fontSize: 10,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '구독함A',
                                  style: TextStyle(
                                    color: Color(0xFFFF3A46),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '에\n새로운 글이 올라왔어요!',
                                  style: TextStyle(
                                    color: Color(0xFF222222),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Image.asset("assets/images/alarm.png"))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200], // 배경색 변경
                      labelText: '키워드로 검색하세요.',
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xFFD9D9D9)),
                      contentPadding: EdgeInsets.all(24.0),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Color(0xffFF3B47)),
                          onPressed: () {}),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: majorList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(right: 40),
                              child: Text(majorList[index],
                                  style: TextStyle(
                                    color: Color(0xFF787474),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  )));
                        }))
              ],
            )),
        Container(
            margin: EdgeInsets.only(left: 18, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        color: Color(0xFFF4F1F1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFFFD8DA)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '오늘',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFF3A46),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        color: Color(0x7FFFD8DA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '공지사항, 학사일정',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFF3A46),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetFilterPageWidget()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 18, bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        color: Color(0xFFF4F1F1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 20,
                              height: 20,
                              child: Image.asset("assets/images/filter.png")),
                          Text(
                            '전체',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF787474),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            )),
        Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return NoticeCard();
                }))
      ],
    )));
  }
}

class NoticeCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 43,
                  height: 18,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF4F1F1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '공지사항',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF787474),
                          fontSize: 10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '디자인조형학부 짱',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 12,
                        height: 12,
                        child: Image.asset("assets/images/new.png"))
                  ],
                ),
                Text(
                  '2024. 01. 02',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF787474),
                    fontSize: 10,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            Container(
                width: 22,
                height: 22,
                child: Image.asset("assets/images/scrabbed.png"))
          ],
        ));
  }
}
