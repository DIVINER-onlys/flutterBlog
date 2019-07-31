import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_blog/view/Demo/Demo.dart' show Demo;
import 'package:flutter_blog/view/Personal/Personal.dart' show Personal;

class BaseTabBarPage extends StatefulWidget {
  @override
  _BaseTabBarPageState createState() => _BaseTabBarPageState();
}

class _BaseTabBarPageState extends State<BaseTabBarPage> {
  int _selectedIndex = 0;

  List<Widget> subPages = List<Widget>();

  @override
  void initState() {
    super.initState();
    subPages..add(Demo())..add(Personal());
  }

  Text _getTabBarText(String title, [int index]) {
    return Text(title);
  }

  Image _getTabBarNomalImage(String normalImage) {
    return Image.asset(normalImage, width: 24, height: 24);
  }

  Image _getTabBarSelectedImage(String selectedImage) {
    return Image.asset(selectedImage, width: 24, height: 24);
  }

  @override
  Widget build(BuildContext context) {
    // 引入屏幕适配
    ScreenUtil.instance =
        ScreenUtil(width: 720, height: 1280, allowFontScaling: true)
          ..init(context);

    return Scaffold(
      body: IndexedStack(
        children: subPages,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _getTabBarNomalImage('assets/Tab/discover-normal.png'),
            activeIcon:
                _getTabBarSelectedImage('assets/Tab/discover-selected.png'),
            title: _getTabBarText('实验室', 1),
          ),
          BottomNavigationBarItem(
            icon: _getTabBarNomalImage('assets/Tab/profile-normal.png'),
            activeIcon:
                _getTabBarSelectedImage('assets/Tab/profile-selected.png'),
            title: _getTabBarText('我的', 2),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTappedBottom,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _onTappedBottom(int selectedItem) {
    setState(() {
      _selectedIndex = selectedItem;
    });
  }
}
