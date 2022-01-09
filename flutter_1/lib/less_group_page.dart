import 'package:flutter/material.dart';

class LessGroupPage extends StatelessWidget {
  const LessGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);

    return MaterialApp(
        title: 'StatelessWidget与基础组件',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('StatelessWidget与基础组件'),
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('I am Text'),
                Icon(
                  Icons.android,
                  size: 50,
                  color: Colors.red,
                ),
                CloseButton(),
                BackButton(),
                // 材料设计中一个有趣的小部件
                Chip(avatar: Icon(Icons.people), label: Text('11')),
                // 分割线
                Divider(
                  height: 10, // 容器高度,不是线的高度
                  indent: 10, // 左侧间距
                  color: Colors.orange,
                ),
                Card(
                  // 带有圆角，阴影，边框等效果的卡片
                  color: Colors.blue,
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'I am Card',
                      style: textStyle,
                    ),
                  ),
                ),
                AlertDialog(
                  title: Text('弹框'),
                  content: Text('弹框内容'),
                )
              ],
            ),
          ),
        ));
  }
}
