import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_type.dart';
import 'package:flutter_application_1/flutter_layout_page.dart';
import 'package:flutter_application_1/function_learn.dart';
import 'package:flutter_application_1/generic_learn.dart';
import 'package:flutter_application_1/less_group_page.dart';
import 'package:flutter_application_1/opp_learn.dart';
import 'package:flutter_application_1/plugin_use.dart';
import 'package:flutter_application_1/statefull_group_page.dart';

void main() {
  // runApp(const MyApp());
  runApp(const FlutterLayoutPage());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 必备Dart基础',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter 必备Dart基础'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    _oopLearn();
    _functionLearn();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
            // children: <Widget>[DataType()],
            ),
      ),
    );
  }

  void _oopLearn() {
    print('--------_oopLearn------------');

    Logger log1 = Logger();
    Logger log2 = Logger();
    print(log1 == log2);

    Student.doPrint('_oopLearn');

    // 创建 Student 的对象
    Student stu1 = Student('家里蹲', 'zzzhim', 18);
    stu1.school = '985';

    print(stu1.toString());

    Student stu2 = Student('家里蹲2', 'zzzhim', 16, city: '上海', country: '中国');

    print(stu2.toString());

    StudyFlutter studyFlutter = StudyFlutter();

    studyFlutter.study();

    print('--------_oopLearn------------');
  }

  void _functionLearn() {
    TestFunction testFunction = TestFunction();
    testFunction.start();

    TestGeneric testGeneric = TestGeneric();
    testGeneric.start();
  }
}
