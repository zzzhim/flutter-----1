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
}
