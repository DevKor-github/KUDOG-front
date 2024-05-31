import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  String currentMajor = "";
  int categoryCount = 0;
  List<MajorCategory> majors = [
    MajorCategory(id: 0, name: "즐겨찾기", categories: [])
  ];
  List<MajorCategory> bookmarkedMajorList = [];
  List<dynamic> categories = [];
  bool isBookmarkClicked = false;
  List<bool> isMajorClickedList = [];
  List<bool> isDatesClickedList = [false, false, false, false];
  bool isDatesClicked = false;
  String dateCard = "";
  List<bool> isCategoriesClickedList = [];
  bool isCardClicked = false;
  String selectedDateCard = "";
  List<String> selectedCategories = [];
  int? selectedMajorId;
  Map<String, List<String>> filterMap = {};

  void click(int idx, int type) {
    //type = 1 -> major, type = 2 -> dates, type = 3 -> categories
    setState(() {
      if (type == 1) {
        //
        isMajorClickedList[0] = false;
        for (int i = 0; i < isMajorClickedList.length; i++) {
          if (i != idx) {
            isMajorClickedList[i] = false;
          }
        }
        isMajorClickedList[idx] = !isMajorClickedList[idx];
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
      for (int i = 0; i < majors.length; i++) {
        final t = <String, List<String>>{majors[i].name!: []};
        filterMap.addEntries(t.entries);
      }
      isMajorClickedList = List.generate(majors.length, (_) => false);
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
      isCategoriesClickedList = List.generate(categories.length, (_) => false);
    });
  }

  void _goToTab(int index, int majorIdx) {
    if (majorIdx != 0) {
      _tabController.animateTo(index);
    }
  }

  @override
  void initState() {
    super.initState();

    loadMajors();
    _selectedStartDate = DateTime.parse(overallFilter.startDate!);
    _selectedEndDate = DateTime.parse(overallFilter.endDate!);

    _tabController = TabController(length: 3, vsync: this);

    isCategoriesClickedList = List.generate(categories.length, (_) => false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(bookmarkedMajorList);
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
                        List<MapEntry<String, dynamic>> entriesList =
                            filterMap.entries.toList();
                        List<String> _categories = [];
                        List<String> _providers = [];
                        for (var entry in entriesList) {
                          if (!entry.value.isEmpty) {
                            _providers.add(entry.key);
                          }
                          for (var v in entry.value) {
                            _categories.add(v);
                          }
                        }
                        overallFilterMap = filterMap;
                        overallFilter = Filter(
                            startDate: DateFormat('yyyy-MM-dd')
                                .format(_selectedStartDate!),
                            endDate: DateFormat('yyyy-MM-dd')
                                .format(_selectedEndDate!),
                            categories: _categories,
                            providers: _providers);
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _selectedEndDate == null
                            ? Container()
                            : DateFilterCard(
                                content: isDatesClicked
                                    ? dateCard
                                    : "${DateFormat('yyyy-MM-dd').format(_selectedStartDate!)} ~ ${DateFormat('yyyy-MM-dd').format(_selectedEndDate!)}"),
                        categoryCount == 0
                            ? Container()
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filterMap.length,
                                    itemBuilder: (context, index) {
                                      return CategoryFilterCard(
                                        major: filterMap.keys.toList()[index],
                                        categories: filterMap[
                                            filterMap.keys.toList()[index]]!,
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ],
                ),
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
                          _goToTab(1, index);
                          click(index, 1);
                          if (index == 0) {
                            isBookmarkClicked = true;
                          }
                          currentMajor = majors[index].name!;
                          loadCategories(majors[index].id!);
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
                    child: bookmarkedMajorList.isEmpty
                        ? BookmarkMajorCard(
                            major: "즐겨찾는 학과가 없습니다.", isClicked: false)
                        : Container(
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
              children: List.generate(majors.length, (index) {
                return SecondMajorCard(
                    major: majors[index].name!,
                    isClicked: currentMajor == majors[index].name!);
              }),
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
                    setState(() {
                      if (filterMap[currentMajor]!
                          .contains(categories[index])) {
                        filterMap[currentMajor]!.remove(categories[index]);
                        categoryCount -= 1;
                      } else {
                        filterMap[currentMajor]!.add(categories[index]);
                        categoryCount += 1;
                      }
                    });
                  },
                  child: CategoryCard(
                      category: categories[index],
                      isClicked: isCategoriesClickedList[index]),
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
                    setState(() {
                      isCardClicked = true;
                      isDatesClickedList = [false, false, false, false];
                      isDatesClickedList[index] = !isDatesClickedList[index];

                      if (dates[index] == "오늘") {
                        _selectedEndDate = DateTime.now();
                        _selectedStartDate = DateTime.now();
                        isDatesClicked = true;
                        dateCard = "오늘";
                      } else if (dates[index] == "1주") {
                        _selectedStartDate =
                            DateTime.now().subtract(Duration(days: 7));
                        _selectedStartDate = DateTime.now();
                        dateCard = "1주";
                        isDatesClicked = true;
                      } else if (dates[index] == "1개월") {
                        DateTime currentDate = DateTime.now();
                        _selectedStartDate = DateTime(currentDate.year,
                            currentDate.month - 1, currentDate.day);
                        _selectedEndDate = DateTime.now();
                        dateCard = "1개월";
                        isDatesClicked = true;
                      } else {
                        DateTime currentDate = DateTime.now();
                        _selectedStartDate = DateTime(currentDate.year,
                            currentDate.month - 3, currentDate.day);
                        _selectedEndDate = DateTime.now();
                        dateCard = "3개월";
                        isDatesClicked = true;
                      }
                    });
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
                              isDatesClicked = false;
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

class SecondMajorCard extends StatefulWidget {
  const SecondMajorCard(
      {super.key, required this.major, required this.isClicked});
  final String major;
  final bool isClicked;

  @override
  _SecondMajorCardState createState() => _SecondMajorCardState();
}

class _SecondMajorCardState extends State<SecondMajorCard> {
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
        color: Colors.white,
        shape: RoundedRectangleBorder(),
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
              color: !widget.isClicked ? Color(0xff423D3D) : Color(0xFFFF3B47),
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
    return content == ""
        ? Container()
        : Container(
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

class DateFilterCard extends StatelessWidget {
  const DateFilterCard({super.key, required this.content});
  final String content;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.all(5),
      decoration: ShapeDecoration(
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

class CategoryFilterCard extends StatelessWidget {
  const CategoryFilterCard(
      {super.key, required this.major, required this.categories});
  final String major;
  final List<String> categories;
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? Container()
        : Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.all(5),
            decoration: ShapeDecoration(
              color: Color(0x7FFFD8DA),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  major,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFF3A46),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  categories.isEmpty
                      ? ""
                      : categories.length > 1
                          ? "+ ${categories.length}"
                          : " - ${categories[0]}",
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
