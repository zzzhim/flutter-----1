import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/commom_model.dart';

class GridNavModel {
  final GridNavItemModel? hotel;
  final GridNavItemModel? flight;
  final GridNavItemModel? travel;

  GridNavModel({
    this.hotel,
    this.flight,
    this.travel,
  });

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItemModel.fromJson(json['hotel']),
      flight: GridNavItemModel.fromJson(json['flight']),
      travel: GridNavItemModel.fromJson(json['travel']),
    );
  }
}

class GridNavItemModel {
  final String? startColor;
  final String? endColor;
  final CommonModel? mainItem;
  final CommonModel? item1;
  final CommonModel? item2;
  final CommonModel? item3;
  final CommonModel? item4;

  GridNavItemModel({
    this.startColor,
    this.endColor,
    this.mainItem,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
  });

  factory GridNavItemModel.fromJson(Map<String, dynamic> json) {
    return GridNavItemModel(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }
}
