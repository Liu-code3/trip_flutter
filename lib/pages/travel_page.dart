import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/model/travel_category_model.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelCategoryModel;

  @override
  void initState() {
    super.initState();
    getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
            title: const Text('旅拍')),
        body: Column(
          children: [Text(jsonEncode(travelCategoryModel))],
        ));
  }

  getState() async {
    try {
      TravelCategoryModel? model = await TravelDao.getCategory();
      setState(() {
        tabs = model?.tabs ?? [];
        travelCategoryModel = model;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
