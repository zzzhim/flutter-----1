import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SearchBar(
          hideLeft: true,
          defaultText: '哈哈',
          hint: '123',
          leftButtonClick: () {
            Navigator.pop(context);
          },
          onChanged: _onTextChange,
        ),
      ),
    );
  }

  void _onTextChange(String value) {}
}
