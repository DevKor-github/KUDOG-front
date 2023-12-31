import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewPostDetailPageWidget extends StatefulWidget {
  const ViewPostDetailPageWidget({super.key, required this.notice});
  final Notice notice;
  @override
  _ViewPostDetailPageWidgetState createState() =>
      _ViewPostDetailPageWidgetState();
}

class _ViewPostDetailPageWidgetState extends State<ViewPostDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String htmlcode = """
     <h1>H1 Title</h1>
     <h2>H2 Title</h2>
        <p>A paragraph with <strong>bold</strong> and <u>underline</u> text.</p>
        <ol>
          <li>List 1</li>
          <li>List 2<ul>
              <li>List 2.1 (nested)</li>
              <li>List 2.2</li>
             </ul>
          </li>
          <li>Three</li>
        </ol>
     <a href="https://www.hellohpc.cdom">Link to HelloHPC.com</a>
     <img src='https://www.hellohpc.com/wp-content/uploads/2020/05/flutter.png'/>
    """;

  bool isClicked = false;

  List<String> extractAttachmentUrls(String htmlContent) {
    List<String> attachmentUrls = [];

    var document = htmlParser.parse(htmlContent);

    var links = document.querySelectorAll('a');

    for (var link in links) {
      var href = link.attributes['href'];
      if (href != null) {
        attachmentUrls.add(href);
      }
    }

    return attachmentUrls;
  }

  void scrapOrNot() {
    setState(() {
      widget.notice.scrapped = !widget.notice.scrapped!;
      isClicked = !isClicked;
      NoticeService().scrapNotice(widget.notice.id!);
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NoticeService>(context, listen: false)
        .getNotice(widget.notice.id!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      NoticeDetail _noticeDetail = noticeService.noticeDetail;
      print(_noticeDetail.content);
      List<String> attachmentUrls = _noticeDetail.content == null
          ? []
          : extractAttachmentUrls(_noticeDetail.content!);

      return Scaffold(
        key: scaffoldKey,
        backgroundColor: secondaryBackground,
        bottomSheet: Container(
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
                      scrapOrNot();
                      noticeService.scrapNotice(widget.notice.id!);
                    },
                    child: Container(
                      child: ImageIcon(
                        color: Color(0xffFFFFFF),
                        AssetImage(
                          widget.notice.scrapped!
                              ? "assets/images/icon_15.png"
                              : "assets/images/icon_16.png",
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   showDialog(
                    //       context: context,
                    //       barrierDismissible: false,
                    //       builder: (BuildContext context) {
                    //         List<String> attachmentUrls =
                    //             extractAttachmentUrls(_noticeDetail.content!);
                    //         return AlertDialog(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(10.0)),
                    //           title: Column(
                    //             children: <Widget>[
                    //               Text("첨부 파일"),
                    //             ],
                    //           ),
                    //           content: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: <Widget>[
                    //               ListView.builder(
                    //                 itemCount: attachmentUrls.length,
                    //                 itemBuilder: (context, index) {
                    //                   return ListTile(
                    //                     title: Text(attachmentUrls[index]),
                    //                   );
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //           actions: <Widget>[
                    //             TextButton(
                    //               style: TextButton.styleFrom(
                    //                 padding: const EdgeInsets.all(20.0),
                    //                 foregroundColor: primary,
                    //                 textStyle: const TextStyle(fontSize: 20),
                    //               ),
                    //               child: Text("확인"),
                    //               onPressed: () {
                    //                 Navigator.pop(context);
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       });
                    // },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      child: ImageIcon(
                        color: Color(0xffFFFFFF),
                        AssetImage(
                          "assets/images/icon_14.png",
                        ),
                      ),
                    ),
                  )
                ])),
        body: SingleChildScrollView(
          child: noticeService.noticeDetail!.id == null
              ? Container()
              : Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 8, 0),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 0, 0, 0),
                                          child: ImageIcon(
                                            size: 14,
                                            AssetImage(
                                                "assets/images/icon_11.png"),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 0, 0, 0),
                                          child: ImageIcon(
                                            size: 14,
                                            AssetImage(
                                                "assets/images/icon_12.png"),
                                            color: Color(0xFF7E7E7E),
                                          )),
                                      Container(
                                          height: 19.08,
                                          alignment: Alignment.topLeft,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                            // attachmentUrls == []
                            //     ? Container()
                            //     : Container(
                            //         child: ListView.builder(
                            //           itemCount: attachmentUrls.length,
                            //           itemBuilder: (context, index) {
                            //             return Text(attachmentUrls[index]);
                            //           },
                            //         ),
                            //       ),
                            Container(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                                child: SingleChildScrollView(
                                    child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 10,
                                  child: HtmlWidget(
                                      _noticeDetail.content == null
                                          ? htmlcode
                                          : _noticeDetail.content!),
                                )))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
