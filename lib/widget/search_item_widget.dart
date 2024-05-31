import 'package:flutter/material.dart';
import 'package:trip_flutter/model/search_model.dart';

class SearchItemWidget extends StatelessWidget {
  final SearchItem searchItem;

  const SearchItemWidget({super.key, required this.searchItem});

  get _item => Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // TODO 图标
            Column(
              children: [
                SizedBox(
                  width: 300,
                  child: _title,
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(top: 5),
                  child: _subTitle,
                )
              ],
            )
          ],
        ),
      );

  get _title => Text(searchItem.word ?? '');

  get _subTitle => RichText(
          text: TextSpan(children: [
        TextSpan(
            text: searchItem?.price ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.orange)),
        TextSpan(
            text: ' ${searchItem.star} ' ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.grey))
      ]));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO 跳转h5
      },
      child: _item,
    );
  }
}
