class TestFunction {
  FunctionLearn functionLearn = FunctionLearn();

  void start() {
    print(functionLearn.sum(1, 2));

    functionLearn.anonymousFunction();
  }
}

class FunctionLearn {
  // 方法的构成
  // 返回值类型 + 方法名 + 参数
  // 其中：返回值类型可缺省，也可为void或具体的类型
  // 方法名：匿名方法不需要方法名
  // 参数：参数类型和参数名，参数类型可缺省（另外，参数有分可选参数和参数默认值，可参考面向对象一节中构造方法部分

  int sum(int val1, int val2) {
    return val1 + val2;
  }

  // 私有方法：
  // 通过 _ 开头命名的方法
  // 作用域是当前文件
  _learn() {
    print('私有方法');
  }

  // 匿名方法：
  // 大部分方法都带有名字，例如 main() 或者 print();
  // 在Dart中你可以创建没有名字的方法，称之为 匿名方法。
  // 函数体如下
  // ([Type] params1[, ...]) {
  //  codeBlock;
  // }
  anonymousFunction() {
    var list = ['私有方法', '匿名方法'];
    list.forEach((i) {
      print(list.indexOf(i).toString() + ':' + i);
    });
  }
}
