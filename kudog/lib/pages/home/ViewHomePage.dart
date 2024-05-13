import 'package:flutter/material.dart';

import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';
import 'package:kudog/pages/home/ViewPostDetailPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:kudog/util/Filter.dart';
import 'package:kudog/util/List.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ViewHomePageWidget extends StatefulWidget {
  const ViewHomePageWidget({super.key});
  @override
  _ViewHomePageWidgetState createState() => _ViewHomePageWidgetState();
}

class _ViewHomePageWidgetState extends State<ViewHomePageWidget>
    with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  @override
  List<Notice> noticeList = []; //보여지는 공지사항들
  late String filterDate; //filter의 date
  int selectedIndex = 0; //선택된 단과대학
  void initState() {
    super.initState();
    print(overallFilter.categories);
    print(overallFilter.providers);
    print('${overallFilter.startDate} ~ ${overallFilter.endDate}');

    if (DateTime.parse(overallFilter.endDate!)
            .difference(DateTime.parse(overallFilter.startDate!))
            .inDays ==
        0) {
      filterDate = "오늘";
    } else if (DateTime.parse(overallFilter.endDate!)
            .difference(DateTime.parse(overallFilter.startDate!))
            .inDays ==
        7) {
      filterDate = "1주";
    } else if (DateTime.parse(overallFilter.endDate!)
            .difference(DateTime.parse(overallFilter.startDate!))
            .inDays >=
        50) {
      filterDate = "3개월";
    } else {
      filterDate = "1개월";
    }
    if (overallFilter.categories == null && overallFilter.providers == null) {
      //처음에 가져올 때
      _loadInitNotices(overallFilter);
    } else if (overallFilter.categories == null &&
        overallFilter.providers != null) {
      _loadProvidersNotices(overallFilter);
    } else if (overallFilter.categories != null &&
        overallFilter.providers == null) {
      _loadCategoriesNotices(overallFilter);
    } else {
      //provider, categories 두 개 다 있을 때
      _loadFilteredNotices(overallFilter);
    }
    testToken();
  }

  Future<void> testToken() async {
    await Provider.of<TokenService>(context, listen: false)
        .getFcmTokenStatusAndPostToken();
  }

  void _loadInitNotices(Filter filter) async {
    //filter설정된 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false).getAllNotices(
        Filter(
            startDate: filter.startDate,
            endDate: filter.endDate,
            page: filter.page));

    setState(() {
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
              .noticeList
              .notices ??
          [];
    });
  }

  void _loadFilteredNotices(Filter filter) async {
    //이 페이지에서 필터링된 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false).getFilteredNotices(
        Filter(
            providers: filter.providers,
            categories: filter.categories,
            startDate: filter.startDate,
            endDate: filter.endDate,
            page: filter.page));

    setState(() {
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .noticeList
          .notices!;
    });
  }

  void _loadProviderNotices(Filter filter, int idx) async {
    //선택한 단과대학의 공지사항을 가져옵니다.

    await Provider.of<NoticeService>(context, listen: false).getProviderNotices(
        Filter(
            providers: filter.providers,
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1));

    setState(() {
      selectedIndex = idx;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .noticeList
          .notices!;
    });
  }

  void _loadProvidersNotices(Filter filter) async {
    //선택한 단과대학들의 공지사항을 가져옵니다.

    await Provider.of<NoticeService>(context, listen: false).getProviderNotices(
        Filter(
            providers: filter.providers,
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1));

    setState(() {
      noticeList = Provider.of<NoticeService>(context, listen: false)
              .noticeList
              .notices ??
          [];
    });
  }

  void _loadCategoriesNotices(Filter filter) async {
    //선택한 카테고리들의 공지사항을 가져옵니다.

    await Provider.of<NoticeService>(context, listen: false).getCategoryNotices(
        Filter(
            categories: filter.categories,
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1));

    setState(() {
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .noticeList
          .notices!;
    });
  }

  void _loadSearchedNotices(Filter filter) async {
    //검색된 공지사항을 가져옵니다.
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String sevenDaysAgo = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    await Provider.of<NoticeService>(context, listen: false).getSearchedNotices(
        Filter(
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1,
            keyword: filter.keyword));

    setState(() {
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .noticeList
          .notices!;
    });
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: Image.asset("assets/images/login_icon.png"),
                      margin: EdgeInsets.only(top: 20, bottom: 15),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.06,
                  padding: const EdgeInsets.only(
                      top: 6, left: 16, right: 12, bottom: 6),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFF3A46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '구독함A ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 0.11,
                              ),
                            ),
                            TextSpan(
                              text: '에 새로운 소식이 들어왔어요!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          child: Icon(
                              color: Colors.white,
                              Icons.arrow_circle_right_outlined))
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
                      fillColor: Color(0xffF4F2F2), // 배경색 변경
                      labelText: '키워드로 검색하세요.',
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xFFD9D9D9)),
                      contentPadding: EdgeInsets.all(24.0),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Color(0xffFF3B47)),
                          onPressed: () {
                            _loadSearchedNotices(
                                Filter(keyword: _searchController.text));
                          }),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: majors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (index != 0) {
                                  _loadProviderNotices(
                                      Filter(
                                          providers: [majors[index]], page: 1),
                                      index);
                                  overallFilter = Filter(
                                      providers: [majors[index]],
                                      page: 1,
                                      startDate: overallFilter.startDate,
                                      endDate: overallFilter.endDate);
                                } else {
                                  _loadInitNotices(overallFilter);
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: selectedIndex != index
                                        ? Border()
                                        : Border(
                                            bottom: BorderSide(
                                              color: Color(0xffFF3B47),
                                              width: 2.0,
                                            ),
                                          ),
                                  ),
                                  margin: EdgeInsets.only(right: 40),
                                  child: Text(majors[index],
                                      style: TextStyle(
                                        color: selectedIndex != index
                                            ? Color(0xFF787474)
                                            : Color(0xffFF3B47),
                                        fontSize: 18,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                      ))));
                        }))
              ],
            )),
        Container(
            margin: EdgeInsets.only(left: 18, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  FilterCard(content: filterDate, type: "dates"),
                  overallFilter.providers != null
                      ? FilterCard(
                          content: overallFilter.providers!.join(', '),
                          type: "majors")
                      : FilterCard(content: "전체", type: "majors"),
                  overallFilter.categories != null
                      ? FilterCard(
                          content: overallFilter.categories!.join(', '),
                          type: "categories")
                      : FilterCard(content: "전체", type: "categories"),
                ]),
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
                itemCount: noticeList.length,
                itemBuilder: (context, index) {
                  return noticeCard(notice: noticeList[index]);
                }))
      ],
    )));
  }
}

class noticeCard extends StatefulWidget {
  const noticeCard({super.key, required this.notice});
  final Notice notice;
  @override
  _noticeCardState createState() => _noticeCardState();
}

class _noticeCardState extends State<noticeCard> {
  bool scrabState = false;

  void changeIcon() {
    setState(() {
      widget.notice.scrapped = !widget.notice.scrapped!;
      scrabState = !scrabState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewPostDetailPageWidget(
                          notice: widget.notice,
                        )));
          },
          child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            widget.notice.title!.length > 30
                                ? widget.notice.title!.substring(0, 30) + "..."
                                : widget.notice.title!,
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
                        widget.notice.date!,
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
                  GestureDetector(
                    onTap: () {
                      changeIcon();
                    },
                    child: Container(
                      width: 22,
                      height: 22,
                      child: Icon(
                        widget.notice.scrapped!
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: widget.notice.scrapped!
                            ? Color(0xffFF3B47)
                            : Color(0xffCCC9C9),
                      ),
                    ),
                  )
                ],
              )));
    });
  }
}
