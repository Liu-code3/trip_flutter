import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/search_dao.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
            title: const Text('搜索')),
        body: ListView(
          children: [
            SearchBarWidget(
              hideLeft: true,
              defaultText: '徐州',
              hint: '请输入',
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
            Text(showText)
          ],
        ));
  }

  void _onTextChange(String value) async {
    try {
      final result = await SearchDao.fetch(value);

      setState(() {
        showText = jsonEncode(result);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
