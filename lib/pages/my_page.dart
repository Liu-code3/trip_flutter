import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
            title: const Text('我的')),
        body: const Center(
          child: Text('我的'),
        ));
  }
}
