import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kudog/model/NotificationModel.dart';
import 'package:kudog/service/NotificationService.dart';
import 'package:kudog/service/TokenService.dart';
import 'package:provider/provider.dart';

class ViewAlarmPageWidget extends StatefulWidget {
  const ViewAlarmPageWidget({Key? key}) : super(key: key);

  @override
  _ViewAlarmPageWidgetState createState() => _ViewAlarmPageWidgetState();
}

class _ViewAlarmPageWidgetState extends State<ViewAlarmPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Records> notifications = [];
  Map<String, List<Records>> groupedByDateNotifications = {};
  late Future<void> _futureNotifications;

  @override
  void initState() {
    super.initState();
    _futureNotifications = loadAllNotifications();
  }

  Future<void> loadAllNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .getAllNotifications();
    setState(() {
      notifications = Provider.of<NotificationService>(context, listen: false)
          .notificationRecords;
      groupedByDateNotifications =
          Provider.of<NotificationService>(context, listen: false)
              .groupedByDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureNotifications,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            );
          } else {
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
                Expanded(
                  child: ListView(
                    children: groupedByDateNotifications.entries.map((entry) {
                      return DailyCard(
                        date: entry.key,
                        notifications: entry.value,
                      );
                    }).toList(),
                  ),
                )
              ],
            )));
          }
        });
  }
}

class DailyCard extends StatelessWidget {
  final String date;
  final List<Records> notifications;

  DailyCard({super.key, required this.date, required this.notifications});

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.parse(date);

    int weekday = _date.weekday;

    String weekdayName = DateFormat('EEEE', 'ko_KR').format(_date);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              date + "(" + weekdayName + ")",
              style: TextStyle(
                color: Color(0xff787474),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Text(
                        notifications[index].title ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                      if (notifications[index].isNew ?? false)
                        Image.asset("assets/images/new.png")
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
