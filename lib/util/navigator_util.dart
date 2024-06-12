import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/pages/login_page.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

class NavigatorUtil {
  ///用于在获取不到context的地方, 如 dao 中跳转页面时使用, 需要在TabNavigator赋值
  ///注意: 若TabNavigator被销毁，_context将无法使用
  // static BuildContext? _context;
  // static bool _isPopping = false;

  // static updateContext(BuildContext context) {
  //   NavigatorUtil._context = context;
  // }

  /// 跳转到指定页面
  static push(BuildContext context, Widget page) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    //使用 getx 跳转到下一个页面，使用GetX没有了传递context的烦恼
    Get.to(page);
  }

  ///跳转到首页
  static goToHome(BuildContext context) {
    //跳转到主页并不让返回 当封装了导航页之后，就不需要再跳转到HomePage了
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const TabNavigatorPage()));
    //使用getx跳转到主页并且不让返回 offAll方法替换全部的页面
    // Get.offAll(const TabNavigatorPage());
    //   TODO 跳转首页
  }

  ///跳转到登录页
  static goToLogin() {
    //跳转到主页并不让返回
    // Navigator.pushReplacement(
    //     _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
    //使用getx跳转到登录页并且不让返回 off方法替换当前的页面
    Get.off(const LoginPage());
  }

  ///返回上一页
  static void pop(BuildContext context) {
    // if (_isPopping) return;
    // _isPopping = true;
    //
    // if (Navigator.canPop(context)) {
    //   Navigator.pop(context);
    // } else {
    //   // 退出app
    //   SystemNavigator.pop();
    // }

    // 在这 500 毫秒内，任何试图再次调用 pop 的操作都将被阻止，因为 _isPopping 为 true。
    // 500 毫秒后，回调被事件循环执行，将 _isPopping 重置为 false，允许未来的 pop 操作
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   _isPopping = false;
    // });

    //使用getx返回上一页
    Get.back();
  }

  ///跳转h5页面
  static void jumpH5(
      {BuildContext? context,
      String? url,
      String? title,
      bool? hideAppBar,
      String? statusBarColor}) {
    // BuildContext? safeContext;

    if (url == null) {
      debugPrint('url is null jumpH5 failed.');
      return;
    }

    //   if (context != null) {
    //     safeContext = context;
    //   } else if (_context?.mounted ?? false) {
    //     safeContext = _context;
    //   } else {
    //     debugPrint('context is null jumpH5 failed.');
    //     return;
    //   }
    //
    //   Navigator.push(
    //       safeContext!,
    //       MaterialPageRoute(
    //           builder: (context) => HiWebView(
    //                 url: url,
    //                 title: title,
    //                 hideAppBar: hideAppBar,
    //                 statusBarColor: statusBarColor,
    //               )));
    // }
    //使用getx跳转到H5页面
    Get.to(HiWebView(
      url: url,
      title: title,
      hideAppBar: hideAppBar,
      statusBarColor: statusBarColor,
    ));
  }
}
