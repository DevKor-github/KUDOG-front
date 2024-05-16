import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/ScrapModel.dart';
import 'package:provider/provider.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/pages/scrap/ViewNewScrabPage.dart';
import 'package:kudog/pages/scrap/ViewScrapListPage.dart';

class ViewScrapPageWidget extends StatefulWidget {
  const ViewScrapPageWidget({Key? key}) : super(key: key);

  @override
  _ViewScrapPageWidgetState createState() => _ViewScrapPageWidgetState();
}

class _ViewScrapPageWidgetState extends State<ViewScrapPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isEditting = false;

  List<Scrap> scrapList = [];

  Set<int> selectedLists = Set();

  void startEditting() {
    selectedLists.clear();
    setState(() {
      isEditting = true;
    });
  }

  void endEditting() async {
    if (isEditting) {
      await Provider.of<NoticeService>(context, listen: false)
          .deleteScraps(selectedLists.toList(growable: false));
    }

    await Provider.of<NoticeService>(context, listen: false).getScraps();

    setState(() {
      isEditting = false;

      scrapList =
          Provider.of<NoticeService>(context, listen: false).scrapList.scraps!;
      selectedLists.clear();
    });
  }

  void _loadSubscirbes() async {
    await Provider.of<NoticeService>(context, listen: false).getScraps();

    setState(() {
      scrapList =
          Provider.of<NoticeService>(context, listen: false).scrapList.scraps;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadSubscirbes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(children: [
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    '스크랩 해두고\n한번에 읽어요',
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isEditting
                            ? Colors.black.withOpacity(0.5)
                            : Colors.black),
                  ),
                ),
                isEditting == true
                    ? Row(
                        children: [
                          Text(
                            '${selectedLists.length}개 선택',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: red3),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  backgroundColor: red3),
                              onPressed: () async {
                                if (selectedLists.isEmpty) {
                                  setState(() {
                                    isEditting = false;
                                  });
                                } else {
                                  endEditting();
                                }
                              },
                              child: Text(
                                selectedLists.isEmpty ? '돌아가기' : '삭제',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: white),
                              ))
                        ],
                      )
                    : TextButton(
                        onPressed: () {
                          startEditting();
                        },
                        child: Text(
                          '편집',
                          style: TextStyle(color: red1_5),
                        )),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '키워드로 검색하세요.',
                hintStyle: TextStyle(fontSize: 14, color: gray3),
                contentPadding: EdgeInsets.all(11.0),
                suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: red1),
                    onPressed: () {
                      // _loadSearchedNotices(
                      //     Filter(keyword: _searchController.text));
                    }),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        strokeAlign: BorderSide.strokeAlignInside,
                        color: gray4,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            (MediaQuery.of(context).size.width - 38) / 220,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10),
                    children: List.generate(
                        scrapList.length + 1,
                        (index) => index != scrapList.length
                            ? GestureDetector(
                                key: ValueKey(index),
                                onTap: () {
                                  if (isEditting)
                                    setState(() {
                                      selectedLists
                                              .contains(scrapList[index].id!)
                                          ? selectedLists
                                              .remove(scrapList[index].id!)
                                          : selectedLists
                                              .add(scrapList[index].id!);
                                    });
                                  else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewScrapListPageWidget(
                                                  boxId: scrapList[index].id,
                                                  scrapName:
                                                      scrapList[index].name!,
                                                  scrapDescription:
                                                      scrapList[index]
                                                          .description!,
                                                )));
                                  }
                                },
                                child: ScrapCard(
                                    scrap: scrapList[index],
                                    selected: selectedLists
                                        .contains(scrapList[index].id)),
                              )
                            : Container(
                                key: ValueKey(index),
                                margin: EdgeInsets.zero,
                                width: double.infinity,
                                height: 113,
                                child: OutlinedButton.icon(
                                    icon: const Icon(
                                      Icons.create_new_folder_outlined,
                                      size: 24,
                                    ),
                                    label: const Text(
                                      '구독함 추가',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () => {
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewNewScrapPageWidget()))
                                              .then((value) => endEditting())
                                        },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: gray1,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      minimumSize: Size.fromHeight(40),
                                    ))))))
          ]),
        ));
  }
}

class ScrapCard extends StatefulWidget {
  const ScrapCard({super.key, required this.scrap, this.selected = false});
  final Scrap scrap;
  final bool selected;

  @override
  _ScrapCardState createState() => _ScrapCardState();
}

class _ScrapCardState extends State<ScrapCard> {
  bool scrapState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: 130,
      decoration: BoxDecoration(
          color: (widget.selected) ? red2.withOpacity(0.7) : gray5,
          borderRadius: BorderRadius.all(Radius.circular(9)),
          border: (widget.selected)
              ? Border.all(color: red1, width: 2)
              : Border.all(style: BorderStyle.none)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder,
            color: red1_5,
            size: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.scrap.name!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              widget.selected
                  ? Icon(
                      Icons.check,
                      color: red1,
                      size: 44,
                    )
                  : SizedBox(
                      height: 44,
                      width: 44,
                    ),
            ],
          ),
          Text(
            "${widget.scrap.noticeCount}개의 게시물",
            style: TextStyle(
                color: gray2, fontSize: 10, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
