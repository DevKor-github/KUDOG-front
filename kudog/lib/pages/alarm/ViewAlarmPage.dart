import 'package:flutter/material.dart';

class ViewAlarmPageWidget extends StatefulWidget {
  const ViewAlarmPageWidget({Key? key}) : super(key: key);

  @override
  _ViewAlarmPageWidgetState createState() => _ViewAlarmPageWidgetState();
}

class _ViewAlarmPageWidgetState extends State<ViewAlarmPageWidget> {
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
        body: Container(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Text("알림",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
        ),
        Column(
          children: [
            DailyCard(date: "2024. 01. 11 (수)"),
            DailyCard(date: "2024. 01. 10 (화)")
          ],
        )
      ],
    )));
  }
}

class DailyCard extends StatelessWidget {
  DailyCard({super.key, required this.date});
  final String date;
  List<String> msgs = ["인스타 이벤트 당첨자 공지", "서버 점검 공지", "인스타 이벤트 안내"];
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(date,
                  style: TextStyle(
                    color: Color(0xff787474),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ))),
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Text(msgs[index],
                                style: TextStyle(color: Colors.black)),
                            Image.asset("assets/images/new.png")
                          ],
                        ));
                  }))
        ]));
  }
}
