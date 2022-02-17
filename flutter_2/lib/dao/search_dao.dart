import 'package:flutter_application_1/model/search_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // 修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));

      return SearchModel.fromJson(result);
    } else {
      throw Exception('网络错误');
    }
  }
}
