import 'package:flutter_application_1/model/commom_model.dart';
import 'package:flutter_application_1/model/config_model.dart';
import 'package:flutter_application_1/model/grid_nav_model.dart';
import 'package:flutter_application_1/model/sales_box__model.dart';

class HomeModel {
  final ConfigModel? config;
  final List<CommonModel>? bannerList;
  final List<CommonModel>? localNavList;
  final List<CommonModel>? subNavList;
  final GridNavModel? gridNav;
  final SalesBoxModel? salesBox;

  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.subNavList,
    this.gridNav,
    this.salesBox,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['localNavList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((e) => CommonModel.fromJson(e)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var subNavListJson = json['localNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    return HomeModel(
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}
