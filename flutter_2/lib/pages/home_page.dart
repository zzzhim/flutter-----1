import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/home_dao.dart';
import 'package:flutter_application_1/model/commom_model.dart';
import 'package:flutter_application_1/model/home_model.dart';
import 'package:flutter_application_1/widget/grid_nav.dart';
import 'package:flutter_application_1/widget/local_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];

  final List _imageUrls = [
    'https://img.ciyuanji.com/files/2021/12/21/19070af18a294e17ab3ef686f557d918.jpg',
    'https://img.ciyuanji.com/files/2021/12/21/0a92c623732044558f19ebe2f7af8bc1.jpg',
    'https://img.ciyuanji.com/files/2021/12/31/f6249fd270b74b75b2b86d6cd7307625.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            // 监听列表滚动
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  _onScroll(notification.metrics.pixels);
                }

                return true;
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 150,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      autoplayDelay: 3000,
                      itemBuilder: (context, index) => Image.network(
                        _imageUrls[index],
                        fit: BoxFit.fill,
                      ),
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: LocalNav(localNavList: localNavList),
                  ),

                  // GridNav(gridNavModel: null),
                  // Container(
                  //   height: 300,
                  //   child: ListTile(
                  //     title: Text(resultString),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll(double pixels) {
    double alpha = pixels / APPBAR_SCROLL_OFFSET;

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  loadData() async {
    // HomeDao.fetch().then((result) {
    //   print("1");
    //   print(json.encode(result.localNavList));
    //   setState(() {
    //     // resultString = jsonEncode(result);
    //     // localNavList = result.localNavList ?? [];
    //   });
    // }).catchError((err) {
    //   print(err);
    // });
    try {
      HomeModel res = await HomeDao.fetch();

      setState(() {
        localNavList = res.localNavList ?? [];
        // resultString = json.encode(res.config);
      });
    } catch (err) {
      print(err);
    }
  }
}
