import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/pages/my/ViewMyPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/util/Filter.dart';
import 'package:kudog/util/List.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:kudog/util/major_category.dart';

class SetFilterPageWidget extends StatefulWidget {
  const SetFilterPageWidget({Key? key}) : super(key: key);

  @override
  _SetFilterPageWidgetState createState() => _SetFilterPageWidgetState();
}

class _SetFilterPageWidgetState extends State<SetFilterPageWidget>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  List<MajorCategory> majors = [
    MajorCategory(id: 0, name: "즐겨찾기", categories: [])
  ];
  List<MajorCategory> bookmarkedMajorList = [];
  List<dynamic> categories = [];
  bool isBookmarkClicked = false;
  List<bool> isMajorClickedList = [];
  List<bool> isDatesClickedList = [false, false, false, false];
  List<bool> isCategoriesClickedList = [];
  bool isCardClicked = false;
  String selectedDateCard = "";
  List<String> selectedCategories = [];
  int? selectedMajorId;

  void click(int idx, int type) {
    //type = 1 -> major, type = 2 -> dates, type = 3 -> categories
    setState(() {
      if (type == 1) {
        //
        if (idx == 0) {
          isMajorClickedList[idx] = !isMajorClickedList[idx];
        } else {
          isMajorClickedList[0] = false;
          isMajorClickedList[idx] = !isMajorClickedList[idx];
        }
      } else if (type == 2) {
        isDatesClickedList = List.generate(dates.length, (_) => false);
        isDatesClickedList[idx] = !isDatesClickedList[idx];
      } else {
        isCategoriesClickedList[idx] = !isCategoriesClickedList[idx];
      }
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedStartDate)
      setState(() {
        _selectedStartDate = pickedDate;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedEndDate)
      setState(() {
        _selectedEndDate = pickedDate;
      });
  }

  void loadMajors() async {
    await Provider.of<NoticeService>(context, listen: false)
        .getBookmarkProvider();
    setState(() {
      majors += (json.decode(major_category_json) as List)
          .map((data) => MajorCategory.fromJson(data))
          .toList();
      ;

      bookmarkedMajorList = Provider.of<NoticeService>(context, listen: false)
          .bookmarkMajorCategoryList;
    });
  }

  void selectCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  List<String> getCategoryNamesById(List<dynamic> data, int id) {
    List<String> categories = [];
    for (var department in data) {
      if (department['id'] == id) {
        for (var category in department['categories']) {
          categories.add(category['name']);
        }
        break;
      }
    }
    return categories;
  }

  void loadCategories(int id) {
    List<dynamic> jsonData = json.decode(major_category_json);
    setState(() {
      categories = getCategoryNamesById(jsonData, id);
    });
  }

  void _goToTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    loadMajors();

    print(overallFilter.categories);
    print(overallFilter.providers);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isMajorClickedList = List.generate(majors.length, (_) => false);
    isCategoriesClickedList = List.generate(majors.length, (_) => false);
    return Scaffold(
      body: Column(
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
                        List<String> selectedMajors = [];
                        for (int i = 0; i < isMajorClickedList.length; i++) {
                          if (isMajorClickedList[i]) {
                            selectedMajors.add(majors[i].name!);
                          }
                        }
                        List<String> selectedCategories = [];
                        for (int i = 0; i < isMajorClickedList.length; i++) {
                          if (isMajorClickedList[i]) {
                            selectedMajors.add(majors[i].name!);
                          }
                        }
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                NavigationPageWidget(idx: 2),
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
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "적용된 필터",
                        style: TextStyle(
                          color: Color(0xFF1B1616),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // FilterCard(content: date, type: "dates"),
                      // FilterCard(
                      //     content: filters["providers"].join(', '),
                      //     type: "majors"),
                      // FilterCard(
                      //     content: filters["categories"].join(', '),
                      //     type: "categories"),
                    ],
                  ),
                ],
              )),
          Container(color: Color(0xffF4F2F2), height: 10),
          TabBar(
            labelStyle: TextStyle(
              color: Color(0xFF423C3C),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              color: Color(0xFF787474),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
            indicator: BoxDecoration(),
            controller: _tabController,
            tabs: [
              Tab(text: '학과'),
              Tab(text: '카테고리'),
              Tab(text: '조회기간'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildMajorFilter(),
                buildCategoryFilter(),
                buildDateFilter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMajorFilter() {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xffF4F2F2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: List.generate(
                      majors.length,
                      (index) => GestureDetector(
                        onTap: () {
                          click(index, 1);

                          if (index != 0) {
                            // loadCategories(index);
                            selectedMajorId = majors[index].id;
                            setState(() {
                              isBookmarkClicked = false;
                            });
                          } else {
                            setState(() {
                              isBookmarkClicked = !isBookmarkClicked;
                            });
                          }
                        },
                        child: MajorCard(
                            major: majors[index].name!,
                            isClicked: isMajorClickedList[index]),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: isBookmarkClicked,
                    child: Container(
                      child: Column(
                        children: List.generate(
                          bookmarkedMajorList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              if (index != 0) {
                                loadCategories(index);
                              } else {}
                            },
                            child: BookmarkMajorCard(
                                major: bookmarkedMajorList[index].name!,
                                isClicked: false),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryFilter() {
    return Container(
      color: Color(0xffF4F2F2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: List.generate(
                  majors.length,
                  (index) =>
                      MajorCard(major: majors[index].name!, isClicked: false)),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                (index) => GestureDetector(
                  onTap: () {
                    click(index, 3);
                  },
                  child: CategoryCard(
                      category: categories[index], isClicked: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateFilter() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 5.0,
              runSpacing: 5.0,
              children: List.generate(
                dates.length,
                (index) => GestureDetector(
                  onTap: () {
                    isCardClicked = true;
                    isDatesClickedList = [false, false, false, false];
                    isDatesClickedList[index] = !isDatesClickedList[index];

                    // changeColor(index, 2);
                    // if (dates[index] == "오늘") {
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    //       "startDate",
                    //       index);
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    //       "endDate",
                    //       index);
                    // } else if (dates[index] == "1주") {
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(
                    //           DateTime.now().subtract(Duration(days: 7))),
                    //       "startDate",
                    //       index);
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    //       "endDate",
                    //       index);
                    // } else if (dates[index] == "1개월") {
                    //   DateTime currentDate = DateTime.now();
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime(
                    //           currentDate.year,
                    //           currentDate.month - 1,
                    //           currentDate.day)),
                    //       "startDate",
                    //       index);
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    //       "endDate",
                    //       index);
                    // } else {
                    //   DateTime currentDate = DateTime.now();
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime(
                    //           currentDate.year,
                    //           currentDate.month - 3,
                    //           currentDate.day)),
                    //       "startDate",
                    //       index);
                    //   changeFilter(
                    //       DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    //       "endDate",
                    //       index);
                    // }
                  },
                  child: DateCard(date: dates[index], isClicked: false),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedStartDate == null
                            ? '날짜 선택'
                            : '${_selectedStartDate!.toLocal()}'.split(' ')[0],
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
                          child: GestureDetector(
                            onTap: () {
                              isCardClicked = false;
                              _selectStartDate(context);
                            },
                            child: Icon(Icons.calendar_month_outlined),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Text("-", style: TextStyle(fontSize: 30)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedEndDate == null
                            ? '날짜 선택'
                            : '${_selectedEndDate!.toLocal()}'.split(' ')[0],
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
                          child: GestureDetector(
                            onTap: () {
                              _selectEndDate(context);
                            },
                            child: Icon(Icons.calendar_month_outlined),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      margin: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: widget.isClicked ? Color(0xFFFF3A46) : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: widget.isClicked ? Color(0xFFFF3A46) : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.major,
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

class BookmarkMajorCard extends StatefulWidget {
  const BookmarkMajorCard(
      {super.key, required this.major, required this.isClicked});
  final String major;
  final bool isClicked;

  @override
  _BookmarkMajorCardState createState() => _BookmarkMajorCardState();
}

class _BookmarkMajorCardState extends State<BookmarkMajorCard> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: widget.isClicked ? Color(0xFFFF3A46) : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: widget.isClicked ? Color(0xFFFF3A46) : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.major,
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
      width: MediaQuery.of(context).size.width * 0.67,
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: widget.isClicked ? Color(0xFFFFD8DA) : Colors.white,
        shape: RoundedRectangleBorder(),
      ),
      child: Row(
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
              ? Icon(Icons.check, color: Colors.white)
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
