import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  static const appbarScrollOffset = 100;
  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logOut();
      },
      child: const Text('登出'));

  final bannerList = [
    'https://dimg04.c-ctrip.com/images/0AM1t12000dpfh5fv8437.jpg',
    'https://dimg04.c-ctrip.com/images/0AM6r12000cjugp0a2580.png',
    'https://dimg04.c-ctrip.com/images/0302c12000d4f5uw7BBDA_D_350_170_Q70.png',
    'https://dimg04.c-ctrip.com/images/0306c120008hel6un2E29_D_350_170_Q70.jpg'
  ];

  get _appBar => Opacity(
        opacity: appBarAlpha,
        child: Container(
          height: 80,
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('首页'),
            ),
          ),
        ),
      );

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          _logoutBtn,
          const SizedBox(
            height: 800,
            child: ListTile(
              title: Text('hh'),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
              removeTop: true, // 移除顶部空白
              context: context,
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    ///通过depth来过滤指定widget发出的滚动事件, depth == 0表示最外层的列表发出的滚动事件滚动且是列表滚动的事件
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return false;
                },
                child: _listView,
              )),
          _appBar
        ],
      ),
    );
  }

  void _onScroll(double offset) {
    print('offset: $offset');
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    print('alpha: $alpha');
    setState(() {
      appBarAlpha = alpha;
    });
    print('appBarAlpha: $appBarAlpha');
  }
}
