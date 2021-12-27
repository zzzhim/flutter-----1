import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_lifecycle.dart';
import 'package:flutter_application_1/data_type.dart';
import 'package:flutter_application_1/flutter_layout_page.dart';
import 'package:flutter_application_1/function_learn.dart';
import 'package:flutter_application_1/generic_learn.dart';
import 'package:flutter_application_1/gesture_page.dart';
import 'package:flutter_application_1/launcher_page.dart';
import 'package:flutter_application_1/less_group_page.dart';
import 'package:flutter_application_1/opp_learn.dart';
import 'package:flutter_application_1/plugin_use.dart';
import 'package:flutter_application_1/statefull_group_page.dart';

void main() {
  runApp(const DynamicTheme());
  // runApp(const MyApp());
  // runApp(const FlutterLayoutPage());
}

class DynamicTheme extends StatefulWidget {
  const DynamicTheme({Key? key}) : super(key: key);

  @override
  _DynamicTheme createState() => _DynamicTheme();
}

class _DynamicTheme extends State<DynamicTheme> {
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: brightness,
          primarySwatch: Colors.blue,
        ),
        // home: const RouteNavigator(title: 'Flutter 必备Dart基础'),
        home: Scaffold(
          appBar: AppBar(
            title: Text('如何创建和使用Flutter的路由与导航'),
          ),
          body: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (brightness == Brightness.dark) {
                      brightness = Brightness.light;
                    } else {
                      brightness = Brightness.dark;
                    }
                  });
                },
                child: Text(brightness == Brightness.dark ? '切换日间' : '切换夜间'),
              ),
              RouteNavigator()
            ],
          ),
        ),
        routes: <String, WidgetBuilder>{
          'plugin': (BuildContext context) => PluginUse(),
          'less': (BuildContext context) => LessGroupPage(),
          'ful': (BuildContext context) => StateFulGroup(),
          'layout': (BuildContext context) => FlutterLayoutPage(),
          'gesture': (BuildContext context) => GesturePage(),
          'launch': (BuildContext context) => LauncherPage(),
          'lifecycle': (BuildContext context) => AppLifecycle(),
        });
  }
}

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
        // home: const RouteNavigator(title: 'Flutter 必备Dart基础'),
        home: Scaffold(
          appBar: AppBar(
            title: Text('如何创建和使用Flutter的路由与导航'),
          ),
          body: RouteNavigator(),
        ),
        routes: <String, WidgetBuilder>{
          'plugin': (BuildContext context) => PluginUse(),
          'less': (BuildContext context) => LessGroupPage(),
          'ful': (BuildContext context) => StateFulGroup(),
          'layout': (BuildContext context) => FlutterLayoutPage(),
          'gesture': (BuildContext context) => GesturePage(),
          'launch': (BuildContext context) => LauncherPage(),
          'lifecycle': (BuildContext context) => AppLifecycle(),
        });
  }
}

class RouteNavigator extends StatefulWidget {
  // const RouteNavigator({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<RouteNavigator> createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SwitchListTile(
              title: Text('${byName ? "" : "不"}通过路由名跳转'),
              value: byName,
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              }),
          _item('PluginUse', PluginUse(), 'plugin'),
          _item('LessGroupPage', LessGroupPage(), 'less'),
          _item('StateFulGroup', StateFulGroup(), 'ful'),
          _item('FlutterLayoutPage', FlutterLayoutPage(), 'layout'),
          _item('GesturePage', GesturePage(), 'gesture'),
          _item('LauncherPage', LauncherPage(), 'launch'),
          _item('lifecycle', AppLifecycle(), 'lifecycle'),
        ],
      ),
    );
  }

  _item(String str, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(str),
      ),
    );
  }
}
