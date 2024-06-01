import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';
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
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _loading = true;
  final ScrollController _scrollController = ScrollController();

  get _gridView => MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      itemCount: travelItems.length,
      itemBuilder: (BuildContext context, int index) => TravelItemWidget(
            item: travelItems[index],
            index: index,
          ));

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
          isLoading: _loading,
          child: RefreshIndicator(
            color: Colors.blue,
            onRefresh: _loadData,
            child: MediaQuery.removePadding(
                removeTop: true, context: context, child: _gridView),
          )),
    );
  }

  Future<void> _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelTabModel? model =
          await TravelDao.getTravels(widget.groupChannelCode, pageIndex, 7);
      List<TravelItem> items = _filterItems(model?.list);
      if (loadMore && items.isEmpty) {
        pageIndex--;
      }
      setState(() {
        _loading = false;
        if (loadMore) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    } catch (e) {
      //当出现类型转换异常时可以取消catchError，然后通过debug模式定位类型转换异常的手段
      debugPrint('Travel_tab_page-loadData: ${e.toString()}');
      _loading = false;
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

  // 在当前tab切换走的时候 再切换回来 保持当前tab数据
  @override
  dynamic noSuchMethod(Invocation invocation) => true;
}
