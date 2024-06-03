import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/login_page.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

class NavigatorUtil {
  ///用于在获取不到context的地方, 如 dao 中跳转页面时使用, 需要在TabNavigator赋值
  ///注意: 若TabNavigator被销毁，_context将无法使用
  static BuildContext? _context;
  static bool _isPopping = false;

  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  /// 跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  ///跳转到首页
  static goToHome(BuildContext context) {
    //跳转到主页并不让返回
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  ///跳转到登录页
  static goToLogin() {
    //跳转到主页并不让返回
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  ///返回上一页
  // static void pop(BuildContext context) {
  //   if (_isPopping) return;
  //   _isPopping = true;
  //   print('fuckingStart');
  //
  //   if (Navigator.canPop(context)) {
  //     Navigator.pop(context);
  //     print('fuck1');
  //   } else {
  //     // 退出app
  //     SystemNavigator.pop();
  //     print('fuck2');
  //   }
  //
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     _isPopping = false;
  //   });
  // }
  ///返回上一页
  static void pop(BuildContext context) {
    if (_isPopping) return;
    _isPopping = true;
    print('Starting pop process');

    if (Navigator.canPop(context)) {
      print('Navigator pop called');
      Navigator.pop(context);
    } else {
      print('System navigator pop called');
      // 退出app
      SystemNavigator.pop();
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      _isPopping = false;
    });
  }

  ///跳转h5页面
  static void jumpH5(
      {BuildContext? context,
      String? url,
      String? title,
      bool? hideAppBar,
      String? statusBarColor}) {
    BuildContext? safeContext;

    if (url == null) {
      debugPrint('url is null jumpH5 failed.');
      return;
    }

    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context;
    } else {
      debugPrint('context is null jumpH5 failed.');
    }

    Navigator.push(
        safeContext!,
        MaterialPageRoute(
            builder: (context) => HiWebView(
                  url: url,
                  title: title,
                  hideAppBar: hideAppBar,
                  statusBarColor: statusBarColor,
                )));
  }
}
