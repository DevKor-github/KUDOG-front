import 'package:flutter/material.dart';

class ViewScrabPageWidget extends StatefulWidget {
  const ViewScrabPageWidget({Key? key}) : super(key: key);

  @override
  _ViewScrabPageWidgetState createState() => _ViewScrabPageWidgetState();
}

class _ViewScrabPageWidgetState extends State<ViewScrabPageWidget> {
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
    bool empty = true; // TODO : empty assign방식 변경 예정
    return Scaffold(
      backgroundColor: Color(0xFFCE4040),
      body: Column(
        children: [
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
                    '스크랩',
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
                child: empty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/image_empty.png"),
                            Text(
                              '스크랩 한 공지사항이 없어요',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFDF8383),
                                fontSize: 18,
                                fontFamily: 'Noto Sans KR',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            )
                          ],
                        ))
                    : Column(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 15),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Text(
                                            '[KUSSO] 22학년도 2학기 모자 가정 대상 봉사 공모전',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Noto Sans KR',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        ImageIcon(
                                          AssetImage(
                                              "assets/images/icon_9.png"),
                                          color: Color(0xFFCE4040),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '2022-09-15',
                                      style: TextStyle(
                                        color: Color(0xFF7E7E7E),
                                        fontSize: 10,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 15),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Text(
                                            '[KUSSO] 22학년도 2학기 모자 가정 대상 봉사 공모전',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Noto Sans KR',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        ImageIcon(
                                          AssetImage(
                                              "assets/images/icon_9.png"),
                                          color: Color(0xFFCE4040),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '2022-09-15',
                                      style: TextStyle(
                                        color: Color(0xFF7E7E7E),
                                        fontSize: 10,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 15),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: Text(
                                            '[KUSSO] 22학년도 2학기 모자 가정 대상 봉사 공모전',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Noto Sans KR',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        ImageIcon(
                                          AssetImage(
                                              "assets/images/icon_9.png"),
                                          color: Color(0xFFCE4040),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '2022-09-15',
                                      style: TextStyle(
                                        color: Color(0xFF7E7E7E),
                                        fontSize: 10,
                                        fontFamily: 'Noto Sans KR',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
          )

          //
        ],
      ),
    );
  }
}
