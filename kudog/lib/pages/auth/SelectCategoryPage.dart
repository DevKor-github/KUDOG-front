import 'package:flutter/material.dart';
import 'package:kudog/etc/Colors.dart';
import 'package:kudog/etc/TextStyles.dart';

class SelectCategoryPageWidget extends StatefulWidget {
  const SelectCategoryPageWidget({Key? key}) : super(key: key);

  @override
  _SelectCategoryPageWidgetState createState() =>
      _SelectCategoryPageWidgetState();
}

class _SelectCategoryPageWidgetState extends State<SelectCategoryPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? keywordController = TextEditingController();
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
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: secondaryBackground,
        appBar: AppBar(
          backgroundColor: secondaryBackground,
          iconTheme: IconThemeData(color: primaryText),
          automaticallyImplyLeading: true,
          title: Text('카테고리 구독',
              style: TextStyle(
                  fontFamily: "NotoSans-Regular",
                  color: primaryText,
                  fontSize: 22,
                  fontWeight: FontWeight.w700)),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                  child: Container(
                    width: 370,
                    child: TextFormField(
                      controller: keywordController,
                      autofocus: true,
                      autofillHints: [AutofillHints.email],
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: '검색어를 입력하세요.',
                        labelStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: secondaryText,
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
                            color: primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        filled: true,
                        fillColor: secondaryBackground,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      ),
                      style: bodyMedium,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          backgroundColor: primary,
                        ),
                        child: Text(
                          "쿠독 시작하기",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
