import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/model/travel_category_model.dart';
import 'package:trip_flutter/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelCategoryModel;
  late TabController _controller;

  get _tabBar => TabBar(
      controller: _controller,
      isScrollable: true, // 可以滚动
      tabAlignment: TabAlignment.start, // 从起始位置开始排列tab
      indicator: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xff2fcfbb), width: 2.0))),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      tabs: tabs.map<Tab>((TravelTab tab) {
        return Tab(text: tab.labelName);
      }).toList());

  get _tabBarView => TabBarView(
        controller: _controller,
        children: tabs.map((TravelTab tab) {
          return TravelTabPage(groupChannelCode: tab.groupChannelCode);
        }).toList(),
      );

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    getState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // 释放控制器占用的资源
  }

  @override
  Widget build(BuildContext context) {
    //获取刘海屏Top安全边距
    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: top + 15),
          color: Colors.white,
          child: _tabBar,
        ),
        Flexible(child: _tabBarView)
      ],
    ));
  }

  getState() async {
    try {
      TravelCategoryModel? model = await TravelDao.getCategory();
      _controller = TabController(length: model?.tabs.length ?? 0, vsync: this);
      setState(() {
        tabs = model?.tabs ?? [];
        travelCategoryModel = model;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
