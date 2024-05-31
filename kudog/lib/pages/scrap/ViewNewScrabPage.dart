import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/model/ScrapModel.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:provider/provider.dart';

class ViewNewScrapPageWidget extends StatefulWidget {
  const ViewNewScrapPageWidget({Key? key, this.boxId}) : super(key: key);

  final int? boxId;

  @override
  _ViewNewScrapPageWidgetState createState() => _ViewNewScrapPageWidgetState();
}

class _ViewNewScrapPageWidgetState extends State<ViewNewScrapPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? name;
  String? description;

  final _formKey = GlobalKey<FormState>();

  bool get isEdit {
    return widget.boxId != null ? true : false;
  }

  void AddScrap() async {
    await Provider.of<NoticeService>(context, listen: false)
        .addScrap(name, description);
    Navigator.pop(context);
  }

  void EditScrap() async {
    await Provider.of<NoticeService>(context, listen: false)
        .editScrap(widget.boxId, name, description);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      Scrap scrap = Provider.of<NoticeService>(context, listen: false)
          .scrapList
          .scraps
          .firstWhere((element) => element.id == widget.boxId);

      name = scrap.name;
      description = scrap.description;
    }
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
            isEdit ? '폴더 설정' : '폴더 만들기',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          child: Form(
            key: _formKey,
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
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: gray4,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      onChanged: (value) => {name = value},
                      initialValue: name,
                      validator: (value) {
                        return (value == null || value == '')
                            ? '필수 항목입니다.'
                            : null;
                      },
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
                    TextFormField(
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      onChanged: (value) => {description = value},
                      initialValue: description,
                      validator: (value) {
                        return (value == null || value == '')
                            ? '필수 항목입니다.'
                            : null;
                      },
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isEdit)
                      EditScrap();
                    else
                      AddScrap();
                  }
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
          ),
        ));
  }
}
