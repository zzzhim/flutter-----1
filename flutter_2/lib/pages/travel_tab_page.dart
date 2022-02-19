import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/travel_dao.dart';
import 'package:flutter_application_1/dao/travel_tab_dao.dart';
import 'package:flutter_application_1/model/travel_model.dart';
import 'package:flutter_application_1/model/travel_tab_model.dart';
import 'package:flutter_application_1/widget/loading_container.dart';
import 'package:flutter_application_1/widget/webview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String? travelUrl;
  final String groupChannelCode;

  const TravelTabPage(
      {Key? key, this.travelUrl, required this.groupChannelCode})
      : super(key: key);

  @override
  _TravelTabPageState createState() {
    return _TravelTabPageState();
  }
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool loading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: LoadingContainer(
        isLoading: loading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: MasonryGridView.count(
                controller: _scrollController,
                itemCount: travelItems.length,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return _TraveItem(index: index, item: travelItems[index]);
                },
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.groupChannelCode,
            pageIndex, PAGE_SIZE)
        .then((model) {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);

        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }

        loading = false;
      });
    }).catchError((err) {
      print(err);
      setState(() {
        loading = false;
      });
    });
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }

    List<TravelItem> filterItems = [];

    resultList.forEach((element) {
      if (element.article != null) {
        filterItems.add(element);
      }
    });

    return filterItems;
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _handleRefresh() async {
    _loadData();
  }
}

class _TraveItem extends StatelessWidget {
  final TravelItem item;
  final int index;

  const _TraveItem({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (item.article?.urls != null && item.article?.urls!.length != 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewWidget(
                  url: item.article!.urls![0].h5Url,
                  title: '详情',
                ),
              ),
            );
          }
        },
        child: Card(
          child: PhysicalModel(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    item.article?.articleTitle ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                _intoText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: [
        Image.network(item.article?.images?[0].dynamicUrl ?? ""),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: 3,
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  String _poiName() {
    var str = item.article?.pois == null || item.article!.pois!.length == 0
        ? "未知"
        : item.article!.pois![0].poiName ?? '未知';
    return str;
  }

  _intoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article?.author?.coverImage?.dynamicUrl ?? "",
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(5),
                child: Text(
                  item.article?.author?.nickName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article?.likeCount?.toString() ?? "",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
