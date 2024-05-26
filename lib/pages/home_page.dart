import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/home_dao.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/widget/banner_widget.dart';
import 'package:trip_flutter/widget/local_nav_widget.dart';

class HomePage extends StatefulWidget {
  static Config? configModel;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  static const appbarScrollOffset = 100;

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel; // 可空的意思可以避免一些空安全的问题
  SalesBox? salesBoxModel;

  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logOut();
      },
      child: const Text('登出'));

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
          LocalNavWidget(localNavList: localNavList),
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
  void initState() {
    super.initState();
    _handleRefresh();
  }

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

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        HomePage.configModel = model.config;
        localNavList =
            model.localNavList ?? []; // 或者 localNavList = model.localNavList!;
        subNavList = model.subNavList ?? [];
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList ?? [];
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
