import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// const CITY_NAMES = [
//   '北京',
//   '上海',
//   '广州',
//   '深圳',
//   '杭州',
//   '苏州',
//   '成都',
//   '北京',
//   '上海',
//   '广州',
//   '深圳',
//   '杭州',
//   '苏州',
//   '成都',
//   '北京',
//   '上海',
//   '广州',
//   '深圳',
//   '杭州',
//   '苏州',
//   '成都',
// ];

void main() {
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String showResult = '';
//   String countString = '';
//   String localString = '';

//   Future<CommonModel> fetchPost() async {
//     // final http.Response response = await http.get(
//     //   Uri.parse(
//     //     'https://www.jingyunshipin.com/index.php/ajax/data.html?mid=1&limit=20&page=1&tid=44',
//     //   ),
//     // );
//     // final response = await http.get(
//     //   new Uri.https(
//     //     'www.jingyunshipin.com',
//     //     '/index.php/ajax/data.html',
//     //     {
//     //       'mid': '1',
//     //       'limit': '20',
//     //       'page': '1',
//     //       'tid': '44',
//     //     },
//     //   ),
//     // );
//     // final response = await http.get(
//     //   Uri.http(
//     //     'www.devio.org',
//     //     '/io/flutter_app/json/test_common_model.json',
//     //     {},
//     //   ),
//     // );
//     final http.Response response = await http.get(
//       Uri.parse(
//         'https://www.devio.org/io/flutter_app/json/test_common_model.json',
//       ),
//     );

//     final result = json.decode(response.body);

//     return CommonModel.fromJson(result);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('http'),
//         ),
//         body: ListView(
//           scrollDirection: Axis.horizontal,
//           children: _buildList(),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildList() {
//     return CITY_NAMES.map((city) => _item(city)).toList();
//   }

//   Widget _item(city) {
//     return Container(
//       height: 80,
//       margin: EdgeInsets.only(bottom: 5),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(color: Colors.teal),
//       child: Text(
//         city,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//         ),
//       ),
//     );
//   }
// }

// class _MyAppState extends State<MyApp> {
//   String showResult = '';
//   String countString = '';
//   String localString = '';

//   Future<CommonModel> fetchPost() async {
//     // final http.Response response = await http.get(
//     //   Uri.parse(
//     //     'https://www.jingyunshipin.com/index.php/ajax/data.html?mid=1&limit=20&page=1&tid=44',
//     //   ),
//     // );
//     // final response = await http.get(
//     //   new Uri.https(
//     //     'www.jingyunshipin.com',
//     //     '/index.php/ajax/data.html',
//     //     {
//     //       'mid': '1',
//     //       'limit': '20',
//     //       'page': '1',
//     //       'tid': '44',
//     //     },
//     //   ),
//     // );
//     // final response = await http.get(
//     //   Uri.http(
//     //     'www.devio.org',
//     //     '/io/flutter_app/json/test_common_model.json',
//     //     {},
//     //   ),
//     // );
//     final http.Response response = await http.get(
//       Uri.parse(
//         'https://www.devio.org/io/flutter_app/json/test_common_model.json',
//       ),
//     );

//     final result = json.decode(response.body);

//     return CommonModel.fromJson(result);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('http'),
//         ),
//         body: Column(
//           children: [
//             RaisedButton(
//               onPressed: _incrementCounter,
//               child: Text('Increment Count'),
//             ),
//             RaisedButton(
//               onPressed: _getCounter,
//               child: Text('get Count'),
//             ),
//             Text(
//               countString,
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             Text(
//               localString,
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _incrementCounter() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       countString = countString + " 1";
//     });

//     int counter = (prefs.getInt('counter') ?? 0) + 1;
//     await prefs.setInt('counter', counter);
//   }

//   _getCounter() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       localString = prefs.getInt('counter').toString();
//     });
//   }
// }

// class CommonModel {
//   final String? icon;
//   final String? title;
//   final String? url;
//   final String? statusBartColor;
//   final bool? hideAppBar;

//   CommonModel(
//       // this.icon,
//       // this.title,
//       // this.url,
//       // this.statusBartColor,
//       // this.hideAppBar,
//       {
//     this.icon,
//     this.title,
//     this.url,
//     this.statusBartColor,
//     this.hideAppBar,
//   });

//   factory CommonModel.fromJson(Map<String, dynamic> json) {
//     return CommonModel(
//       icon: json['icon'],
//       title: json['title'],
//       url: json['url'],
//       statusBartColor: json['statusBartColor'],
//       hideAppBar: json['hideAppBar'],
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}
