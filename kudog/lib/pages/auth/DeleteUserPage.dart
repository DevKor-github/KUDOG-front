import 'package:flutter/material.dart';
import 'package:kudog/pages/auth/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:kudog/service/WithdrawalService.dart';

class DeleteUserPageWidget extends StatefulWidget {
  @override
  _DeleteUserPageWidgetState createState() => _DeleteUserPageWidgetState();
}

class _DeleteUserPageWidgetState extends State<DeleteUserPageWidget> {
  bool isChecked = false;

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
    return Consumer<WithdrawalService>(
        builder: (context, withdrawalservice, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            title: Text(
              '회원 탈퇴하기',
              style: TextStyle(
                fontFamily: "NotoSans-Regular",
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "회원탈퇴 시 유의사항",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontFamily: "Noto Sans KR",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "탈퇴 시 모든 정보가 삭제되므로, 반드시 아래 내용을 확인하세요",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: "Noto Sans KR",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
                child: Text(
                  "●   회원탈퇴 시 가입시 인증하였던 메일 정보, 기타 인적사항이 모두 삭제되며, 재가입시 다시 인증 절차가 필요합니다.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    fontFamily: "Noto Sans KR",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
                child: Text(
                  "●   생성하셨던 구독 카테고리 목록, 스크랩 목록은 모두 삭제되며, 복구할 수 없습니다.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    fontFamily: "Noto Sans KR",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 100, 0, 0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isChecked
                              ? Color(0xFFDF8383)
                              : Colors.transparent,
                          border: Border.all(
                            color: isChecked
                                ? Color(0xFFDF8383)
                                : Color(0xFFCDCDCD),
                            width: 2,
                          ),
                        ),
                        //child: isChecked ? Icon( Icons.check, color: Colors.red) : null,
                      ),
                    ),
                    SizedBox(width: 30),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Text(
                        "유의사항을 모두 확인하였으며, 회원탈퇴 시 KUDOG이 \n보관하고 있던 사용자의 모든 정보가 삭제됨에 동의합니다.",
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          fontFamily: "Noto Sans KR",
                          color:
                              isChecked ? Color(0xFFDF8383) : Color(0xFFCDCDCD),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: isChecked
                        ? () {
                            withdrawalservice.Withdrawal();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPageWidget(),
                              ),
                              (route) => false,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFCE4040),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Text('회원 탈퇴'),
                  ),
                ),
              ),
            ],
          ));
    });
  }

  void _deleteUser() {
    print('회원 탈퇴 버튼이 눌렸습니다.');
  }
}
