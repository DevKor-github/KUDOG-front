import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FixSubscribePageWidget extends StatefulWidget {
  const FixSubscribePageWidget({Key? key}) : super(key: key);

  @override
  _FixSubscribePageWidgetState createState() => _FixSubscribePageWidgetState();
}

class _FixSubscribePageWidgetState extends State<FixSubscribePageWidget> {
  late List<bool> isSelected;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> iconStates = [false, false, false];
  late Dio dio;

  void changeIcon(int index) {
    setState(() {
      iconStates[index] = !iconStates[index];
    });
  }

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(subscriptionButtonText.length, (index) => false);
    dio = Dio();
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  void changeSubscription(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  ElevatedButton _buildSubscriptionButton(int index) {
    return ElevatedButton(
      onPressed: () => changeSubscription(index),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 1.0,
          color: isSelected[index] ? Colors.transparent : Color(0xFFCDCDCD),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(208),
        ),
        backgroundColor: isSelected[index] ? Color(0xFFCE4040) : Colors.white,
      ),
      child: Text(
        subscriptionButtonText[index],
        style: TextStyle(
          color: isSelected[index] ? Colors.white : Color(0xFF696969),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> saveChanges() async {
    List<int> subscribeIds = [];
    List<int> unsubscribeIds = [];

    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        subscribeIds.add(i + 1);
      } else {
        unsubscribeIds.add(i + 1);
      }
    }

    Map<String, dynamic> requestBody = {
      "subscribeIds": subscribeIds,
      "unsubscribeIds": unsubscribeIds,
    };

    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("access_token");

      Response response = await dio.put(
        "https://api.kudog.devkor.club/category/subscribe",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: requestBody,
      );

      if (response.statusCode == 200) {
        print("PUT 요청 성공");
        print(response.data);
      } else {
        print("PUT 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("PUT 요청 에러");
      print(e.toString());
    }
  }

  List<String> subscriptionButtonText = [
    "KUPID 전체 ㅇㅇㅇ",
    "학사일정",
    "장학금",
    "무슨무슨 학부",
    "경영대학",
    "무슨학부ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ",
  ];

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
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
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: TextFormField(
                      // controller: subscribeController,
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
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: [
                                for (int i = 0;
                                    i < subscriptionButtonText.length;
                                    i++)
                                  _buildSubscriptionButton(i),
                              ],
                            ),
                          ),
                          Container(
                            width: 167,
                            height: 47,
                            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: ElevatedButton(
                              onPressed: saveChanges,
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: 1.0,
                                  color: Color(0xFFCE4040),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(58),
                                ),
                                backgroundColor: Color(0xFFCDCDCD),
                              ),
                              child: Text(
                                "변경사항 저장",
                                style: TextStyle(
                                  color: Color(0xFFCE4040),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
