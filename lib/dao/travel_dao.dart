import 'package:dio/dio.dart';
import 'package:trip_flutter/model/travel_category_model.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

const url = 'http://192.168.10.5:9090';
final dio = Dio();

///旅拍模块Dao
class TravelDao {
  static Future<TravelCategoryModel?> getCategory() async {
    final response = await dio.get('$url/travel/category');
    if (response.statusCode == 200) {
      final data = response.data['data'];
      TravelCategoryModel travelCategoryModel =
          TravelCategoryModel.fromJson(data);
      return travelCategoryModel;
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(response.data);
    }
  }

  ///获取旅拍类别下的数据
  static Future<TravelTabModel?> getTravels(
      String groupChannelCode, int pageIndex, int pageSize) async {
    Map<String, String> paramsMap = {
      "pageIndex": pageIndex.toString(),
      "pageSize": pageSize.toString(),
      "groupChannelCode": groupChannelCode
    };

    final response = await dio.get('$url/travel', queryParameters: paramsMap);
    if (response.statusCode == 200) {
      final data = response.data['data'];
      TravelTabModel model = TravelTabModel.fromJson(data);
      return model;
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(response);
    }
  }
}
