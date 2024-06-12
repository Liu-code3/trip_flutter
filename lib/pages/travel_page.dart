import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/controller/travel_controller.dart';
import 'package:trip_flutter/model/travel_category_model.dart';
import 'package:trip_flutter/pages/travel_tab_page.dart';

class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  get _tabBar {
    return GetBuilder<TravelController>(builder: (controller) {
      return TabBar(
          controller: controller.controller,
          isScrollable: true, // 可以滚动
          tabAlignment: TabAlignment.start, // 从起始位置开始排列tab
          indicator: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xff2fcfbb), width: 2.0))),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.black,
          tabs: controller.tabs.map<Tab>((TravelTab tab) {
            return Tab(text: tab.labelName);
          }).toList());
    });
  }

  get _tabBarView {
    return GetBuilder<TravelController>(builder: (controller) {
      return TabBarView(
        controller: controller.controller,
        children: controller.tabs.map((TravelTab tab) {
          return TravelTabPage(groupChannelCode: tab.groupChannelCode);
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TravelController());
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
}
