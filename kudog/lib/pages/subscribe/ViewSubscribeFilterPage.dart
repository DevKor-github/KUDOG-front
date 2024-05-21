import 'dart:convert';
import 'dart:html';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/pages/home/SetFilterPage.dart';
import 'package:kudog/service/NoticeService.dart';
import 'package:kudog/util/List.dart';
import 'package:provider/provider.dart';

class ViewSubscribeFilterPageWidget extends StatefulWidget {
  ViewSubscribeFilterPageWidget(
      {Key? key,
      this.name = '',
      this.email = '',
      this.provider = '',
      this.selectedCategories = const [],
      this.id})
      : super(key: key);

  int? id;
  String? name = '';
  String? email = '';
  String? provider = '';
  List<String>? selectedCategories = [];

  @override
  _ViewSubscribeFilterPageWidgetState createState() =>
      _ViewSubscribeFilterPageWidgetState();
}

class _ViewSubscribeFilterPageWidgetState
    extends State<ViewSubscribeFilterPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> majors = [];
  Map<String, List<String>> categories = {'': []};

  String name = '';
  String email = '';
  String provider = '';
  Set<String?> selectedCategories = Set();

  final _formKey = GlobalKey<FormState>();

  void AddSubscribe() async {
    await Provider.of<NoticeService>(context, listen: false)
        .addSubscribes(name, email, provider, selectedCategories.toList());
    Navigator.pop(context);
  }

  void EditSubscribe() async {
    await Provider.of<NoticeService>(context, listen: false).editSubscribes(
        widget.id, name, email, provider, selectedCategories.toList());
    Navigator.pop(context);
  }

  void _loadProvidersAndCategories() async {
    final String jsonString = await rootBundle.loadString('json/category.json');
    List<dynamic> json = jsonDecode(jsonString);

    Set<String> majorSet = Set();
    Map<String, List<String>> categoriesData = Map();

    for (int i = 0; i < json.length; i++) {
      if (majorSet.contains(json[i]['name']) == false) {
        majorSet.add(json[i]['name']);
        categoriesData[json[i]['name']] = [];
      }

      categoriesData[json[i]['name']]!.add(json[i]['mappedCategory']);
    }

    setState(() {
      categories = categoriesData;
      categories[''] = List.empty();
      majors = majorSet.toList();
    });
  }

  bool get isEdit {
    return (widget.id == null || widget.id == 0) ? false : true;
  }

  @override
  void initState() {
    super.initState();

    name = widget.name ?? '';
    email = widget.email ?? '';
    provider = widget.provider ?? '';
    selectedCategories = widget.selectedCategories == null
        ? {}
        : widget.selectedCategories!.toSet();

    _loadProvidersAndCategories();
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
            isEdit ? '구독 설정' : '구독함 만들기',
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
                    if (!isEdit)
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      onChanged: (value) => {name = value},
                      initialValue: name,
                      validator: (value) {
                        return (value == null || value == '')
                            ? '필수 항목입니다.'
                            : null;
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이메일',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      onChanged: (value) => {email = value},
                      initialValue: email,
                      validator: (value) {
                        return (value == null || value == '')
                            ? '필수 항목입니다.'
                            : null;
                      },
                    )
                  ],
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                            child: Text(
                              '학과',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            margin: EdgeInsets.only(
                              right: 12,
                            )),
                        Icon(Icons.edit_outlined)
                      ],
                    ),
                  ),
                  Row(
                      children: List.generate(
                          majors.length ~/ 2,
                          (index) => MajorCard(
                              major: majors[index],
                              onSelect: (val) => {
                                    setState(() {
                                      provider = majors[index];
                                      selectedCategories.clear();
                                    })
                                  },
                              isSelect: provider == majors[index]))),
                  Row(
                      children: List.generate(
                          majors.length - (majors.length ~/ 2),
                          (index) => MajorCard(
                              major: majors[index + (majors.length ~/ 2)],
                              onSelect: (val) => {
                                    setState(() {
                                      provider =
                                          majors[index + (majors.length ~/ 2)];
                                      selectedCategories.clear();
                                    })
                                  },
                              isSelect: provider ==
                                  majors[index + (majors.length ~/ 2)]))),
                ],
              )),
              Container(
                  margin: EdgeInsets.only(bottom: 26),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              child: Text(
                                '카테고리',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: provider == ''
                                  ? []
                                  : List.generate(
                                      (categories[provider]?.length ?? 0) ~/ 2,
                                      (index) {
                                      return CategoryCard(
                                        category: categories[provider]![index],
                                        onSelect: (val) => {
                                          val
                                              ? selectedCategories.add(
                                                  categories[provider]![index])
                                              : selectedCategories.remove(
                                                  categories[provider]![index])
                                        },
                                      );
                                    })),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: provider == ''
                                  ? []
                                  : List.generate(
                                      (categories[provider]?.length ?? 0) -
                                          ((categories[provider]?.length ??
                                                  0) ~/
                                              2), (index) {
                                      index = index +
                                          (categories[provider]!.length ~/ 2);
                                      return CategoryCard(
                                        category: categories[provider]![index],
                                        onSelect: (val) => {
                                          val
                                              ? selectedCategories.add(
                                                  categories[provider]![index])
                                              : selectedCategories.remove(
                                                  categories[provider]![index])
                                        },
                                      );
                                    }))
                        ],
                      )
                    ],
                  )),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isEdit) {
                      EditSubscribe();
                      print('edit');
                    } else {
                      AddSubscribe();
                      print('addsubscribe');
                    }
                  }
                },
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    minimumSize: Size.fromHeight(44),
                    backgroundColor: red1),
                child: const Text(
                  '저장',
                  style: TextStyle(color: white),
                ),
              )
            ]),
          ),
        ));
  }
}

class MajorCard extends StatefulWidget {
  MajorCard(
      {super.key, required this.major, this.onSelect, this.isSelect = false});
  final String major;
  final Function? onSelect;
  bool isSelect = false;
  @override
  _MajorCardState createState() => _MajorCardState();
}

class _MajorCardState extends State<MajorCard> {
  @override
  void initState() {
    super.initState();
  }

  void changeColor() {
    setState(() {
      widget.isSelect = !widget.isSelect;

      widget.onSelect!(widget.isSelect);
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: changeColor,
        child: Container(
          margin: EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: widget.isSelect ? Color(0xFFFFD8DA) : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color:
                      widget.isSelect ? Color(0xFFFF3A46) : Color(0xFF423C3C)),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isSelect
                  ? Icon(Icons.check, color: Color(0xFFFF3A46))
                  : Container(),
              Text(
                widget.major,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF423C3C),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }
}

class WeekPicker extends StatefulWidget {
  const WeekPicker({super.key});

  @override
  _WeekPickerState createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  List<String> days = ['일', '월', '화', '수', '목', '금', '토'];
  List<bool> selected = List.filled(7, false);

  @override
  void initState() {
    super.initState();
  }

  void changeColor() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(days.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected[index] = !selected[index];
              });
            },
            child: Container(
              height: 40,
              width: 40,
              child: Text(
                days[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: selected[index] ? white : gray1,
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selected[index] ? red1_5 : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          );
        }));
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category, this.onSelect});
  final String category;
  final Function? onSelect;
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  bool isClicked = false;
  void initState() {
    super.initState();
  }

  void changeColor() {
    setState(() {
      isClicked = !isClicked;

      widget.onSelect!(isClicked);
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: changeColor,
        child: Container(
          width: 125,
          margin: EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: isClicked ? Color(0xFFFFD8DA) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isClicked ? Color(0xFFFF3A46) : Colors.black,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
              isClicked ? Icon(Icons.close, color: Colors.white) : Container(),
            ],
          ),
        ));
  }
}
