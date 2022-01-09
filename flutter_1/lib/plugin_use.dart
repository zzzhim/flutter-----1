import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

class PluginUse extends StatefulWidget {
  const PluginUse({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PluginUse> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '如何使用Flutter包和插件',
      theme: ThemeData(),
      home: MyHomePage(title: '如何使用Flutter包和插件'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '如何使用Flutter包和插件',
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Text(
              '如何使用Flutter包和插件',
              style: TextStyle(color: ColorUtil.color("black")),
            )
          ],
        ),
      ),
    );
  }
}
