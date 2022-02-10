import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/grid_nav.dart';
import 'package:webview_flutter/webview_flutter.dart';

final CATCH_URLS = [
  'https://m.ctrip.com/',
  'https://m.ctrip.com/html5/',
  'https://m.ctrip.com/html5/'
];

class WebViewWidget extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;

  const WebViewWidget({
    Key? key,
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid,
  }) : super(key: key);

  @override
  _WebViewWidget createState() => _WebViewWidget();
}

class _WebViewWidget extends State<WebViewWidget> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backBtnColor;
    WebViewController? webViewController;

    if (statusBarColorStr == 'ffffff') {
      backBtnColor = Colors.black;
    } else {
      backBtnColor = Colors.white;
    }

    print(widget.url);

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
            Color(
              int.parse('0xff' + statusBarColorStr),
            ),
            backBtnColor,
          ),
          Expanded(
            child: WebView(
              initialUrl: widget.url ?? "",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                setState(() {
                  webViewController = controller;
                });
              },
              onPageStarted: (url) {
                if (CATCH_URLS.indexOf(url) != -1) {
                  if (widget.backForbid != null && widget.backForbid!) {
                    webViewController?.reload();
                  } else {
                    Navigator.pop(context);
                  }
                }
                print('webview loading...');
              },
              onPageFinished: (url) {
                print('webview success');
              },
              onWebResourceError: (error) {
                print(error);
              },
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color? backgroundColor, Color? backBtnColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      // 撑满屏幕宽度
      child: FractionallySizedBox(
        widthFactor: 1, // 撑满布局
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Icon(
                  Icons.close,
                  color: backBtnColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(color: backBtnColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
