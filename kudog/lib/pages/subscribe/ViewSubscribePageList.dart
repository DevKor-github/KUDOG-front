import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/model/SubscribeListModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/subscribe/ViewSubscribeFilterPage.dart';
import 'package:provider/provider.dart';

class ViewSubscribePageListWidget extends StatefulWidget {
  ViewSubscribePageListWidget(
      {Key? key, required this.subscribeList, required this.boxId, this.date})
      : super(key: key);

  List<Subscribe> subscribeList;
  int boxId;

  DateTime? date = DateTime.now();

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
  Subscribe? subscribe;
  List<Notice>? noticeList;
  int currentPage = 1;

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

  @override
  void initState() {
    super.initState();
    dio = Dio();

    _loadNotices();
  }

  void _loadNotices() async {
    subscribe = widget.subscribeList
        .firstWhere((element) => element.id == widget.boxId);

    await Provider.of<NoticeService>(context, listen: false)
        .getSubscribedNotices(subscribe!.id, widget.date!);

    setState(() {
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .subscribeNoticeList
          .notices;
    });
  }

  void _refreshSubscribes() async {
    await Provider.of<NoticeService>(context, listen: false).getSubscribes();

    setState(() {
      widget.subscribeList =
          Provider.of<NoticeService>(context, listen: false).subscribeList;
    });
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
        .getSubscribedNotices(subscribe!.id, widget.date!);
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
                DropdownMenu(
                  key: GlobalKey(),
                  initialSelection: widget.boxId,
                  onSelected: (value) {
                    if (value == null) return;

                    widget.boxId = value;
                    _loadNotices();
                  },
                  textStyle: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: black),
                  inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                  ),
                  dropdownMenuEntries:
                      List.generate(widget.subscribeList.length, (index) {
                    return DropdownMenuEntry(
                        value: widget.subscribeList[index].id,
                        label: widget.subscribeList[index].name);
                  }),
                ),
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewSubscribeFilterPageWidget(
                                        subscribe: subscribe,
                                      ))).then((value) => _refreshSubscribes())
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
                              .getSubscribedNotices(subscribe!.id,
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
                              .getSubscribedNotices(subscribe!.id,
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
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: noticeList != null ? noticeList!.length : 0,
                  itemBuilder: (context, index) {
                    return noticeCard(
                      key: GlobalKey(),
                      noticeId: noticeList![index].id,
                      isBorder: true,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
