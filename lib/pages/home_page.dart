import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        actions: [
          _logoutBtn,
        ],
      ),
    );
  }
}