import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/search_dao.dart';
import 'package:flutter_application_1/model/search_model.dart';
import 'package:flutter_application_1/widget/search_bar.dart';
import 'package:flutter_application_1/widget/webview.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

const TYPES = [
  'channelplane',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup',
  'channelgroup',
  'channelgs',
  'channeltrain',
  'cruise',
];

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? searchUrl;
  final String? keyword;
  final String? hint;

  const SearchPage({
    Key? key,
    this.hideLeft = false,
    this.searchUrl = URL,
    this.keyword,
    this.hint,
  }) : super(key: key);

  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  SearchModel? searchModel;
  String? keyword;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: searchModel?.data?.length ?? 0,
                itemBuilder: (
                  BuildContext context,
                  int position,
                ) {
                  return _item(position);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChange(String value) async {
    keyword = value;

    if (value.isEmpty) {
      setState(() {
        searchModel = null;
      });

      return;
    }

    String url = widget.searchUrl! + keyword!;

    try {
      final SearchModel res = await SearchDao.fetch(url);

      setState(() {
        searchModel = res;
      });
    } catch (e) {
      print(e);
    }
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // AppBar遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  Widget _item(int position) {
    if (searchModel == null || searchModel?.data == null) {
      return Container();
    }

    SearchItem item = searchModel!.data![position];

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebViewWidget(
            url: item.url,
            title: '详情',
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.3,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                width: 26,
                height: 26,
                image: AssetImage(_typeImage(item.type)),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: _subTitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String _typeImage(String? type) {
    if (type == null) {
      return 'images/type_travelgroup.png';
    }

    String path = 'travelgroup';

    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }

    return 'images/type_$path.png';
  }

  _title(SearchItem item) {
    if (item == null) {
      return null;
    }

    List<TextSpan> spans = [];

    spans.addAll(_keywordTextSpans(item.word, keyword));
    spans.add(
      TextSpan(
        text: ' ' + (item.districtname ?? "") + ' ' + (item.zonename ?? ""),
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );

    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: item.price ?? "",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.orange,
            ),
          ),
          TextSpan(
            text: ' ' + (item.start ?? ""),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Iterable<TextSpan> _keywordTextSpans(String? word, String? keyword) {
    List<TextSpan> spans = [];

    if (word == null || word.isEmpty) return spans;

    List<String> arr = word.split(keyword!);

    TextStyle normalStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black87,
    );

    TextStyle keywordStyle = const TextStyle(
      fontSize: 16,
      color: Colors.orange,
    );

    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }

      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }

    return spans;
  }
}
