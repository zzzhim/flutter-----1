import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: WebViewWidget(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '415bca',
      ),
    );
  }
}
