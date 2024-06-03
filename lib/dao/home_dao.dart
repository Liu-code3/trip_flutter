import 'package:dio/dio.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

const url = 'http://192.168.10.5:9090';
final dio = Dio();

///首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await dio.get('$url/home/banner');
    if (response.statusCode == 200) {
      var data = response.data['data'];
      return HomeModel.fromJson(data);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(response);
    }
  }
}
