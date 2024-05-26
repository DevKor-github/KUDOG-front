import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:kudog/model/CategoryModel.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NotificationModel.dart';
import 'package:kudog/model/ScrapModel.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/NavigationPage.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';
import 'package:kudog/pages/home/ViewPostDetailPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/NotificationService.dart';
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

  List<Records> newNotifications = [];
  
  bool isMoreRequesting = false;

  // 드레그 거리를 체크하기 위함
  // 해당 값을 평균내서 50%이상 움직였을때 데이터 불러오는 작업을 하게됨.
  double _dragDistance = 0;

  scrollNotification(notification) {
    // 스크롤 최대 범위
    var containerExtent = notification.metrics.viewportDimension;

    if (notification is ScrollStartNotification) {
      // 스크롤을 시작하면 발생(손가락으로 리스트를 누르고 움직이려고 할때)
      // 스크롤 거리값을 0으로 초기화함
      _dragDistance = 0;
    } else if (notification is OverscrollNotification) {
      // 안드로이드에서 동작
      // 스크롤을 시작후 움직일때 발생(손가락으로 리스트를 누르고 움직이고 있을때 계속 발생)
      // 스크롤 움직인 만큼 빼준다.(notification.overscroll)
      _dragDistance -= notification.overscroll;
    } else if (notification is ScrollUpdateNotification) {
      // ios에서 동작
      // 스크롤을 시작후 움직일때 발생(손가락으로 리스트를 누르고 움직이고 있을때 계속 발생)
      // 스크롤 움직인 만큼 빼준다.(notification.scrollDelta)
      _dragDistance -= notification.scrollDelta!;
    } else if (notification is ScrollEndNotification) {
      // 스크롤이 끝났을때 발생(손가락을 리스트에서 움직이다가 뗐을때 발생)

      // 지금까지 움직인 거리를 최대 거리로 나눈다.
      var percent = _dragDistance / (containerExtent);
      // 해당 값이 -0.4(40프로 이상) 아래서 위로 움직였다면
      if (percent <= -0.4) {
        // maxScrollExtent는 리스트 가장 아래 위치 값
        // pixels는 현재 위치 값
        // 두 같이 같다면(스크롤이 가장 아래에 있다)
        if (notification.metrics.maxScrollExtent ==
            notification.metrics.pixels) {
          setState(() {
            // 서버에서 데이터를 더 가져오는 효과를 주기 위함
            // 하단에 프로그레스 서클 표시용
            isMoreRequesting = true;
          });

          // 서버에서 데이터 가져온다.
          requestMore().then((value) {
            setState(() {
              // 다 가져오면 하단 표시 서클 제거
              isMoreRequesting = false;
            });
          });
        }
      }
    }
  }

  Future<void> requestMore() async {
    overallFilter.page = overallFilter.page! + 1;

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
      _loadInitNotices(overallFilter, add: true);
    } else if (overallFilter.categories == null &&
        overallFilter.providers != null) {
      _loadProvidersNotices(overallFilter, add: true);
    } else if (overallFilter.categories != null &&
        overallFilter.providers == null) {
      _loadCategoriesNotices(overallFilter, add: true);
    } else {
      //provider, categories 두 개 다 있을 때
      _loadFilteredNotices(overallFilter, add: true);
    }
  }

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
      _loadInitNotices(overallFilter);
    } else if (overallFilter.categories == null &&
        overallFilter.providers != null) {
      _loadProvidersNotices(overallFilter);
    } else if (overallFilter.categories != null &&
        overallFilter.providers == null) {
      _loadCategoriesNotices(overallFilter);
    } else {
      _loadFilteredNotices(overallFilter);
    }
    // testToken();
    loadNewNotifications();

  }

  Future<void> testToken() async {
    await Provider.of<TokenService>(context, listen: false)
        .getFcmTokenStatusAndPostToken();
  }

  void _loadInitNotices(Filter filter, {bool add = false}) async {
    //filter설정된 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false).getAllNotices(
        Filter(
            startDate: filter.startDate,
            endDate: filter.endDate,
            page: filter.page),
        add: add);

    setState(() {
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
              .mainNoticeList
              .notices ??
          [];
    });
  }

  void _loadFilteredNotices(Filter filter, {bool add = false}) async {
    //이 페이지에서 필터링된 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false).getFilteredNotices(
        Filter(
            providers: filter.providers,
            categories: filter.categories,
            startDate: filter.startDate,
            endDate: filter.endDate,
            page: filter.page),
        add: add);

    setState(() {
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .mainNoticeList
          .notices!;
    });
  }

  void _loadProviderNotices(Filter filter, int idx, {bool add = false}) async {
    //선택한 단과대학의 공지사항을 가져옵니다.

    await Provider.of<NoticeService>(context, listen: false).getProviderNotices(
        Filter(
            providers: filter.providers,
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1),
        add: add);

    setState(() {
      selectedIndex = idx;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .mainNoticeList
          .notices!;
    });
  }

  void _loadProvidersNotices(Filter filter, {bool add = false}) async {
    //선택한 단과대학들의 공지사항을 가져옵니다.

    await Provider.of<NoticeService>(context, listen: false).getProviderNotices(
        Filter(
            providers: filter.providers,
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1),
        add: add);

    setState(() {
      noticeList = Provider.of<NoticeService>(context, listen: false)
              .mainNoticeList
              .notices ??
          [];
    });
  }

  void _loadCategoriesNotices(Filter filter, {bool add = false}) async {
    //선택한 카테고리들의 공지사항을 가져옵니다.

    await Provider.of<NoticeService>(context, listen: false).getCategoryNotices(
        Filter(
            categories: filter.categories,
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1),
        add: add);

    setState(() {
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .mainNoticeList
          .notices!;
    });
  }

  void _loadSearchedNotices(Filter filter, {bool add = false}) async {
    //검색된 공지사항을 가져옵니다.
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String sevenDaysAgo = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    await Provider.of<NoticeService>(context, listen: false).getSearchedNotices(
        Filter(
            startDate: sevenDaysAgo,
            endDate: formattedDate,
            page: 1,
            keyword: filter.keyword),
        add: add);

    setState(() {
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .mainNoticeList
          .notices!;
    });
  }

  int showScrapList =
      0; //0 at default, notice id value when showing scrap list.
  List<Scrap> scrapList = [];

  void _showScrapList(int noticeId) async {
    await Provider.of<NoticeService>(context, listen: false).getScraps();

    setState(() {
      scrapList =
          Provider.of<NoticeService>(context, listen: false).scrapList.scraps;
      showScrapList = noticeId;
    });
  }

  void _hideScrapList() {
    _loadInitNotices(overallFilter);

    if (showScrapList != 0) {
      setState(() {
        showScrapList = 0;
      });
    }
  }

  void loadNewNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .getNewNotifications();
    setState(() {
      newNotifications =
          Provider.of<NotificationService>(context, listen: false)
              .newNotificationRecords;
    });
  }

  void addToScrap(int noticeId) {}

  void removeFromScrap(int noticeId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(16, 17, 16, 0),
            child: Column(
              children: [

                Container(
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              child:
                                  Image.asset("assets/images/login_icon.png"),
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
                              labelStyle: TextStyle(
                                  fontSize: 14, color: Color(0xFFD9D9D9)),
                              contentPadding: EdgeInsets.all(24.0),
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.search,
                                      color: Color(0xffFF3B47)),
                                  onPressed: () {
                                    _loadSearchedNotices(Filter(
                                        keyword: _searchController.text));
                                  }),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                                                  providers: [majors[index]],
                                                  page: 1),
                                              index);
                                          overallFilter = Filter(
                                              providers: [majors[index]],
                                              page: 1,
                                              startDate:
                                                  overallFilter.startDate,
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
                                      builder: (context) =>
                                          SetFilterPageWidget()));
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
                                      child: Image.asset(
                                          "assets/images/filter.png")),
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
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          /*
                     스크롤 할때 발생되는 이벤트
                     해당 함수에서 어느 방향으로 스크롤을 했는지를 판단해
                     리스트 가장 밑에서 아래서 위로 40프로 이상 스크롤 했을때 
                     서버에서 데이터를 추가로 가져오는 루틴이 포함됨.
                    */
                          scrollNotification(notification);
                          return false;
                        },
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: noticeList.length,
                            itemBuilder: (context, index) {
                              GlobalKey _key = new GlobalKey();
                              return noticeCard(
                                  key: _key,
                                  globalKey: _key,
                                  notice: noticeList[index]);
                            })))
              ],
            )));
  }
}

extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

class noticeCard extends StatefulWidget {
  const noticeCard(
      {super.key,
      this.globalKey = null,
      required this.notice,
      this.isBorder = false});
  final Notice notice;
  final GlobalKey? globalKey;
  final bool isBorder;
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

  void onSelectScrap() async {
    await Provider.of<NoticeService>(context, listen: false).getScraps();
    List<Scrap> scrapList =
        Provider.of<NoticeService>(context, listen: false).scrapList.scraps;

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            alignment: Alignment.bottomRight,
            insetPadding: EdgeInsets.only(
                bottom:
                    widget.globalKey?.currentContext?.globalPaintBounds == null
                        ? 20
                        : MediaQuery.of(context).size.height -
                            widget.globalKey!.currentContext!.globalPaintBounds!
                                .top -
                            24,
                right: 18),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  scrapList.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: TextButton(
                        onPressed: () async {
                          await Provider.of<NoticeService>(context,
                                  listen: false)
                              .addToScrap(
                                  widget.notice.id!, scrapList[index].id!);
                          Navigator.of(context, rootNavigator: true).pop(this);
                          changeIcon();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            fixedSize: Size(227, 44)),
                        child: Row(
                          children: [
                            Icon(Icons.drive_file_move),
                            Text(scrapList[index].name!)
                          ],
                        )),
                  ),
                )),
          );
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
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.isBorder ? gray4 : Colors.transparent,
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: white),
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
                            widget.notice.title!.length > 25
                                ? widget.notice.title!.substring(0, 25) + "..."
                                : widget.notice.title!,
                            style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                      onSelectScrap();
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
                    ],
                  )
                ],
              )));
    });
  }
}
