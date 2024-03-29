import 'package:flutter/material.dart';
import 'package:kudog/pages/subscribe/ViewSubscribePageList.dart';
import 'package:kudog/pages/subscribe/ViewSubscribeFilterPage.dart';

class ViewSubscribePageWidget extends StatefulWidget {
  const ViewSubscribePageWidget({Key? key}) : super(key: key);

  @override
  _ViewSubscribePageWidgetState createState() =>
      _ViewSubscribePageWidgetState();
}

class _ViewSubscribePageWidgetState extends State<ViewSubscribePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '관심있는 소식만 빠르게 모아보세요',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewSubscribeFilterPageWidget(),
                          ));
                    },
                    child: Text(
                      '편집',
                      style: TextStyle(color: Color(0xFFFF4F59)),
                    ))
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Expanded(
                child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewSubscribePageListWidget()));
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: Color(0xffF4F2F2),
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/artboard.png"),
                          Icon(
                            Icons.settings_rounded,
                            color: Color(0xFFCCC9C9),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "디조짱",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.only(right: 4),
                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                height: 26,
                                child: Text('컴퓨터학부',
                                    style: TextStyle(
                                        color: Color(0xFFFF3B47),
                                        fontWeight: FontWeight.w500)),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Color(0xFFFFD8DA)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: Color(0xFFFFFFFF))),
                          ),
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.only(right: 4),
                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                height: 26,
                                child: Text('디자인조형학부',
                                    style: TextStyle(
                                        color: Color(0xFFFF3B47),
                                        fontWeight: FontWeight.w500)),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: Color(0x80FF3B47))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  height: 40,
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
                        foregroundColor: Color(0xFF000000),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        minimumSize: Size.fromHeight(40),
                      )))
            ])),
          ],
        ),
      ),
    );
  }
}
