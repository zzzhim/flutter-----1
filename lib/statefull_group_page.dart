import 'dart:ui';

import 'package:flutter/material.dart';

// StateFullGroup与基础组件
class StateFulGroup extends StatefulWidget {
  const StateFulGroup({Key? key}) : super(key: key);

  @override
  _StateFulGroup createState() => _StateFulGroup();
}

class _StateFulGroup extends State<StateFulGroup> {
  int _currentIndex = 0;

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
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            child: Text('悬浮'),
          ),
          body: _currentIndex == 0
              ? RefreshIndicator(
                  // 下拉刷新
                  child: ListView(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(color: Colors.white),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                'https://img2.yunyunwu.com/2021/12/23/df7c05d5a9b16.jpg',
                                width: 100,
                                height: 100,
                              ),
                              TextField(
                                // 输入文本的样式
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    hintText: '请输入',
                                    hintStyle: TextStyle(fontSize: 25)),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent),
                                child: PageView(
                                  children: <Widget>[
                                    _item('page1', Colors.deepPurple),
                                    _item('page2', Colors.red),
                                    _item('page3', Colors.blue),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  onRefresh: _handleRefresh)
              : Text('列表'),
        ));
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));

    return null;
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(title, style: TextStyle(fontSize: 22, color: Colors.white)),
    );
  }
}
