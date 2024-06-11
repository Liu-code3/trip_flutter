import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/controller/travel_tab_controller.dart';
import 'package:trip_flutter/widget/loading_container.dart';
import 'package:trip_flutter/widget/travel_item_widget.dart';

///旅拍列表页
class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;

  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  late TravelTabController controller;

  get _gridView => MasonryGridView.count(
      controller: controller.scrollController,
      crossAxisCount: 2,
      itemCount: controller.travelItems.length,
      itemBuilder: (BuildContext context, int index) => TravelItemWidget(
            item: controller.travelItems[index],
            index: index,
          ));

  ///与GetX和Obx相比它可以监听多个GetXController的状态改变，因此它代码会更加简洁。
  ///限制：
  /// - Obx不能够嵌套Obx，且这个限制不管你是否抽离了父子组件，然而父组件的Obx控制不到子组件中的状态，或者说是不好控制。
  /// - 在使用Obx和GetX时，至少要在Obx和GetX节点下插入一个响应式变量，否则会报错误。
  get _obx => Obx(() => LoadingContainer(
      isLoading: controller.loading.value,
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: MediaQuery.removePadding(
            removeTop: true, context: context, child: _gridView),
      )));

  ///与_obx等价，和Obx不同的是，GetX更细力度的控制状态的更新；但通常用于监听1个GetXController的状态改变。
  get _getx => GetX<TravelTabController>(
      builder: (controller) {
        return LoadingContainer(
            isLoading: controller.loading.value,
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: _gridView,
              ),
            ));
      },
      init: controller);

  @override
  void initState() {
    //注意：默认情况下getx只会保留第一个GetxController的示例，为了让多个TravelTabPage都有自己的TravelTabController，需要在调用Get.put的时候给GetxController设置tag
    controller = Get.put(TravelTabController(widget.groupChannelCode),
        tag: widget.groupChannelCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: _getx);
  }

  // 在当前tab切换走的时候 再切换回来 保持当前tab数据
  @override
  dynamic noSuchMethod(Invocation invocation) => true;

  Future<void> _handleRefresh() async {
    await controller.loadData();
    return;
  }
}
