import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Flutter 如何进行布局
class FlutterLayoutPage extends StatefulWidget {
  const FlutterLayoutPage({Key? key}) : super(key: key);

  @override
  _FlutterLayoutPage createState() => _FlutterLayoutPage();
}

class _FlutterLayoutPage extends State<FlutterLayoutPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 如何进行布局',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter 如何进行布局'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                title: Text(
                  '首页',
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.list,
                  color: Colors.blue,
                ),
                title: Text('列表')),
          ],
        ),
        body: _currentIndex == 0
            ? Container(
                decoration: BoxDecoration(color: Colors.white),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          // 裁剪内容
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              'https://img2.yunyunwu.com/2021/12/23/df7c05d5a9b16.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            // 圆角
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Opacity(
                              opacity: 0.6,
                              child: Image.network(
                                'https://img2.yunyunwu.com/2021/12/23/df7c05d5a9b16.jpg',
                                width: 100,
                                height: 100,
                              ),
                            ), // 60%透明度
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          // width: 375,
                          height: 100,
                          // margin: EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //   color: Colors.lightBlueAccent,
                          // ),
                          child: PhysicalModel(
                            color: Colors.transparent,
                            // 圆角
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.antiAlias, // 抗锯齿
                            child: PageView(
                              children: <Widget>[
                                _item('page1', Colors.deepPurple),
                                _item('page2', Colors.red),
                                _item('page3', Colors.blue),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(color: Colors.greenAccent),
                            child: Text('宽度撑满'),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Image.network(
                          'https://img2.yunyunwu.com/2021/12/23/df7c05d5a9b16.jpg',
                          width: 100,
                          height: 100,
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Image.network(
                            'https://img2.yunyunwu.com/2021/12/23/df7c05d5a9b16.jpg',
                            width: 36,
                            height: 36,
                          ),
                        )
                      ],
                    ),
                    Wrap(
                      // 创建一个wrap布局，从左向右进行排列，会自动换行
                      spacing: 24, // 水平间距
                      runSpacing: 12, // 垂直间距
                      children: <Widget>[
                        _chip('Flutter'),
                        _chip('进阶'),
                        _chip('实战'),
                        _chip('携程'),
                        _chip('App'),
                      ],
                    )
                  ],
                ))
            : Column(
                children: <Widget>[
                  Text('列表'),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Text('拉伸填满高度'),
                  ))
                ],
              ),
      ),
    );
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(title, style: TextStyle(fontSize: 22, color: Colors.white)),
    );
  }

  _chip(String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: Text(
          label.substring(0, 1),
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
