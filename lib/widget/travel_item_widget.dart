import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

///瀑布流卡片
class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;

  const TravelItemWidget({super.key, required this.item, this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: size.width / 2 - 10),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.article?.images?[0].dynamicUrl ?? '',
        fit: BoxFit.cover,
      ),
    );
  }
}
