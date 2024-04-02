import 'package:flutter/material.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class SetFilterPageWidget extends StatefulWidget {
  const SetFilterPageWidget({Key? key}) : super(key: key);

  @override
  _SetFilterPageWidgetState createState() => _SetFilterPageWidgetState();
}

class _SetFilterPageWidgetState extends State<SetFilterPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> majors = ["전체", "정보대학", "공과대학", "디자인조형학부", "미디어학부", "경영대학"];
  List<String> dates = ["오늘", "1주", "1개월", "3개월"];
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
  List<UpperCategory> upperCategoryList = [];

  Future<List<UpperCategory>> _loadUpperCategories() async {
    //학과 리스트를 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false)
        .getUpperCategories();
    upperCategoryList =
        Provider.of<NoticeService>(context, listen: false).upperCategoryList;
    upperCategoryList.insert(0, UpperCategory(name: "전체"));
    return upperCategoryList;
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      child: Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Text("필터",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  Container(width: 20)
                ],
              )),
          Column(
            children: [
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("적용된 필터",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset("assets/images/trash.png",
                                  color: Color(0xff787474)))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF4F1F1),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xFFFFD8DA)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                            ],
                          )),
                    ],
                  )),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                      '학과',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF1B1616),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 20,
                                    )),
                                Icon(Icons.edit_outlined,
                                    color: Color(0xff787474))
                              ],
                            ),
                          ),
                          FutureBuilder(
                              future: _loadUpperCategories(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData == false) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                } else {
                                  return GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemCount: upperCategoryList.length,
                                      itemBuilder: (context, index) =>
                                          MajorCard(
                                              major: upperCategoryList[index]));
                                }
                              }),
                        ],
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 30, bottom: 10),
                                    child: Text(
                                      '조회기간',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF1B1616),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(
                                right: 20,
                              )),
                          Container(
                              child: Row(
                            children: [
                              DateCard(date: dates[0]),
                              DateCard(date: dates[1]),
                              DateCard(date: dates[2]),
                              DateCard(date: dates[3])
                            ],
                          )),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 9, left: 14, right: 8, bottom: 9),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF4F1F1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '2023. 10. 01',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF423C3C),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child:
                                            Icon(Icons.calendar_month_outlined))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8, right: 8),
                                child:
                                    Text("-", style: TextStyle(fontSize: 30)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 9, left: 14, right: 8, bottom: 9),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF4F1F1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '2023. 10. 05',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF423C3C),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child:
                                            Icon(Icons.calendar_month_outlined))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                      Container(
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
                                      color: Color(0xFF1B1616),
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
                      ))
                    ],
                  ))
            ],
          ),
        ],
      ),
    ));
  }
}

class MajorCard extends StatefulWidget {
  const MajorCard({super.key, required this.major});
  final UpperCategory major;
  @override
  _MajorCardState createState() => _MajorCardState();
}

class _MajorCardState extends State<MajorCard> {
  @override
  bool isClicked = false;
  void initState() {
    super.initState();
  }

  void changeColor() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: changeColor,
        child: Container(
          width: 100.0, // 너비
          height: 100.0,
          margin: EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: isClicked ? Color(0xFFFFD8DA) : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: isClicked ? Color(0xFFFF3A46) : Color(0xFF423C3C)),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isClicked
                  ? Icon(Icons.check, color: Color(0xFFFF3A46))
                  : Container(),
              Text(
                widget.major.name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF423C3C),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }
}

class DateCard extends StatefulWidget {
  const DateCard({super.key, required this.date});
  final String date;
  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  @override
  bool isClicked = false;
  void initState() {
    super.initState();
  }

  void changeColor() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: changeColor,
        child: Container(
          margin: EdgeInsets.all(3),
          height: 40,
          width: 70,
          decoration: ShapeDecoration(
            color: isClicked ? Color(0xE5FF3A46) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isClicked ? Colors.white : Color(0xFF423C3C),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category});
  final String category;
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  bool isClicked = false;
  void initState() {
    super.initState();
  }

  void changeColor() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: changeColor,
        child: Container(
          width: 125,
          margin: EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: isClicked ? Color(0xFFFFD8DA) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isClicked ? Color(0xFFFF3A46) : Colors.black,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
              isClicked ? Icon(Icons.close, color: Colors.white) : Container(),
            ],
          ),
        ));
  }
}
