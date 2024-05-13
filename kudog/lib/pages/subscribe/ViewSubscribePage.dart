import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/SubscribeListModel.dart';
import 'package:kudog/pages/subscribe/ViewSubscribePageList.dart';
import 'package:kudog/pages/subscribe/ViewSubscribeFilterPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewSubscribePageWidget extends StatefulWidget {
  const ViewSubscribePageWidget({Key? key}) : super(key: key);

  @override
  _ViewSubscribePageWidgetState createState() =>
      _ViewSubscribePageWidgetState();
}

class _ViewSubscribePageWidgetState extends State<ViewSubscribePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEditting = false;

  List<Subscribe> subscribeList = List.empty();
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
          .deleteSubscribes(selectedLists.toList(growable: false));
    }

    await Provider.of<NoticeService>(context, listen: false).getSubscribes();

    setState(() {
      isEditting = false;

      subscribeList =
          Provider.of<NoticeService>(context, listen: false).subscribeList;
      selectedLists.clear();
    });
  }

  void _loadSubscirbes() async {
    //filter설정된 공지사항을 가져옵니다.
    await Provider.of<NoticeService>(context, listen: false).getSubscribes();

    setState(() {
      subscribeList =
          Provider.of<NoticeService>(context, listen: false).subscribeList;
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
            height: 22,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: subscribeList.length + 1,
                itemBuilder: (context, index) {
                  return index == subscribeList.length
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
                                        .then((value) => endEditting())
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
                                selectedLists.contains(subscribeList[index].id!)
                                    ? selectedLists
                                        .remove(subscribeList[index].id!)
                                    : selectedLists
                                        .add(subscribeList[index].id!);
                              });
                            else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewSubscribePageListWidget(
                                            boxId: subscribeList[index].id,
                                            date: DateTime.now(),
                                          )));
                          },
                          child: SubscribeCard(
                              subscribe: subscribeList[index],
                              selected: selectedLists
                                  .contains(subscribeList[index].id)));
                }),
          ),
        ]),
      ),
    );
  }
}

class SubscribeCard extends StatefulWidget {
  const SubscribeCard(
      {super.key, required this.subscribe, this.selected = false});
  final Subscribe subscribe;
  final bool selected;

  @override
  _SubscribeCardState createState() => _SubscribeCardState();
}

class _SubscribeCardState extends State<SubscribeCard> {
  bool scrapState = false;

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
                widget.subscribe.name!,
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
              children: List.generate(widget.subscribe.categories!.length + 1,
                  ((index) {
            return index == 0
                ? Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 4),
                        padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                        height: 26,
                        child: Text(widget.subscribe.provider!,
                            style: TextStyle(
                                color: red1, fontWeight: FontWeight.w500)),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: red2),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: white)),
                  )
                : Container(
                    margin: EdgeInsets.only(right: 4),
                    padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                    height: 26,
                    child: Text(widget.subscribe.categories![index - 1],
                        style: TextStyle(
                            color: red1, fontWeight: FontWeight.w500)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: red2));
          })))
        ],
      ),
    );
  }
}
