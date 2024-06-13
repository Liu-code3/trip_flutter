import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainViewModel extends GetxController {
  final currentIndex = 0.obs;
  final PageController controller = PageController(initialPage: 0 // 默认打开的tab的索引
      );

  ///页面切换监听
  void onBottomNavTap(int index) {
    currentIndex(index); // num类型更新数据可以通过这种方式更新
    controller.jumpToPage(index);
  }
}
