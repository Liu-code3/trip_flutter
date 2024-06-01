import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

///瀑布流卡片
class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;

  const TravelItemWidget({super.key, required this.item, this.index});

  get _title => Container(
        padding: const EdgeInsets.all(4),
        child: Text(
          item.article?.articleTitle ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      );

  get _infoText => Container(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //头像和昵称
            _avatarNickName,
            //点赞和点赞树
            _lickIcon
          ],
        ),
      );

  get _avatarNickName => Row(
        children: [
          PhysicalModel(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              item.article?.author?.coverImage?.dynamicUrl ?? '',
              width: 24,
              height: 24,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: 90,
            child: Text(
              item.article?.author?.nickName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      );

  get _lickIcon => Row(
        children: [
          const Icon(Icons.thumb_up, size: 14, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              item.article?.likeCount.toString() ?? '',
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO 跳转h5
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_itemImage(context), _title, _infoText],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: size.width / 2 - 10),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.article?.images?[0].dynamicUrl ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  String _poiName() {
    return item.article?.pois == null || item.article!.pois!.isEmpty
        ? '未知'
        : item.article?.pois?[0].poiName ?? '';
  }
}
