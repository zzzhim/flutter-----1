import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String showResult = '';
  Future<CommonModel> fetchPost() async {
    // final http.Response response = await http.get(
    //   Uri.parse(
    //     'https://www.jingyunshipin.com/index.php/ajax/data.html?mid=1&limit=20&page=1&tid=44',
    //   ),
    // );
    // final response = await http.get(
    //   new Uri.https(
    //     'www.jingyunshipin.com',
    //     '/index.php/ajax/data.html',
    //     {
    //       'mid': '1',
    //       'limit': '20',
    //       'page': '1',
    //       'tid': '44',
    //     },
    //   ),
    // );
    // final response = await http.get(
    //   Uri.http(
    //     'www.devio.org',
    //     '/io/flutter_app/json/test_common_model.json',
    //     {},
    //   ),
    // );
    final http.Response response = await http.get(
      Uri.parse(
        'https://www.devio.org/io/flutter_app/json/test_common_model.json',
      ),
    );

    final result = json.decode(response.body);

    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('http'),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () async {
                fetchPost().then(
                  (value) => setState(() {
                    showResult = '请求结果：\nvalue: ${value.hideAppBar}';
                  }),
                );
              },
              child: Text(
                '点我',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(showResult),
          ],
        ),
      ),
    );
  }
}

class CommonModel {
  final String? icon;
  final String? title;
  final String? url;
  final String? statusBartColor;
  final bool? hideAppBar;

  CommonModel(
      // this.icon,
      // this.title,
      // this.url,
      // this.statusBartColor,
      // this.hideAppBar,
      {
    this.icon,
    this.title,
    this.url,
    this.statusBartColor,
    this.hideAppBar,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBartColor: json['statusBartColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TabNavigator(),
//     );
//   }
// }
