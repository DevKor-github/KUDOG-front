import 'package:flutter/material.dart';
import 'package:kudog/pages/home/ViewHomePage.dart';
import 'package:kudog/pages/home/ViewMyPage.dart';
import 'package:kudog/pages/home/ViewScrabPage.dart';
import 'package:kudog/pages/home/ViewSubscribePage.dart';

class ViewMainPageWidget extends StatefulWidget {
  const ViewMainPageWidget({super.key});
  @override
  _ViewMainPageWidgetState createState() => _ViewMainPageWidgetState();
}

class _ViewMainPageWidgetState extends State<ViewMainPageWidget> {
  int _selectedIndex = 1;
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const ViewSubscribePageWidget(),
      // ViewHotPageWidget(),
      const ViewHomePageWidget(),
      const ViewScrabPageWidget(),
      const ViewMyPageWidget()
    ];

    return Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_1.png",
                      ),
                      size: 44),
                  activeIcon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_1_colored.png",
                      ),
                      size: 44),
                  label: ""),
              // BottomNavigationBarItem(
              //     icon: ImageIcon(
              //         AssetImage(
              //           "assets/images/icon_2.png",
              //         ),
              //         size: 44),
              //     activeIcon: ImageIcon(
              //         AssetImage(
              //           "assets/images/icon_2_colored.png",
              //         ),
              //         size: 44),
              //     label: ""),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_3.png",
                      ),
                      size: 44),
                  activeIcon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_3_colored.png",
                      ),
                      size: 44),
                  label: ""),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_4.png",
                      ),
                      size: 44),
                  activeIcon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_4_colored.png",
                      ),
                      size: 44),
                  label: ""),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_5.png",
                      ),
                      size: 44),
                  activeIcon: ImageIcon(
                      AssetImage(
                        "assets/images/icon_5_colored.png",
                      ),
                      size: 44),
                  label: ""),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            unselectedItemColor: const Color(0xffC6C6C6),
            selectedItemColor: const Color(0xffCE4040),
          ),
        ));
  }
}
