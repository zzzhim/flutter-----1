import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/travel_tab_dao.dart';
import 'package:flutter_application_1/model/travel_model.dart';
import 'package:flutter_application_1/model/travel_tab_model.dart';
import 'package:flutter_application_1/pages/travel_tab_page.dart';
import 'package:flutter_application_1/widget/loading_container.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController? _controller;
  List<TravelTab> tabs = [];
  TravelTabModel? travelTabModel;
  bool _loading = true;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        _loading = false;
      });
    }).catchError((err) {
      print(err);
      setState(() {
        _loading = false;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xff2fcfbb),
                  width: 3,
                ),
                insets: EdgeInsets.only(bottom: 10),
              ),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList(),
            ),
          ),
          Flexible(
            // 自动撑开水平方向
            child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab) {
                return TravelTabPage(
                  groupChannelCode: tab.groupChannelCode,
                  travelUrl: travelTabModel?.url,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
