import 'package:flutter_application_1/model/home_model.dart';
import 'package:flutter_application_1/model/travel_tab_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// 旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    var TRAVEL_TAB_URL =
        'http://www.devio.org/io/flutter_app/json/travel_page.json';

    final response = await http.get(Uri.parse(TRAVEL_TAB_URL));

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // 修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));

      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('网络错误');
    }
  }
}
