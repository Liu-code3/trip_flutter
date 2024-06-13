import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/login/controllers/controller.dart';

///使用Get.lazyPut()实例化LoginViewModel
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}
