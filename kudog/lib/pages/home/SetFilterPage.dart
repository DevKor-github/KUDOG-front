import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/util/List.dart';
import 'package:provider/provider.dart';

class SetFilterPageWidget extends StatefulWidget {
  const SetFilterPageWidget({Key? key}) : super(key: key);

  @override
  _SetFilterPageWidgetState createState() => _SetFilterPageWidgetState();
}

class _SetFilterPageWidgetState extends State<SetFilterPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> dates = ["오늘", "1주", "1개월", "3개월"];
  Filter setFilter = Filter();
  Map<String, dynamic> filters = {
    "providers": [],
    "categories": [],
    "startDate": "",
    "endDate": ""
  };
  @override
  void initState() {
    super.initState();
  }

  void changeFilter(String filter, String whichFilter) {
    setState(() {
      if (whichFilter == "providers" || whichFilter == "categories") {
        filters[whichFilter].add(filter);
      } else {
        filters[whichFilter] = filter;
      }
    });
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
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                NavigationPageWidget(
                                    filter: Filter(
                                        categories: ["공지사항"],
                                        providers: ["정보대학"],
                                        startDate: "2024-04-01",
                                        endDate: "2024-04-06",
                                        page: 1)),
                          ),
                        );
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: List.generate(
                                  majors.length,
                                  (index) => GestureDetector(
                                      onTap: () {
                                        changeFilter(
                                            majors[index], "providers");
                                      },
                                      child: MajorCard(major: majors[index]))))
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
                            children: List.generate(
                                dates.length,
                                (index) => GestureDetector(
                                    onTap: () {
                                      if (dates[index] == "오늘") {
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            "startDate");
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            "endDate");
                                      } else if (dates[index] == "1주") {
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.now().subtract(
                                                    Duration(days: 7))),
                                            "startDate");
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            "endDate");
                                      } else if (dates[index] == "1개월") {
                                        DateTime currentDate = DateTime.now();
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime(
                                                    currentDate.year,
                                                    currentDate.month - 1,
                                                    currentDate.day)),
                                            "startDate");
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            "endDate");
                                      } else {
                                        DateTime currentDate = DateTime.now();
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime(
                                                    currentDate.year - 1,
                                                    currentDate.month,
                                                    currentDate.day)),
                                            "startDate");
                                        changeFilter(
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                            "endDate");
                                      }
                                    },
                                    child: DateCard(date: dates[index]))),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: List.generate(
                                    categories.length,
                                    (index) => GestureDetector(
                                        onTap: () {
                                          changeFilter(
                                              categories[index], "categories");
                                        },
                                        child: CategoryCard(
                                            category: categories[index]))),
                              ))
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
  final String major;
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
                widget.major,
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
          width: 135,
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
