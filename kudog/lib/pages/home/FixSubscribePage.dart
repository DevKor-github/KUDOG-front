import 'package:flutter/material.dart';

class FixSubscribePageWidget extends StatefulWidget {
  const FixSubscribePageWidget({Key? key}) : super(key: key);

  @override
  _FixSubscribePageWidgetState createState() => _FixSubscribePageWidgetState();
}

class _FixSubscribePageWidgetState extends State<FixSubscribePageWidget> {
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
    bool isSelected = false;

    return Scaffold(
        backgroundColor: Color(0xFFCE4040),
        body: Column(children: [
          Container(
              height: 64,
              decoration: BoxDecoration(
                color: Color(0xFFCE4040),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 88,
                    margin: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/icon_6.png",
                          width: 21.21,
                          height: 21.34,
                          color: Colors.white,
                        ),
                        Image.asset(
                          "assets/images/icon_7.png",
                          width: 36.79,
                          height: 21.34,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '구독',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 88,
                    margin: EdgeInsets.all(15),
                    child: ImageIcon(
                        AssetImage(
                          "assets/images/icon_8.png",
                        ),
                        color: Colors.white),
                  )
                ],
              )),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(18, 12, 0, 6),
                    child: Text(
                      '구독용 이메일',
                      style: TextStyle(
                        fontFamily: 'Noto Sans KR',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7E7E7E),
                      ),
                    ),
                  ),
                  Container(
                    width: 357,
                    child: TextFormField(
                      //controller: subscribeController,
                      autofocus: true,
                      autofillHints: [AutofillHints.email],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'ⓘ 수신 받을 이메일을 입력해주세요.',
                        labelStyle: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF000000),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCDCDCD),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCDCDCD),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCDCDCD),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCDCDCD),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    color: Color(0xFFCDCDCD),
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            Container(
                              width: 173,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      width: 1.0,
                                      color: Color(0xFFCDCDCD),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(208)),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    "KUPID 전체 ㅇㅇㅇ",
                                    style: const TextStyle(
                                        color: Color(0xFF696969),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Container(
                              width: 100,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isSelected = !isSelected;
                                  });
                                },
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      width: 1.0,
                                      color: Color(0xFFCDCDCD),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(208),
                                    ),
                                    backgroundColor: isSelected
                                        ? Color(0xFFCE4040)
                                        : Colors.white,
                                  ),
                                  child: Text(
                                    "학사일정",
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Color(0xFF696969),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 167,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Color(0xFFCE4040),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(58)),
                                backgroundColor: Colors.transparent,
                              ),
                              child: Text(
                                "변경사항 저장",
                                style: const TextStyle(
                                    color: Color(0xFFCE4040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
