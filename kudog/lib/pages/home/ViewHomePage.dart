import 'package:flutter/material.dart';
import 'package:kudog/model/CategoryModel.dart';
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
  List<Notice> noticeList = []; //보여지는 공지사항들
  UpperCategory selectedUpperCategory = UpperCategory(name: "전체");
  int selectedIndex = 0;
  List<UpperCategory> upperCategoryList = [];
  void initState() {
    super.initState();
    _loadAllNotices();
  }

  void _loadAllNotices() async {
    //전체 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false).getAllNotices(1);
    setState(() {
      selectedUpperCategory = upperCategoryList[0];
      selectedIndex = 0;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .noticeList
          .notices!;
    });
  }

  void selectUpperCategory(int index) async {
    //선택한 카테고리의 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false)
        .getUpperCategoryNotice(1, index);
    setState(() {
      selectedUpperCategory = upperCategoryList[index];
      selectedIndex = index;
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .selectedNoticeList
          .notices!;
    });
  }

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
                FutureBuilder(
                    future: _loadUpperCategories(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: upperCategoryList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        if (index != 0) {
                                          selectUpperCategory(index);
                                        } else {
                                          _loadAllNotices();
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
                                          child: Text(
                                              upperCategoryList[index].name!,
                                              style: TextStyle(
                                                color: selectedIndex != index
                                                    ? Color(0xFF787474)
                                                    : Color(0xffFF3B47),
                                                fontSize: 18,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w500,
                                              ))));
                                }));
                      }
                    })
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
        // FutureBuilder(
        //     future: _loadAllNotices(),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       if (snapshot.hasData == false) {
        //         return CircularProgressIndicator();
        //       } else if (snapshot.hasError) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             'Error: ${snapshot.error}',
        //             style: TextStyle(fontSize: 15),
        //           ),
        //         );
        //       } else {
        //         return Expanded(
        //             child: ListView.builder(
        //                 itemCount: noticeList.length,
        //                 itemBuilder: (context, index) {
        //                   return noticeCard(notice: noticeList[index]);
        //                 }));
        //       }
        //     })
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
                  noticeService.scrapNotice(widget.notice.id!);
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
          ));
    });
  }
}
