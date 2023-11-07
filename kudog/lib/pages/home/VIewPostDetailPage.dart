import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewPostDetailPageWidget extends StatefulWidget {
  const ViewPostDetailPageWidget({super.key, required this.id});
  final int id;
  @override
  _ViewPostDetailPageWidgetState createState() =>
      _ViewPostDetailPageWidgetState();
}

class _ViewPostDetailPageWidgetState extends State<ViewPostDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isClicked = false;
  void changeIcon() {
    setState(() {
      isClicked = !isClicked;
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
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      noticeService.getNotice(widget.id);
      NoticeDetail _noticeDetail = noticeService.noticeDetail;

      return Scaffold(
        key: scaffoldKey,
        backgroundColor: secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(25, 52, 25, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 99,
                        height: 19,
                        child: Text(
                          _noticeDetail.provider!,
                          style: TextStyle(
                            color: Color(0xFFCE4040),
                            fontSize: 12,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Container(
                          child: Text(
                        _noticeDetail.title!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  height: 19.08,
                                  child: Text(
                                    _noticeDetail.writer!,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF7E7E7E),
                                      fontSize: 12,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: 100,
                                  height: 19.08,
                                  child: Text(
                                    _noticeDetail.date!,
                                    style: TextStyle(
                                      color: Color(0xFF7E7E7E),
                                      fontSize: 12,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 19.08,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 0, 0),
                                    child: ImageIcon(
                                      size: 14,
                                      AssetImage("assets/images/icon_11.png"),
                                      color: Color(0xFF7E7E7E),
                                    )),
                                Container(
                                  height: 19.08,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      3, 0, 0, 0),
                                  child: Text(
                                    "${_noticeDetail.view!}",
                                    style: TextStyle(
                                      color: Color(0xFF7E7E7E),
                                      fontSize: 12,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 19.08,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: ImageIcon(
                                      size: 14,
                                      AssetImage("assets/images/icon_12.png"),
                                      color: Color(0xFF7E7E7E),
                                    )),
                                Container(
                                    height: 19.08,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 0, 0),
                                    child: Text(
                                      "${_noticeDetail.scrapCount!}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF7E7E7E),
                                        fontSize: 12,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child: SingleChildScrollView(
                            child: Html(
                              data: _noticeDetail.content,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 66,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Color(0xFFCE4040),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x55000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: ImageIcon(
                              color: Color(0xffFFFFFF),
                              AssetImage(
                                "assets/images/icon_13.png",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changeIcon();
                          },
                          child: Container(
                            child: ImageIcon(
                              color: Color(0xffFFFFFF),
                              AssetImage(
                                isClicked
                                    ? "assets/images/icon_15.png"
                                    : "assets/images/icon_16.png",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: ImageIcon(
                            color: Color(0xffFFFFFF),
                            AssetImage(
                              "assets/images/icon_14.png",
                            ),
                          ),
                        ),
                      ]))
            ],
          ),
        ),
      );
    });
  }
}
