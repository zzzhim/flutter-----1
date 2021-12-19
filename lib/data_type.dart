import 'package:flutter/material.dart';

// 常用数据类型
class DataType extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DataType> {
  @override
  Widget build(BuildContext context) {
    _numType();
    _stringType();
    _boolType();
    _listType();
    _mapType();
    return Container(
      child: Text('常用数据类型，请查看控制台输出'),
    );
  }

  // 数字类型
  void _numType() {
    num num1 = -1.0; // 是数字类型的父类
    num num2 = 2; // 是数字类型的父类

    int int1 = 3; // 只能接收整数
    double d1 = 1.68; // 双精度

    print("num: $num1 num: $num2 int: $int1 double: $d1");

    print(num1.abs()); // 求绝对值
    print(num1.toInt()); // 转换成int
    print(num2.toDouble()); // 转换成double
  }

  // 字符串
  void _stringType() {
    String str1 = '字符串1', str2 = "字符串2"; // 字符串定义
    String str3 = str1 + str2;
    String str4 = "字符串拼接\$: $str1 and $str2";
    String str5 = "常用数据类型，请查看控制台输出";

    print(str1);
    print(str2);
    print(str3);
    print(str4);

    // 常用方法
    print(str5.substring(0, 5));
    print(str5.indexOf('控制'));
  }

  // 布尔，Dart 是强 bool 类型检查，只有bool 类型的值是true 才被认为是 true
  void _boolType() {
    bool success = true, fail = false;

    print(success);
    print(fail);
    print(success || fail); // true
    print(success && fail); // true
  }

  // 集合
  void _listType() {
    print('-------_listType------');
    // 集合初始的方式
    List list1 = [1, 2, 3, '集合']; // 初始化时添加元素 默认类型 dynamic
    print(list1);
    List<int> list2 = [1, 2, 3]; // 指定元素为 int 类型
    print(list2);

    List list3 = [];

    list3.add('list3'); // 通过add方法添加元素
    list3.addAll(list1);

    print(list3);

    List list4 = List.generate(3, (index) => index * 2); // 生成函数生成集合

    print(list4);

    // 遍历集合
    for (int i = 0; i < list3.length; i++) {
      print(list3[i]);
    }

    for (var item in list3) {
      print(item);
    }

    list3.forEach((element) {
      print(element);
    });
  }

  // map是将key和value相关联的对象，key和value都可以是任何类型的对象，并且key是唯一的如果key重复后面添加的key会替换前面的key
  void _mapType() {
    print('---------__mapType------------');
    // map初始化
    Map names = {
      'xiaoming': '小明',
      'xiaohong': '小红',
    };

    print(names);

    Map ages = {};

    ages['xiaoming'] = 16;
    ages['xiaohong'] = 18;

    print(ages);

    // Map遍历方式
    ages.forEach((key, value) {
      print('$key, $value');
    });

    Map ages2 = ages.map((key, value) {
      return MapEntry(value, key);
    });

    print(ages2);

    for (var i in ages.keys) {
      print('$i ${ages[i]} for-in');
    }
  }
}
