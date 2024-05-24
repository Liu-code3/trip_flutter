import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/my_page.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/pages/travel_page.dart';

class TabNavigatorPage extends StatefulWidget {
  const TabNavigatorPage({super.key});

  @override
  State<TabNavigatorPage> createState() => _TabNavigatorStateState();
}

class _TabNavigatorStateState extends State<TabNavigatorPage> {
  final PageController _controller = PageController(
    initialPage: 1, // 默认打开的tab的索引
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        // physics:
        //     const NeverScrollableScrollPhysics(), // pageView滚动效果 这里设置为禁用左右滚动
        children: [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
    );
  }
}
