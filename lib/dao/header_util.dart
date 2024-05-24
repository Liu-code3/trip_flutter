import 'package:trip_flutter/dao/login_dao.dart';

///接口所需请求header信息
hiHeader() {
  Map<String, String> header = {
    "auth-token": "fuck-you-muke-flutter",
    "boarding-pass": LoginDao.getBoardingPass() ?? ''
  };
  return header;
}
