import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/commom_model.dart';
import 'package:flutter_application_1/model/grid_nav_model.dart';
import 'package:flutter_application_1/widget/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;

  const GridNav({
    Key? key,
    this.gridNavModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];

    if (gridNavModel == null) {
      return items;
    }

    if (gridNavModel?.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel!.hotel!, true));
    }

    if (gridNavModel?.flight != null) {
      items.add(_gridNavItem(context, gridNavModel!.flight!, false));
    }

    if (gridNavModel?.travel != null) {
      items.add(_gridNavItem(context, gridNavModel!.travel!, false));
    }

    return items;
  }

  _gridNavItem(BuildContext context, GridNavItemModel gridNavItem, bool first) {
    List<Widget> items = [];

    if (gridNavItem.mainItem == null) {
      return Container();
    }

    items.add(_maninItem(context, gridNavItem.mainItem!));
    items.add(_doubleItem(context, gridNavItem.item1!, gridNavItem.item2!));
    items.add(_doubleItem(context, gridNavItem.item3!, gridNavItem.item4!));

    List<Widget> expandItems = [];

    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });

    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor!));

    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor!));

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 线性渐变
        gradient: LinearGradient(
          colors: [
            startColor,
            endColor,
          ],
        ),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _maninItem(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewWidget(
              url: model.url,
              title: model.title,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
            ),
          ),
        );
      },
      child: _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              model.icon ?? "",
              fit: BoxFit.contain,
              width: 121,
              height: 88,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 14),
              child: Text(
                model.title ?? "",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        model,
      ),
    );
  }

  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(
      width: 0.8,
      color: Colors.white,
    );

    return FractionallySizedBox(
      // 撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(
          context,
          Center(
            child: Text(
              item.title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          item,
        ),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewWidget(
              url: model.url,
              title: model.title,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
            ),
          ),
        );
      },
      child: widget,
    );
  }
}
