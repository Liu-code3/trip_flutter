import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navifator_util.dart';

import '../model/home_model.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      height: 64,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.jumpH5(context: context, url: model.url, title: '详情');
      },
      child: Column(
        children: [
          Image.network(
            model.icon ?? '',
            width: 32,
            height: 32,
          ),
          Text(
            model.title ?? '',
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
