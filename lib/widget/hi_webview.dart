import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navifator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;

  ///禁止我的页面返回按钮
  final bool? backForbid;

  const HiWebView(
      {super.key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid});

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  ///主页代表的url
  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com.html5'
  ];
  String? url;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip.com')) {
      //fix 携程h5 http:// 无法打开问题
      url = url!.replaceAll('http://', 'htpps://');
    }
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    // 处理Android物理返回键 返回H5的上一页
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (await controller.canGoBack()) {
          //返回h5的上一页
          controller.goBack();
        } else {
          if (context.mounted) {
            NavigatorUtil.pop(context); // 在Future函数中使用context 需要判断一下页面是否在装载后
          }
        }
      },
      child: Scaffold(
        body: Column(children: [
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
              child: WebViewWidget(
            controller: controller,
          ))
        ]),
      ),
    );
  }

  void _initWebViewController() {
    // controller = WebViewController() controller.setJavaScriptMode(JavaScriptMode.unrestricted) 与 下文中的 ..等价的
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) //js调用
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
          // 导航代理
          onProgress: (int progress) {}, // 导航进度
          onPageStarted: (String url) {}, // 页面开始加载
          onPageFinished: (String url) {
            //页面加载完成之后才能执行js
            _handleBackForbid();
          }, // 页面加载完毕
          onWebResourceError: (WebResourceError error) {}, // webview报错
          onNavigationRequest: (NavigationRequest request) {
            if (_isToMain(request.url)) {
              debugPrint('阻止跳转到 $request');
              //返回到flutter页面
              NavigatorUtil.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          } // 控制哪些页面需要打开
          ))
      ..loadRequest(Uri.parse(url!));
  }

  void _handleBackForbid() {
    //利用js 动态改变h5的元素
  }

  ///判断h5是否返回主页
  bool _isToMain(String url) {
    bool contain = false;
    for (final value in _catchUrls) {
      if (url.contains(value)) {
        contain = true;
      }
    }
    return contain;
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    //获取刘海屏Top的安全边距
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: top,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, top),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [_backButton(backButtonColor), _title(backButtonColor)],
        ),
      ),
    );
  }

  _backButton(Color backButtonColor) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Icon(Icons.close, color: backButtonColor, size: 26),
      ),
    );
  }

  _title(Color backButtonColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          widget.title ?? '',
          style: TextStyle(color: backButtonColor, fontSize: 20),
        ),
      ),
    );
  }
}
