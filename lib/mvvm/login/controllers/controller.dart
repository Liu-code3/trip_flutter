import 'package:get/get.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:url_launcher/url_launcher.dart';

/// 登陆输入框类型 枚举
enum LoginInputType { username, password }

class LoginViewModel extends GetxController {
  final loginEnable = false.obs; // 依据账号密码是否填充 提现 登录按钮状态
  String? userName;
  String? password;

  /// 输入框内容变化
  void onValueChanged(String value, LoginInputType type) {
    // 判断输入框类型
    if (type == LoginInputType.username) {
      userName = value;
    } else {
      password = value;
    }

    // 判断登录按钮是否可用
    loginEnable(userName != null &&
        userName!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty);
  }

  login() async {
    try {
      // 需要添加await等登录完成没有问题后再跳转到首页
      await LoginDao.login(userName: userName!, password: password!);
      NavigatorUtil.goToHome();
    } catch (e) {
      print(e);
    }
  }

  jumpRegistration() async {
    //跳转h5网页
    Uri uri =
        Uri.parse('https://github.com/Liu-code3/trip_flutter/commits/main/');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $uri';
    }
  }
}
