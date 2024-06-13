import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/main/controllers/controller.dart';

///MainViewModel的绑定类
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainViewModel>(() => MainViewModel());
  }
}
