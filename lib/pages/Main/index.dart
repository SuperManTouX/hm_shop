import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _bottomNavList = [
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "name": '购物车',
    },
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "name": '首页',
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "name": '会员',
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "name": '我的',
    },
  ];

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    return List.generate(_bottomNavList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          _bottomNavList[index]["icon"]!,
          width: 30,
          height: 30,
        ),
        activeIcon: Image.asset(
          _bottomNavList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _bottomNavList[index]["name"]!,
      );
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("主页"), centerTitle: true),
      body: Center(child: Text("主页")),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          _currentIndex = currentIndex;

          setState(() {});
        },
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: getBottomNavBarItems(),
      ),
    );
  }
}
