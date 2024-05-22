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
      {Key? key, required this.name, required this.boxId, required this.date})
      : super(key: key);

  final String name;
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
  NoticeList noticeList = NoticeList();
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
    await Provider.of<NoticeService>(context, listen: false)
        .getSubscribedNotices(widget.boxId!, widget.date!);

    setState(() {
      noticeList =
          Provider.of<NoticeService>(context, listen: false).noticeList;
    });
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
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
                Text(widget.name,
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
                                        id: noticeList.id,
                                        name: noticeList.name,
                                        email: noticeList.email,
                                        provider: noticeList.provider,
                                        selectedCategories:
                                            noticeList.categories,
                                      ))).then((value) => _loadNotices())
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
                        onPressed: () {
                          setState(() {
                            widget.date =
                                widget.date!.subtract(Duration(days: 1));
                          });
                          _loadNotices();
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
                        onPressed: () {
                          setState(() {
                            widget.date = widget.date!.add(Duration(days: 1));
                          });
                          _loadNotices();
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
                  itemCount: noticeList.notices != null
                      ? noticeList.notices!.length
                      : 0,
                  itemBuilder: (context, index) {
                    return noticeCard(
                      notice: noticeList.notices![index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
