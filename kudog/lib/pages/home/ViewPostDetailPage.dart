import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/NoticeModel.dart';
import 'package:kudog/model/ScrapModel.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/service/ScrapBoxService.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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
  bool isButton1Clicked = false;
  bool isButton2Clicked = false;
  NoticeDetail noticeDetail = NoticeDetail();
  ScrapList _scrapList = ScrapList();
  List<String> scrapNameList = [];

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

  @override
  void initState() {
    super.initState();
    loadScrapBoxes();
    loadNoticeDetail();
  }

  Future<void> loadNoticeDetail() async {
    await Provider.of<NoticeService>(context, listen: false)
        .getNotice(widget.notice.id);
    setState(() {
      noticeDetail =
          Provider.of<NoticeService>(context, listen: false).noticeDetail;
      for (int i = 0; i < _scrapList.scraps.length; i++) {
        for (int j = 0; j < noticeDetail.scrapBoxId!.length; j++) {
          if (_scrapList.scraps[i].id == noticeDetail.scrapBoxId![j]) {
            scrapNameList.add(_scrapList.scraps[i].name!);
          }
        }
      }
    });
  }

  Future<void> loadScrapBoxes() async {
    await Provider.of<NoticeService>(context, listen: false).getScraps();
    setState(() {
      _scrapList = Provider.of<NoticeService>(context, listen: false).scrapList;
    });
    // for (int i = 0; i < _scrapList.scraps.length; i++) {
    //   scrapNameList.add()
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Color(0xffFAF8F8),
              shape: CircleBorder(),
              onPressed: () {
                String textToShare = noticeDetail.url!;
                Share.share(textToShare);
              },
              tooltip: '공유하기',
              child: Icon(Icons.upload_sharp),
            ),
            SizedBox(height: 16), // 버튼 간 간격 조절
            FloatingActionButton(
                backgroundColor: Colors.white,
                shape: CircleBorder(),
                onPressed: () {
                  onSelectScrap(noticeId: widget.notice.id);
                },
                tooltip: '스크랩',
                child: noticeService.noticeInfo(widget.notice.id)!.scrapped
                    ? Icon(Icons.bookmark, color: Color(0xffFF4F59))
                    : Icon(Icons.bookmark_outline, color: Color(0xffFF4F59)))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: noticeService.noticeDetail!.id == null
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                child: Icon(Icons.arrow_back_ios),
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                            Text("게시물",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            Container(width: 20)
                          ],
                        )),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: ShapeDecoration(
                                    color: Color(0x7FFFD8DA),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                  child: Text(
                                    noticeDetail.mappedCategory!,
                                    style: const TextStyle(
                                      color: Color(0xffFF3B47),
                                      fontSize: 12,
                                      fontFamily: 'Noto Sans KR',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 37,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: scrapNameList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 10),
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFFAF8F8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              scrapNameList[index],
                                              style: const TextStyle(
                                                color: Color(0xffFF3B47),
                                                fontSize: 12,
                                                fontFamily: 'Noto Sans KR',
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                            Text(
                              noticeDetail.title!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 8, 0),
                                        child: Text(
                                          noticeDetail.writer! + " ‧",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            color: Color(0xFF787474),
                                            fontSize: 12,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 8, 0),
                                        child: Text(
                                          noticeDetail.date!
                                              .replaceAll("-", ". "),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            color: Color(0xFF787474),
                                            fontSize: 12,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            size: 16,
                                            Icons.visibility_outlined,
                                            color: Color(0xFF787474),
                                          ),
                                          Container(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(3, 0, 8, 0),
                                            child: Text(
                                              "${noticeDetail.view!}",
                                              style: const TextStyle(
                                                color: Color(0xFF787474),
                                                fontSize: 12,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            size: 16,
                                            Icons.bookmark_outline,
                                            color: Color(0xFF787474),
                                          ),
                                          Container(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(3, 0, 0, 0),
                                              child: Text(
                                                "${noticeDetail.scrapCount!}",
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                  color: Color(0xFF787474),
                                                  fontSize: 12,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                        ],
                                      ))
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
