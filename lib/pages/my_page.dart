import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
        body: HiWebView(
      url: 'https://m.ctrip.com/webapp/myctrip/',
      hideAppBar: true,
      backForbid: true, // 隐藏h5界面返回按钮
      statusBarColor: '0160A0',
    ));
  }

  //切换tab的时候 不销毁我的页面
  @override
  bool get wantKeepAlive => true;
}
