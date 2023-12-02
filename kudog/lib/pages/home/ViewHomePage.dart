import 'package:flutter/material.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/pages/home/VIewPostDetailPage.dart';
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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Notice> noticeList;

  bool _isWidgetVisible = false;
  double alertRatio = 0.33;
  List<bool> iconStates = [false, false, false];
  List<String> upperCategories = [""];
  List<String> lowerCategories = ["학부 공지사항", "대학원", "진로정보", "채용정보"];
  List<bool> lowerStates = [false, false, false, false];
  String? selectedCategory = "정보대학";

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

  void changeCategory(int index) {
    setState(() {
      lowerStates[index] = !lowerStates[index];
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NoticeService>(context, listen: false).getAllNotices();
    Provider.of<CategoryService>(context, listen: false).getUpperCategoryList();
    Provider.of<NoticeService>(context, listen: false)
        .getUpperCategoryNotice(1, 0);
  }

  void _showWidget() {
    setState(() {
      _isWidgetVisible = true;
    });
  }

  void _hideWidget() {
    setState(() {
      _isWidgetVisible = false;
    });
  }

  void _extendWidget() {
    setState(() {
      alertRatio = 1;
    });
  }

  void _shrinkWidget() {
    setState(() {
      alertRatio = 0.33;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryService, NoticeService>(
      builder: (context, categoryService, noticeService, child) {
        upperCategories = categoryService.upperCategoryList;
        noticeList = noticeService.selectedNoticeList.notices!;

        int selectedIndex = upperCategories.indexOf(selectedCategory!);

        return upperCategories == []
            ? Column()
            : Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xFFCE4040),
                body: Stack(children: [
                  Column(
                    children: [
                      Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xFFCE4040),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 88,
                                margin: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/icon_6.png",
                                      width: 21.21,
                                      height: 21.34,
                                      color: Colors.white,
                                    ),
                                    Image.asset(
                                      "assets/images/icon_7.png",
                                      width: 36.79,
                                      height: 21.34,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '홈',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 88,
                                margin: EdgeInsets.all(15),
                                child: InkWell(
                                  onTap: _showWidget,
                                  child: Image.asset(
                                    "assets/images/icon_8.png",
                                    width: 36.79,
                                    height: 21.34,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Stack(children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            labelText: '검색어를 입력하세요',
                                            labelStyle: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFD9D9D9)),
                                            contentPadding:
                                                EdgeInsets.all(24.0),
                                            suffixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff999999),
                                                  width: 2.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          alignment:
                                              AlignmentDirectional.center,
                                          value: selectedCategory,
                                          onChanged: (String? newValue) {
                                            print(newValue!);
                                            selectedCategory = newValue!;
                                            selectedIndex = upperCategories
                                                .indexOf(selectedCategory!);
                                            noticeService
                                                .getUpperCategoryNotice(
                                                    1, selectedIndex);
                                            noticeList = noticeService
                                                .selectedNoticeList.notices!;
                                          },
                                          items: upperCategories
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      const Divider(
                                          thickness: 0.5,
                                          color: Color(0xffCDCDCD)),
                                      Container(
                                          height: 44,
                                          child: ListView.builder(
                                            padding: EdgeInsets.fromLTRB(
                                                24, 0, 0, 0),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: lowerStates.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    changeCategory(index);
                                                  },
                                                  child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 8, 0),
                                                      decoration: BoxDecoration(
                                                        color: lowerStates[
                                                                index]
                                                            ? Color.fromARGB(
                                                                255,
                                                                213,
                                                                124,
                                                                124)
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                        border: Border.all(
                                                          color: lowerStates[
                                                                  index]
                                                              ? Colors
                                                                  .transparent
                                                              : Color(
                                                                  0xFFCDCDCD),
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(24,
                                                                      4, 24, 4),
                                                          child: Text(
                                                            lowerCategories[
                                                                index],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Noto Sans KR',
                                                              color: lowerStates[
                                                                      index]
                                                                  ? Color(
                                                                      0xFFFFFFFF)
                                                                  : Color(
                                                                      0xff696969),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      )));
                                            },
                                          ))
                                    ],
                                  ),
                                  Expanded(
                                      child: noticeService
                                                  .noticeList.notices!.length ==
                                              0
                                          ? Column()
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: noticeList.length,
                                              itemBuilder: (context, index) {
                                                print(noticeList[index].title!);
                                                return noticeCard(
                                                    id: noticeList[index].id!,
                                                    title: noticeList[index]
                                                        .title!,
                                                    date: noticeList[index]
                                                        .date!);
                                              },
                                            ))
                                ],
                              )),
                          Positioned(
                            child: Visibility(
                                visible: _isWidgetVisible,
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        alertRatio,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2, color: Color(0xFFCDCDCD)),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 18,
                                            margin: EdgeInsets.fromLTRB(
                                                30, 23, 30, 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: _hideWidget,
                                                    child: Image.asset(
                                                        "assets/images/close.png")),
                                                Container(
                                                    child: Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/alarm.png"),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                        '알림',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 19,
                                                          fontFamily:
                                                              'Noto Sans KR',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                                Container(width: 20),
                                              ],
                                            )),
                                        Container(
                                            child: Column(
                                          children: [
                                            alertCard(),
                                            alertCard(),
                                          ],
                                        )),
                                        Expanded(
                                            child: GestureDetector(
                                                onTap: alertRatio == 0.33
                                                    ? _extendWidget
                                                    : _shrinkWidget,
                                                child: Container(
                                                    child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    alertRatio == 0.33
                                                        ? Icon(Icons
                                                            .keyboard_arrow_down)
                                                        : Icon(Icons
                                                            .keyboard_arrow_up),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 8),
                                                        child: Text(
                                                          alertRatio == 0.33
                                                              ? "더보기"
                                                              : "간략히",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Noto Sans KR',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ))
                                                  ],
                                                ))))
                                      ],
                                    ))),
                          ),
                        ]),
                      )

                      //
                    ],
                  ),
                ]));
      },
    );
  }
}

class alertCard extends StatelessWidget {
  const alertCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  '쿠독 서비스 인스타그램 친구 태그 이벤트 하고있어요!\n@kudog_email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '2022-09-15',
                  style: TextStyle(
                    color: Color(0xFF7E7E7E),
                    fontSize: 10,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class noticeCard extends StatefulWidget {
  const noticeCard(
      {super.key, required this.id, required this.title, required this.date});
  final int id;
  final String title;
  final String date;

  @override
  _noticeCardState createState() => _noticeCardState();
}

class _noticeCardState extends State<noticeCard> {
  bool iconState = false;

  void changeIcon() {
    setState(() {
      iconState = !iconState;
    });
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewPostDetailPageWidget(id: widget.id)));
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          changeIcon();
                        },
                        child: ImageIcon(
                          AssetImage(iconState
                              ? "assets/images/icon_9.png"
                              : "assets/images/icon_10.png"),
                          color: Color(0xFFCE4040),
                        ))
                  ],
                ),
              ),
              Container(
                child: Text(
                  widget.date,
                  style: TextStyle(
                    color: Color(0xFF7E7E7E),
                    fontSize: 10,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
