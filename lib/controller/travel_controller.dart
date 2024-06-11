import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/model/travel_category_model.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  List<TravelTab> tabs = [];
  late TabController controller;
  // late TravelCategoryModel travelCategoryModel;

  @override
  void onInit() {
    super.onInit();
    // vsync: this 参数是为了确保 TabController 的动画与其他 UI 动画同步进行，提供平滑的用户体验并避免不必要的性能消耗。在这里，this 关键字指的是当前类实例，该实例需要实现或继承自 TickerProvider 接口或类，以便为 TabController 提供一个 Ticker。Ticker 是 Flutter 内部用于驱动动画的机制，它与平台的刷新率保持同步，确保动画流畅。
    controller = TabController(length: 0, vsync: this);
    getState();
  }

  @override
  void onClose() {
    super.onClose();
    /**
     * 将 TabController 放在 onInit 方法中进行创建，然后在 onClose 方法中进行释放资源和销毁控制器是一种合适的做法，可以更好地管理控制器的生命周期和资源；
     * 因为onInit和onClose是成对出现的，所以在onClose方法中释放资源和销毁控制器是非常合适的。
     */
    controller.dispose();
  }

  getState() async {
    try {
      TravelCategoryModel? model = await TravelDao.getCategory();
      controller = TabController(
          length: model?.tabs.length ?? 0, vsync: this); //fix tab label 空白问题
      tabs = model?.tabs ?? [];
      // travelCategoryModel = model;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
