import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewNewScrapPageWidget extends StatefulWidget {
  const ViewNewScrapPageWidget({Key? key, this.isEdit = false})
      : super(key: key);

  final bool isEdit;

  @override
  _ViewNewScrapPageWidgetState createState() => _ViewNewScrapPageWidgetState();
}

class _ViewNewScrapPageWidgetState extends State<ViewNewScrapPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? name;
  String? description;

  void AddScrap() async {
    await Provider.of<NoticeService>(context, listen: false)
        .addScrap(name, description);
    Navigator.pop(context);
  }

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
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.isEdit ? '폴더 설정' : '폴더 만들기',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          child: ListView(children: [
            Container(
              margin: EdgeInsets.only(bottom: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 68, bottom: 48),
                    child: Image.asset(
                      "assets/images/artboard_big.png",
                    ),
                  ),
                  Text(
                    '이름',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: gray4,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    onChanged: (value) => {name = value},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '설명',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: gray4,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    onChanged: (value) => {description = value},
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                AddScrap();
              },
              style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  minimumSize: Size.fromHeight(44),
                  backgroundColor: red1),
              child: const Text(
                '완료',
                style: TextStyle(color: white),
              ),
            )
          ]),
        ));
  }
}
