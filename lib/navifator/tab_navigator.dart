import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/my_page.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/pages/travel_page.dart';
import 'package:trip_flutter/util/navigator_util.dart';

class TabNavigatorPage extends StatefulWidget {
  const TabNavigatorPage({super.key});

  @override
  State<TabNavigatorPage> createState() => _TabNavigatorStateState();
}

class _TabNavigatorStateState extends State<TabNavigatorPage> {
  final PageController _controller = PageController(
    initialPage: 0, // 默认打开的tab的索引
  );
  int _currentIndex = 0;

  final _defaultColor = Colors.grey;
  final _actionColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    //更新导航器的context，供退出登录时使用
    NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics:
            const NeverScrollableScrollPhysics(), // pageView滚动效果 这里设置为禁用左右滚动
        children: const [
          HomePage(),
          SearchPage(
            hideLeft: true,
            keyword: '北京',
          ),
          TravelPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue, // 指定底部导航栏label默认颜色 flutter版本问题
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('搜索', Icons.search, 1),
          _bottomItem('旅拍', Icons.camera_alt, 2),
          _bottomItem('我的', Icons.account_circle, 3)
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _actionColor),
        label: title);
  }
}
