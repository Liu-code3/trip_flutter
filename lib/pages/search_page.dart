import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
            title: const Text('搜索')),
        body: const Column(
          children: [
            SearchBarWidget(),
            SearchBarWidget(
              searchBarType: SearchBarType.home,
            ),
            SearchBarWidget(
              searchBarType: SearchBarType.homeLight,
            )
          ],
        ));
  }
}
