import 'package:dio/dio.dart';
import 'package:trip_flutter/model/search_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

const url = 'http://192.168.10.5:9090';
final dio = Dio();

///搜索接口
class SearchDao {
  static Future<SearchModel?> fetch(String text) async {
    final response =
        await dio.get('$url/xm/search', queryParameters: {'text': text});
    if (response.statusCode == 200) {
      final data = response.data;
      SearchModel model = SearchModel.fromJson(data);
      model.keyword = text;
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
