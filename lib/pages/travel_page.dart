import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
            title: const Text('旅拍')),
        body: const Center(
          child: Text('旅拍'),
        ));
  }
}
