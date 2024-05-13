import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';

class ViewScrabPageWidget extends StatefulWidget {
  const ViewScrabPageWidget({Key? key}) : super(key: key);

  @override
  _ViewScrabPageWidgetState createState() => _ViewScrabPageWidgetState();
}

class _ViewScrabPageWidgetState extends State<ViewScrabPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isEditting = false;

  //임시 리스트
  List<String> scrabList = ["장학 관련", "이중 전공", "장학금 모음"];

  Set<String> selectedLists = Set();

  void startEditting() {}

  void endEditting() {}

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
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                childAspectRatio:
                    (MediaQuery.of(context).size.width - 38) / 220,
                children: List.generate(
                    scrabList.length + 1,
                    (index) => index == scrabList.length
                        ? Container(
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
                                      // Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 ViewSubscribeFilterPageWidget()))
                                      //     .then((value) => endEditting())
                                    },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: gray1,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  minimumSize: Size.fromHeight(40),
                                )))
                        : GestureDetector(
                            onTap: () {
                              // if (isEditting)
                              //   setState(() {
                              //     selectedLists.contains(scrabList[index].id!)
                              //         ? selectedLists.remove(scrabList[index].id!)
                              //         : selectedLists.add(scrabList[index].id!);
                              //   });
                              // else{
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ViewSubscribePageListWidget()));
                              //}
                            },
                            child: ScrabCard(
                                title: scrabList[index], selected: false)))),
          ),
        ]),
      ),
    );
  }
}

class ScrabCard extends StatefulWidget {
  const ScrabCard({super.key, required this.title, this.selected = false});
  final String title;
  final bool selected;

  @override
  _ScrabCardState createState() => _ScrabCardState();
}

class _ScrabCardState extends State<ScrabCard> {
  bool scrabState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: 110,
      decoration: BoxDecoration(
          color: (widget.selected) ? red2.withOpacity(0.7) : gray5,
          borderRadius: BorderRadius.all(Radius.circular(9)),
          border: (widget.selected)
              ? Border.all(color: red1, width: 2)
              : Border.all(style: BorderStyle.none)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.folder,
            color: red1_5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.title!,
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
                    )
            ],
          ),
        ],
      ),
    );
  }
}
