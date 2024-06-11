import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

import '../dao/travel_dao.dart';

class TravelTabController extends GetxController {
  final String groupChannelCode;

  TravelTabController(this.groupChannelCode);

  // 当这两个变量发生变化的时候，getx会自动更新引用这两个变量的视图。
  final travelItems = <TravelItem>[].obs; // 响应式变量
  final loading = true.obs; // 响应式变量
  int pageIndex = 1;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
  }

  @override
  onClose() {
    super.onClose();
    /**
     * 将 TabController 放在 onInit 方法中进行创建，然后在 onClose 方法中进行释放资源和销毁控制器是一种合适的做法，可以更好地管理控制器的生命周期和资源；
     * 因为onInit和onClose是成对出现的，所以在onClose方法中释放资源和销毁控制器是非常合适的。
     */
    scrollController.dispose();
  }

  Future<void> loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelTabModel? model =
          await TravelDao.getTravels(groupChannelCode, pageIndex, 10);
      List<TravelItem> items = _filterItems(model?.list);
      if (loadMore && items.isEmpty) {
        pageIndex--;
      }
      loading.value = false;
      if (!loadMore) {
        travelItems.clear();
      }
      travelItems.addAll(items);
    } catch (e) {
      //当出现类型转换异常时可以取消catchError，然后通过debug模式定位类型转换异常的字段
      debugPrint(e.toString());
      loading.value = false;
      if (loadMore) {
        pageIndex--;
      }
    }
  }

  ///移除article为空的模型
  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article != null) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }
}
