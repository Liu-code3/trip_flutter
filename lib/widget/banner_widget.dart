import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trip_flutter/util/screen_adapter_helper.dart';

class BannerWidget extends StatefulWidget {
  final List<String> bannerList;
  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CarouselSlider(
          // 这里的items的属性要求是List<Widget> 所以需要把List<String> -> 转为 List<Widget>
          items:
              widget.bannerList.map((item) => _tabImage(item, width)).toList(),
          carouselController: _controller,
          options: CarouselOptions(
              height: 160.px,
              autoPlay: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reson) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(bottom: 10, left: 0, right: 0, child: _indicator())
      ],
    );
  }

  /// String转为Widget
  Widget _tabImage(String imageUrl, double width) {
    // GestureDetector 手势包装器
    return GestureDetector(
      onTap: () {
        // TODO NavigatorUtil. 点击图片跳转到h5
      },
      child: Image.network(
        imageUrl,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  _indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.bannerList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Colors.white)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList());
  }
}
