import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/SubscribeListModel.dart';
import 'package:kudog/pages/subscribe/ViewSubscribePageList.dart';
import 'package:kudog/pages/subscribe/ViewSubscribeFilterPage.dart';
import 'package:kudog/service/CategoryService.dart';
import 'package:provider/provider.dart';

//for testing
SubscribeList testSubscribe =
    SubscribeList(title: '초전도채짱', department: '신소재공학부');

class ViewSubscribePageWidget extends StatefulWidget {
  const ViewSubscribePageWidget({Key? key}) : super(key: key);

  @override
  _ViewSubscribePageWidgetState createState() =>
      _ViewSubscribePageWidgetState();
}

class _ViewSubscribePageWidgetState extends State<ViewSubscribePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEditting = false;

  List<SubscribeList> subscribeLists = [testSubscribe, testSubscribe];
  List<bool> selectedLists = [false, false];
  int selectedCount = 0;

  void startEditting() {
    setState(() {
      isEditting = true;
    });
    selectedLists.clear();
    selectedLists = List.filled(subscribeLists.length, false, growable: true);
    selectedCount = 0;
  }

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
                  '관심있는 소식만 빠르게 모아보세요',
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
                          '$selectedCount개 선택',
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
                              if (selectedCount == 0) {
                                setState(() {
                                  isEditting = false;
                                });
                              } else {
                                //삭제요청 api 호출
                                setState(() {});
                              }
                            },
                            child: Text(
                              selectedCount == 0 ? '돌아가기' : '삭제',
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
            height: 22,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: subscribeLists.length + (isEditting ? 1 : 0),
                itemBuilder: (context, index) {
                  return index == subscribeLists.length && isEditting
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
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewSubscribeFilterPageWidget()))
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
                            if (isEditting)
                              setState(() {
                                selectedLists[index] = !selectedLists[index];
                                selectedCount +=
                                    (selectedLists[index] ? 1 : -1);
                              });
                            else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewSubscribePageListWidget()));
                          },
                          child: SubscribeCard(
                              subscribeList: subscribeLists[index],
                              selected: selectedLists[index]));
                }),
          ),
        ]),
      ),
    );
  }
}

class SubscribeCard extends StatefulWidget {
  const SubscribeCard(
      {super.key, required this.subscribeList, this.selected = false});
  final SubscribeList subscribeList;
  final bool selected;

  @override
  _SubscribeCardState createState() => _SubscribeCardState();
}

class _SubscribeCardState extends State<SubscribeCard> {
  bool scrabState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: (widget.selected) ? red2.withOpacity(0.7) : gray5,
          borderRadius: BorderRadius.all(Radius.circular(9)),
          border: (widget.selected)
              ? Border.all(color: red1, width: 2)
              : Border.all(style: BorderStyle.none)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/artboard.png"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.subscribeList.title!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          Row(
            children: [
              Flexible(
                child: Container(
                    margin: EdgeInsets.only(right: 4),
                    padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                    height: 26,
                    child: Text(widget.subscribeList.department!,
                        style: TextStyle(
                            color: red1, fontWeight: FontWeight.w500)),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: red2),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: white)),
              ),
              Flexible(
                child: Container(
                    margin: EdgeInsets.only(right: 4),
                    padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                    height: 26,
                    child: Text('학과..',
                        style: TextStyle(
                            color: red1, fontWeight: FontWeight.w500)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: red2)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
