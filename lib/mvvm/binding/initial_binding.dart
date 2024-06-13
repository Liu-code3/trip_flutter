import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/main/binding/main_binding.dart';

/// 工程级别的绑定 用来注入工程中所有的依赖
class InitialBinding implements Bindings {
  @override
  void dependencies() {
    MainBinding().dependencies(); // 不是静态方法 所以调用实例方法
  }
}
