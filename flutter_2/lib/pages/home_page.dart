import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/home_dao.dart';
import 'package:flutter_application_1/model/commom_model.dart';
import 'package:flutter_application_1/model/grid_nav_model.dart';
import 'package:flutter_application_1/model/home_model.dart';
import 'package:flutter_application_1/model/sales_box__model.dart';
import 'package:flutter_application_1/widget/grid_nav.dart';
import 'package:flutter_application_1/widget/loading_container.dart';
import 'package:flutter_application_1/widget/local_nav.dart';
import 'package:flutter_application_1/widget/sales_nav.dart';
import 'package:flutter_application_1/widget/search_bar.dart';
import 'package:flutter_application_1/widget/sub_nav.dart';
import 'package:flutter_application_1/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

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
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  SalesBoxModel? salesBox;
  GridNavModel? gridNavModel;
  bool _loading = true;

  Widget get _banner {
    return Container(
      height: 150,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        autoplayDelay: 3000,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WebViewWidget(
                      url: bannerList[index].url!,
                      title: bannerList[index].title!,
                    );
                  },
                ),
              );
            },
            child: Image.network(
              bannerList[index].icon!,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBox: salesBox),
        ),
        // gridNavModel != null
        //     ? GridNav(gridNavModel: gridNavModel!)
        //     : Container(),
        Container(
          height: 300,
          child: ListTile(
            // title: Text(resultString),
            title: Text(""),
          ),
        ),
      ],
    );
  }

  // Widget get _appBar {
  //   return Opacity(
  //     opacity: appBarAlpha,
  //     child: Container(
  //       height: 80,
  //       decoration: const BoxDecoration(color: Colors.white),
  //       child: const Center(
  //         child: Padding(
  //           padding: EdgeInsets.only(top: 20),
  //           child: Text('首页'),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // AppBar 渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        )
      ],
    );
    // return SearchBar(
    //   searchBarType:
    //       appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
    //   inputBoxClick: _jumpToSearch,
    //   speakClick: _jumpToSpeak,
    //   defaultText: SEARCH_BAR_DEFAULT_TEXT,
    //   leftButtonClick: () {},
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              // 下拉刷新
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                // 监听列表滚动
                child: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification &&
                        notification.depth == 0) {
                      _onScroll(notification.metrics.pixels);
                    }

                    return false;
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar,
          ],
        ),
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

  // loadData() async {
  //   // HomeDao.fetch().then((result) {
  //   //   print("1");
  //   //   print(json.encode(result.localNavList));
  //   //   setState(() {
  //   //     // resultString = jsonEncode(result);
  //   //     // localNavList = result.localNavList ?? [];
  //   //   });
  //   // }).catchError((err) {
  //   //   print(err);
  //   // });
  //   try {
  //     HomeModel res = await HomeDao.fetch();

  //     setState(() {
  //       localNavList = res.localNavList ?? [];
  //       gridNavModel = res.gridNav;
  //       subNavList = res.subNavList ?? [];
  //       salesBox = res.salesBox;
  //       _loading = false;
  //       // resultString = json.encode(res.config);
  //     });
  //   } catch (err) {
  //     print(err);
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel res = await HomeDao.fetch();

      setState(() {
        localNavList = res.localNavList ?? [];
        gridNavModel = res.gridNav;
        subNavList = res.subNavList ?? [];
        bannerList = res.bannerList ?? [];
        salesBox = res.salesBox;
        _loading = false;
        // resultString = json.encode(res.config);
      });
    } catch (err) {
      print(err);
      setState(() {
        _loading = false;
      });
    }

    return null;
  }

  void _jumpToSearch() {}

  void _jumpToSpeak() {}
}
