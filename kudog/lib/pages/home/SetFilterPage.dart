import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/util/Filter.dart';
import 'package:kudog/util/List.dart';
import 'package:provider/provider.dart';

class SetFilterPageWidget extends StatefulWidget {
  const SetFilterPageWidget({Key? key}) : super(key: key);

  @override
  _SetFilterPageWidgetState createState() => _SetFilterPageWidgetState();
}

class _SetFilterPageWidgetState extends State<SetFilterPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late String date;
  Map<String, dynamic> filters = {
    "providers": Set(),
    "categories": Set(),
    "startDate": "",
    "endDate": ""
  };
  List<bool> isMajorClickedList = List.generate(majors.length, (_) => false);
  List<bool> isDatesClickedList = List.generate(dates.length, (_) => false);
  List<bool> isCategoriesClickedList =
      List.generate(categories.length, (_) => false);
  @override
  void initState() {
    super.initState();
    //overallFilter를 filters에 반영하기

    if (overallFilter.providers != null) {
      filters["providers"] = overallFilter.providers!.toSet();
    } else {
      filters["providers"] = ["전체"].toSet();
    }
    if (overallFilter.categories != null) {
      filters["categories"] = overallFilter.categories!.toSet();
    } else {
      filters["categories"] = ["전체"].toSet();
    }
    filters["startDate"] = overallFilter.startDate;
    filters["endDate"] = overallFilter.endDate;

    if (filters["providers"] != null) {
      for (String element in filters["providers"]) {
        int index = majors.indexOf(element);
        isMajorClickedList[index] = true;
      }
    }
    if (filters["categories"] != null) {
      for (String element in filters["categories"]) {
        int index = categories.indexOf(element);
        isCategoriesClickedList[index] = true;
      }
    }
    if (DateTime.parse(filters["endDate"])
            .difference(DateTime.parse(filters["startDate"]))
            .inDays ==
        0) {
      isDatesClickedList[0] = true;
      date = "오늘";
    } else if (DateTime.parse(filters["endDate"])
            .difference(DateTime.parse(filters["startDate"]))
            .inDays ==
        7) {
      isDatesClickedList[1] = true;
      date = "1주";
    } else if (DateTime.parse(filters["endDate"])
            .difference(DateTime.parse(filters["startDate"]))
            .inDays >=
        50) {
      isDatesClickedList[3] = true;
      date = "3개월";
    } else {
      isDatesClickedList[2] = true;
      date = "1개월";
    }
  }

  void changeFilter(String filter, String whichFilter, int idx) {
    setState(() {
      if (whichFilter == "providers") {
        if (isMajorClickedList[idx]) {
          filters[whichFilter].add(filter);
          if (idx != 0) {
            filters[whichFilter].remove("전체");
          } else {
            filters[whichFilter] = ["전체"].toSet();
          }
        } else {
          filters[whichFilter].remove(filter);
        }
      } else if (whichFilter == "categories") {
        if (isCategoriesClickedList[idx]) {
          filters[whichFilter].add(filter);
          if (idx != 0) {
            filters[whichFilter].remove("전체");
          } else {
            filters[whichFilter] = ["전체"].toSet();
          }
        } else {
          filters[whichFilter].remove(filter);
        }
      } else {
        filters[whichFilter] = filter;
        if (DateTime.parse(filters["endDate"])
                .difference(DateTime.parse(filters["startDate"]))
                .inDays ==
            0) {
          isDatesClickedList[0] = true;
          date = "오늘";
        } else if (DateTime.parse(filters["endDate"])
                .difference(DateTime.parse(filters["startDate"]))
                .inDays ==
            7) {
          isDatesClickedList[1] = true;
          date = "1주";
        } else if (DateTime.parse(filters["endDate"])
                .difference(DateTime.parse(filters["startDate"]))
                .inDays >=
            50) {
          isDatesClickedList[3] = true;
          date = "3개월";
        } else {
          isDatesClickedList[2] = true;
          date = "1개월";
        }
      }
    });
    print(filters);
  }

  void changeColor(int idx, int type) {
    //type = 1 -> major, type = 2 -> dates, type = 3 -> categories
    setState(() {
      if (type == 1) {
        //
        if (idx == 0) {
          isMajorClickedList = List.generate(majors.length, (_) => false);
          isMajorClickedList[idx] = !isMajorClickedList[idx];
        } else {
          isMajorClickedList[0] = false;
          isMajorClickedList[idx] = !isMajorClickedList[idx];
        }
      } else if (type == 2) {
        isDatesClickedList = List.generate(dates.length, (_) => false);
        isDatesClickedList[idx] = !isDatesClickedList[idx];
      } else {
        if (idx == 0) {
          isCategoriesClickedList =
              List.generate(categories.length, (_) => false);
          isCategoriesClickedList[idx] = !isCategoriesClickedList[idx];
        } else {
          isCategoriesClickedList[0] = false;
          isCategoriesClickedList[idx] = !isCategoriesClickedList[idx];
        }
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
                        List<dynamic> _categories =
                            filters["categories"].toList();
                        List<dynamic> _providers =
                            filters["providers"].toList();
                        List<String> _cts =
                            _categories.map((e) => e.toString()).toList();
                        List<String> _pros =
                            _providers.map((e) => e.toString()).toList();

                        if (_cts[0] == "전체" && _pros[0] == "전체") {
                          overallFilter = Filter(
                              startDate: filters["startDate"],
                              endDate: filters["endDate"],
                              page: 1);
                        } else if (_cts[0] == "전체") {
                          overallFilter = Filter(
                              providers: _pros,
                              startDate: filters["startDate"],
                              endDate: filters["endDate"],
                              page: 1);
                        } else if (_pros[0] == "전체") {
                          overallFilter = Filter(
                              categories: _cts,
                              startDate: filters["startDate"],
                              endDate: filters["endDate"],
                              page: 1);
                        } else {
                          print("hello");
                          overallFilter = Filter(
                              categories: _cts,
                              providers: _pros,
                              startDate: filters["startDate"],
                              endDate: filters["endDate"],
                              page: 1);
                        }

                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                NavigationPageWidget(),
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
                                  FilterCard(content: date, type: "dates"),
                                  FilterCard(
                                      content: filters["providers"].join(', '),
                                      type: "majors"),
                                  FilterCard(
                                      content: filters["categories"].join(', '),
                                      type: "categories"),
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
                                          changeColor(index, 1);
                                          changeFilter(majors[index],
                                              "providers", index);
                                        },
                                        child: MajorCard(
                                          major: majors[index],
                                          isClicked: isMajorClickedList[index],
                                        ),
                                      )))
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
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: List.generate(
                                    dates.length,
                                    (index) => GestureDetector(
                                        onTap: () {
                                          changeColor(index, 2);
                                          if (dates[index] == "오늘") {
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()),
                                                "startDate",
                                                index);
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()),
                                                "endDate",
                                                index);
                                          } else if (dates[index] == "1주") {
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.now().subtract(
                                                        Duration(days: 7))),
                                                "startDate",
                                                index);
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()),
                                                "endDate",
                                                index);
                                          } else if (dates[index] == "1개월") {
                                            DateTime currentDate =
                                                DateTime.now();
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime(
                                                        currentDate.year,
                                                        currentDate.month - 1,
                                                        currentDate.day)),
                                                "startDate",
                                                index);
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()),
                                                "endDate",
                                                index);
                                          } else {
                                            DateTime currentDate =
                                                DateTime.now();
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime(
                                                        currentDate.year - 1,
                                                        currentDate.month,
                                                        currentDate.day)),
                                                "startDate",
                                                index);
                                            changeFilter(
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()),
                                                "endDate",
                                                index);
                                          }
                                        },
                                        child: DateCard(
                                          date: dates[index],
                                          isClicked: isDatesClickedList[index],
                                        ))),
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
                                          changeColor(index, 3);
                                          changeFilter(categories[index],
                                              "categories", index);
                                        },
                                        child: CategoryCard(
                                          category: categories[index],
                                          isClicked:
                                              isCategoriesClickedList[index],
                                        ))),
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
  const MajorCard({super.key, required this.major, required this.isClicked});
  final String major;
  final bool isClicked;

  @override
  _MajorCardState createState() => _MajorCardState();
}

class _MajorCardState extends State<MajorCard> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: widget.isClicked ? Color(0xFFFFD8DA) : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: widget.isClicked ? Color(0xFFFF3A46) : Color(0xFF423C3C)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isClicked
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
    );
  }
}

class DateCard extends StatefulWidget {
  const DateCard({super.key, required this.date, required this.isClicked});
  final String date;
  final bool isClicked;
  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 40,
      width: 70,
      decoration: ShapeDecoration(
        color: widget.isClicked ? Color(0xE5FF3A46) : Colors.white,
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
              color: widget.isClicked ? Colors.white : Color(0xFF423C3C),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard(
      {super.key, required this.category, required this.isClicked});
  final String category;
  final bool isClicked;
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      width: 135,
      margin: EdgeInsets.all(3),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: widget.isClicked ? Color(0xFFFFD8DA) : Colors.white,
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
              color: widget.isClicked ? Color(0xFFFF3A46) : Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
          widget.isClicked
              ? Icon(Icons.close, color: Colors.white)
              : Container(),
        ],
      ),
    );
  }
}

class FilterCard extends StatelessWidget {
  const FilterCard({super.key, required this.type, required this.content});
  final String type;
  final String content;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.all(5),
      decoration: type != "dates"
          ? ShapeDecoration(
              color: Color(0x7FFFD8DA),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            )
          : ShapeDecoration(
              color: Color(0xFFF4F1F1),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFFFD8DA)),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            content,
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
    );
  }
}
