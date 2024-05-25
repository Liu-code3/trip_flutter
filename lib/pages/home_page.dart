import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logOut();
      },
      child: const Text('登出'));

  final bannerList = [
    'https://dimg04.c-ctrip.com/images/0AM1t12000dpfh5fv8437.jpg',
    'https://dimg04.c-ctrip.com/images/0AM6r12000cjugp0a2580.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
        title: const Text('首页'),
        actions: [
          _logoutBtn,
        ],
      ),
      body: Column(
        children: [BannerWidget(bannerList: bannerList)],
      ),
    );
  }
}
