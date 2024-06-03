import 'package:dio/dio.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/util/navigator_util.dart';

const url = 'http://192.168.10.5:9090';
final dio = Dio();

///登录接口
class LoginDao {
  static const boardingPass = 'boading_pass';

  static login({required String userName, required String password}) async {
    Map<String, String> paramsMap = {
      'userName': userName,
      'password': password
    };
    final response = await dio.post('$url/user/login',
        data: paramsMap, options: Options(headers: hiHeader()));
    var result = response.data;
    // Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
    // String bodyString = utf8decoder.convert(response.data);
    if (response.statusCode == 200) {
      // var result = jsonDecode(bodyString);
      if (result['code'] == 200 && result['data'] != null) {
        // 保存登录令牌
        _saveBoardingPass(result['data']);
      } else {
        throw Exception(result);
      }
    } else {
      throw Exception(result);
    }
  }

  static void _saveBoardingPass(String value) {
    HiCache.getInstance().setString(boardingPass, value);
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(boardingPass);
  }

  static void logOut() {
    //移除登录保存的信息
    HiCache.getInstance().remove(boardingPass);
    NavigatorUtil.goToLogin();
  }
}
