import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/model/SubscribeListModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/pages/subscribe/ViewSubscribeFilterPage.dart';
import 'package:kudog/widgets/NoticeCard.dart';
import 'package:provider/provider.dart';

class ViewSubscribePageListWidget extends StatefulWidget {
  ViewSubscribePageListWidget({Key? key, required this.boxId, this.date})
      : super(key: key);

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
  //Subscribe? subscribe;
  //List<Notice>? noticeList;
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
        .getSubscribedNotices(widget.boxId, widget.date!);
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
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
                  dropdownMenuEntries: List.generate(
                      noticeService.subscribeList.length, (index) {
                    return DropdownMenuEntry(
                        value: noticeService.subscribeList[index].id,
                        label: noticeService.subscribeList[index].name);
                  }),
                ),
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewSubscribeFilterPageWidget(
                                        boxId: widget.boxId,
                                      ))).then((value) {
                            noticeService.getSubscribedNotices(
                                widget.boxId, widget.date!);
                          })
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
                          noticeService.getSubscribedNotices(widget.boxId,
                              widget.date!.subtract(Duration(days: 1)));

                          setState(() {
                            widget.date =
                                widget.date!.subtract(Duration(days: 1));
                            _loadNotices();
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
                          noticeService.getSubscribedNotices(widget.boxId,
                              widget.date!.add(Duration(days: 1)));

                          setState(() {
                            widget.date = widget.date!.add(Duration(days: 1));
                            _loadNotices();
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
                  itemCount:
                      noticeService.subscribeNoticeList.notices?.length ?? 0,
                  itemBuilder: (context, index) {
                    return noticeCard(
                      key: GlobalKey(),
                      noticeId:
                          noticeService.subscribeNoticeList.notices![index].id,
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
