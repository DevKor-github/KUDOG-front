import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/pages/home/ViewPostDetailPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class noticeCard extends StatefulWidget {
  const noticeCard({super.key, required this.noticeId, this.isBorder = false});
  final int noticeId;
  final bool isBorder;
  @override
  _noticeCardState createState() => _noticeCardState();
}

class _noticeCardState extends State<noticeCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeService>(builder: (context, noticeService, child) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewPostDetailPageWidget(
                          notice: noticeService.noticeInfo(widget.noticeId)!,
                        )));
          },
          child: Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(16),
              height: 94,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.isBorder ? gray4 : Colors.transparent,
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                            color: gray4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Text(
                            '공지사항',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF787474),
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            noticeService.noticeInfo(widget.noticeId)?.title ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          noticeService.noticeInfo(widget.noticeId)?.date ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF787474),
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        onSelectScrap(noticeId: widget.noticeId);
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        child: Icon(
                          noticeService.noticeInfo(widget.noticeId)?.scrapped ??
                                  false
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          color: noticeService
                                      .noticeInfo(widget.noticeId)
                                      ?.scrapped ??
                                  false
                              ? Color(0xffFF3B47)
                              : Color(0xffCCC9C9),
                        ),
                      ))
                ],
              )));
    });
  }
}

extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

extension ScrapPicker on State {
  Future<void> onSelectScrap({required int noticeId}) async {
    await showDialog(
        context: context,
        builder: (context) {
          Rect? rect =
              ((widget.key as GlobalKey).currentContext!.globalPaintBounds);
          return Consumer<NoticeService>(
            builder: (context, noticeService, child) => Dialog(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              alignment: Alignment.bottomRight,
              insetPadding: EdgeInsets.only(
                  bottom: (rect == null)
                      ? 20
                      : MediaQuery.of(context).size.height - rect.bottom + 76,
                  right: 18),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(noticeService.scrapList.scraps.length,
                      (index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: TextButton(
                          onPressed: () async {
                            await Provider.of<NoticeService>(context,
                                    listen: false)
                                .addToScrap(
                                    noticeService.noticeInfo(noticeId)!.id,
                                    noticeService.scrapList.scraps[index].id!);
                            //Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: noticeService
                                      .noticeInfo(noticeId)!
                                      .scrapBoxId
                                      .any((element) =>
                                          element ==
                                          noticeService
                                              .scrapList.scraps[index].id)
                                  ? red1
                                  : white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8))),
                              fixedSize: Size(227, 44)),
                          child: Row(
                            children: [
                              noticeService
                                      .noticeInfo(noticeId)!
                                      .scrapBoxId
                                      .any((element) =>
                                          element ==
                                          noticeService
                                              .scrapList.scraps[index].id)
                                  ? Icon(
                                      Icons.folder,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.drive_file_move,
                                      color: Colors.black,
                                    ),
                              Text(
                                noticeService.scrapList.scraps[index].name!,
                                style: TextStyle(
                                    color: noticeService
                                            .noticeInfo(noticeId)!
                                            .scrapBoxId
                                            .any((element) =>
                                                element ==
                                                noticeService
                                                    .scrapList.scraps[index].id)
                                        ? white
                                        : black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )
                            ],
                          )),
                    );
                  })),
            ),
          );
        });
  }
}
