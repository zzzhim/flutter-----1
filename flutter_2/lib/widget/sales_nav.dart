import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/commom_model.dart';
import 'package:flutter_application_1/model/grid_nav_model.dart';
import 'package:flutter_application_1/model/sales_box__model.dart';
import 'package:flutter_application_1/widget/webview.dart';
import 'package:http/http.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel? salesBox;

  const SalesBox({
    Key? key,
    required this.salesBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (salesBox == null) {
      return Column(
        children: const [],
      );
    }

    List<Widget> items = [];

    items.add(_doubleItem(
        context, salesBox!.bigCard1!, salesBox!.bigCard2!, true, false));
    items.add(_doubleItem(
        context, salesBox!.smallCard1!, salesBox!.smallCard2!, false, false));
    items.add(_doubleItem(
        context, salesBox!.smallCard3!, salesBox!.smallCard4!, false, true));

    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0xfff2f2f2),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBox!.icon!,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffff4e63),
                      Color(0xffff6cc9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WebViewWidget(
                            url: salesBox!.moreUrl ?? "",
                            title: "更多活动",
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    '获取更多福利 >',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _item(
      BuildContext context, CommonModel model, bool big, bool left, bool last) {
    BorderSide borderSide = const BorderSide(
      width: 1,
      color: Color(0xfff5C5C5),
    );

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WebViewWidget(
                  url: model.url ?? "",
                  statusBarColor: model.statusBarColor ?? "",
                  title: model.title ?? "",
                  hideAppBar: model.hideAppBar ?? false,
                  // backForbid: model.backForbid ?? "",
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: left ? borderSide : BorderSide.none,
              bottom: last ? BorderSide.none : borderSide,
            ),
          ),
          child: Image.network(
            model.icon ?? "",
            fit: BoxFit.fill,
            // 获取屏幕宽度与高度 MediaQuery.of(context).size.width
            width: MediaQuery.of(context).size.width / 2 - 10,
            height: big ? 129 : 80,
          ),
        ));
  }

  Widget _doubleItem(
    BuildContext context,
    CommonModel leftCard,
    CommonModel rightCard,
    bool big,
    bool last,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, leftCard, big, false, last),
      ],
    );
  }
}
