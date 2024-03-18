import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
     <h1>No Info</h1>
     <h2>There is no information</h2>
        
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
      NoticeDetail noticeDetail = noticeService.noticeDetail;
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: secondaryBackground,
        bottomSheet: Container(
            height: 66,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
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
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: const ImageIcon(
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
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                      child: ImageIcon(
                        color: const Color(0xffFFFFFF),
                        AssetImage(
                          widget.notice.scrapped!
                              ? "assets/images/icon_15.png"
                              : "assets/images/icon_16.png",
                        ),
                      ),
                    ),
                  ),
                ])),
        body: SingleChildScrollView(
          child: noticeService.noticeDetail!.id == null
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 52, 25, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 99,
                              height: 19,
                              child: Text(
                                noticeDetail.provider!,
                                style: const TextStyle(
                                  color: Color(0xFFCE4040),
                                  fontSize: 12,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            Text(
                              noticeDetail.title!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 8, 0),
                                        height: 19.08,
                                        child: Text(
                                          noticeDetail.writer!,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
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
                                          noticeDetail.date!,
                                          style: const TextStyle(
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
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(24, 0, 0, 0),
                                          child: const ImageIcon(
                                            size: 14,
                                            AssetImage(
                                                "assets/images/icon_11.png"),
                                            color: Color(0xFF7E7E7E),
                                          )),
                                      Container(
                                        height: 19.08,
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(3, 0, 0, 0),
                                        child: Text(
                                          "${noticeDetail.view!}",
                                          style: const TextStyle(
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
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 0, 0, 0),
                                          child: const ImageIcon(
                                            size: 14,
                                            AssetImage(
                                                "assets/images/icon_12.png"),
                                            color: Color(0xFF7E7E7E),
                                          )),
                                      Container(
                                          height: 19.08,
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(3, 0, 0, 0),
                                          child: Text(
                                            "${noticeDetail.scrapCount!}",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 40, 0, 0),
                                child: SingleChildScrollView(
                                    child: HtmlWidget(
                                  noticeDetail.content == null
                                      ? htmlcode
                                      : noticeDetail.content!,
                                  onTapUrl: (url) async {
                                    Uri dest = Uri.parse(url);
                                    if (await canLaunchUrl(dest)) {
                                      await launchUrl(dest);
                                    }
                                    return true;
                                  },
                                ))),
                            Container(
                              height: 100,
                            )
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
