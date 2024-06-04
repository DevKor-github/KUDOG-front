import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void loadPrivacyRule(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: <Widget>[
              Text("KUDOG 개인정보 처리방침",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  )),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "KUDOG은 정보주체의 자유와 권리 보호를 위해 개인정보 보호법 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 개인정보 보호법 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 및 공개합니다.")),
                Divider(
                  color: Colors.black, // 구분선 색상 설정
                  thickness: 1.0, // 구분선 두께 설정
                ),
                Container(
                    child: Text(
                  "개인정보의 처리 목적",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "KUDOG은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.")),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "1. 회원 가입 및 관리\n회원제 서비스 제공에 따른 유저 식별 및 인증 목적으로 개인정보를 처리합니다.")),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "2. 서비스 제공\n이메일 전송 서비스 제공을 위한 목적으로 이메일 주소를 수집하여 사용합니다.")),
                Container(
                    child: Text(
                  "\n처리하는 개인정보 항목",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "KUDOG은 다음의 개인정보 항목을 처리하고 있습니다.",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "1. 회원 가입 및 관리 \n - 필수 항목 : 이메일 주소",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "2. 서비스 제공\n- 필수 항목 : 이메일 주소",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "\n개인정보의 처리 및 보유 기간",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                )),
                Container(
                    child: Text(
                  "1. KUDOG은 법령에 따른 개인정보 보유, 이용 기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유, 이용기간 내에서 개인정보를 처리, 보유합니다.",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "2. 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다\n- 회원 가입 및 관리 : 앱 탈퇴 / 서비스 종료 시까지\n- 서비스 제공 : 앱 탈퇴 / 서비스 종료 시까지",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "\n개인정보의 파기 절차 및 방법",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                  "1. KUDOG은 개인정보 보유기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "2. 개인 정보 파기의 절차 및 방법은 다음과 같습니다.\n- 파기 절차\nKUDOG은 파기 사유가 발생 시 해당 유저의 모든 개인정보를 즉각 데이터베이스에서 삭제합니다.\n - 파기 방법\nKUDOG은 개인정보를 암호화하여 본 서비스 소유의 데이터베이스에 저장하고 있습니다. 해당 데이터는 파일 형태로 기록되지 않도록 로그와 함께 즉각 삭제합니다.")),
                Container(
                    child: Text(
                  "\n정보 주체와 법정 대리인의 권리, 의무 및 행사 방법",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "1. 정보 주체는 KUDOG에 대해 언제든지 개인정보 열람, 정정, 삭제, 처리정지 요구 등의 권리를 행사할 수 있습니다.")),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "2. 권리 행사는 KUDOG에 대해 이메일, 개인정보 보호 책임자 등의 연락 방법을 통하여 하실 수 있으며, KUDOG은 이에 대해 즉각 조치합니다.")),
                Container(
                    child: Text(
                  "\n개인정보의 안전성 확보 조치",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                )),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "KUDOG은 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n- 기술적 조치 : 서버, 데이터베이스 접근 권한 관리, JWT 인증 시스템, 개인정보의 암호화")),
                Container(
                    child: Text(
                  "\n개인정보 보호 책임자",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "1. KUDOG은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보 주체의 불만 처리 및 피해 구제 등을 위하여 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다. 해당 연락처를 통해 개인정보 열람 청구 업무도 신청할 수 있습니다.")),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "- 개인정보 보호 책임자\n- 연락처 : devkor.apply@gmail.com")),
                Container(
                    child: Text(
                  "\n동의 거부 관리",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Pretendard',
                  ),
                )),
                Container(
                    child: Text(
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                        ),
                        "사용자는 본 안내에 따른 개인정보 수집 및 이용에 대하여 동의를 거부할 권리가 있습니다. 다만, 개인 정보 수집 동의 거부 시 서비스 사용이 불가능할 수 있습니다.\n이 개인정보 처리 방침은 2024년 1월 16일부터 적용됩니다.")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(20.0),
                foregroundColor: Color(0xffFF4F59),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Text(
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                  ),
                  "확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
