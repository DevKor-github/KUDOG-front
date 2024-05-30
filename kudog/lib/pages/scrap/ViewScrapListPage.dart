import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/model/ScrapModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/scrap/ViewNewScrabPage.dart';
import 'package:provider/provider.dart';

class ViewScrapListPageWidget extends StatefulWidget {
  ViewScrapListPageWidget({
    Key? key,
    required this.scrapList,
    required this.boxId,
  }) : super(key: key);

  List<Scrap> scrapList;
  int boxId;

  @override
  _ViewScrapListPageWidgetState createState() =>
      _ViewScrapListPageWidgetState();
}

class _ViewScrapListPageWidgetState extends State<ViewScrapListPageWidget> {
  late List<bool> isSelected;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> iconStates = [false, false, false];
  late Dio dio;
  Scrap? scrap;
  List<Notice>? noticeList;
  int currentPage = 1;

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

  void _loadNotices() async {
    scrap =
        widget.scrapList.firstWhere((element) => element.id == widget.boxId);

    await Provider.of<NoticeService>(context, listen: false)
        .getScrappedNotices(widget.boxId);

    setState(() {
      noticeList = Provider.of<NoticeService>(context, listen: false)
          .scrapNoticeList
          .notices;
    });
  }

  void _refreshScraps() async {
    await Provider.of<NoticeService>(context, listen: false).getScraps();
    setState(() {
      widget.scrapList =
          Provider.of<NoticeService>(context, listen: false).scrapList.scraps;
      scrap =
          widget.scrapList.firstWhere((element) => element.id == widget.boxId);
    });
  }

  @override
  void initState() {
    super.initState();
    dio = Dio();

    _loadNotices();
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
        .getScrappedNotices(widget.boxId!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          title: Text(
            '스크랩 폴더',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
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
                      List.generate(widget.scrapList.length, (index) {
                    return DropdownMenuEntry(
                        value: widget.scrapList[index].id,
                        label: widget.scrapList[index].name!);
                  }),
                ),
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewNewScrapPageWidget(
                                        boxId: widget.boxId,
                                        name: scrap!.name,
                                        description: scrap!.description,
                                      ))).then((value) => {_refreshScraps()})
                        },
                    icon: Icon(Icons.settings_rounded))
              ]),
              SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  scrap!.description!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: gray1_5,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: noticeList != null ? noticeList!.length : 0,
                  itemBuilder: (context, index) {
                    return noticeCard(
                        noticeId: noticeList![index].id, isBorder: true);
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
