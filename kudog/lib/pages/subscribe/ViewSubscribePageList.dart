import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/subscribe/ViewSubscribeFilterPage.dart';
import 'package:provider/provider.dart';

class ViewSubscribePageListWidget extends StatefulWidget {
  ViewSubscribePageListWidget(
      {Key? key, required this.boxId, required this.date})
      : super(key: key);

  final int? boxId;
  DateTime? date;

  @override
  _ViewSubscribePageListWidgetState createState() =>
      _ViewSubscribePageListWidgetState();
}

class _ViewSubscribePageListWidgetState
    extends State<ViewSubscribePageListWidget> {
  late List<bool> isSelected;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> iconStates = [false, false, false];
  late Dio dio;
  List<Notice>? noticeList;
  int currentPage = 1;

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

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

  @override
  void initState() {
    super.initState();
    dio = Dio();
    //Provider.of<CategoryService>(context, listen: false).getUpperCategoryList();
    //Provider.of<CategoryService>(context, listen: false)
    //    .getFullLowerCategoryList();
    //Provider.of<CategoryService>(context, listen: false).getSubList();
    Provider.of<NoticeService>(context, listen: false)
        .getSubscribedNotices(widget.boxId!, widget.date!);
    noticeList = Provider.of<NoticeService>(context, listen: false)
        .subscribeNoticeList
        .notices;
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  void onPageClick(int page) {
    setState(() {
      currentPage = page;
    });
    Provider.of<NoticeService>(context, listen: false)
        .getSubscribedNotices(widget.boxId!, widget.date!);
  }

  Future<void> requestMore() async {
    // setState(() {
    //   currentPage++;
    // });
    // Provider.of<NoticeService>(context, listen: false)
    //     .addSubscribedNotices(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      //noticeList = noticeService.subscribeList;

      //int totalPage = noticeService.subscribedNoticeList.totalPage ?? 1;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          leading: IconButton(
            icon: Icon(Icons.chevron_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('디조짱',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: black)),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Color(0xFF000000),
                ),
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewSubscribeFilterPageWidget(
                                        isEdit: true,
                                      )))
                        },
                    icon: Icon(Icons.settings_rounded))
              ]),
              SizedBox(
                height: 27,
              ),
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Color(0xFFF4F2F2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        iconSize: 24,
                        onPressed: () async {
                          await Provider.of<NoticeService>(context,
                                  listen: false)
                              .getSubscribedNotices(widget.boxId!,
                                  widget.date!.subtract(Duration(days: 1)));

                          setState(() {
                            widget.date =
                                widget.date!.subtract(Duration(days: 1));

                            noticeList = Provider.of<NoticeService>(context,
                                    listen: false)
                                .subscribeNoticeList
                                .notices;
                          });
                        },
                        icon: Icon(Icons.chevron_left_rounded)),
                    Text(
                      DateFormat('yyyy.MM.dd').format(widget.date!),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                        onPressed: () async {
                          await Provider.of<NoticeService>(context,
                                  listen: false)
                              .getSubscribedNotices(widget.boxId!,
                                  widget.date!.add(Duration(days: 1)));

                          setState(() {
                            widget.date = widget.date!.add(Duration(days: 1));

                            noticeList = Provider.of<NoticeService>(context,
                                    listen: false)
                                .subscribeNoticeList
                                .notices;
                          });
                        },
                        icon: Icon(Icons.chevron_right_rounded))
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
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
                  itemCount: noticeList != null ? noticeList!.length : 0,
                  itemBuilder: (context, index) {
                    return noticeCard(
                      notice: noticeList![index],
                    );
                  },
                ),
              )),
              Container(
                height: isMoreRequesting ? 50.0 : 0,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
