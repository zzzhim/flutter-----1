// 面向对象的编程技巧
// 一：封装、继承、多态
// 善于封装、大到功能模块的封装、类的封装与抽象、小到方法的封装，封装的目的在于复用和易于扩展和维护
// 不要在一个方法体里面堆砌太多的代码 < 100
// 二：点点点的技巧
// 在一个类的世界里：万物皆对象；1点查看对象有哪些方法和属性；2点看源码；3点探究竟；

void main() {
  List? list;
  // Dart编程小技巧1：安全的调用
  // 对于不确定是否为空的对象可以通过?.的方式来访问它的属性和方法以防止空异常如： a?.foo()
  print(list?.length);

  // Dart编程小技巧2：设置默认值
  print(list?.length ?? -1);

  // Dart编程小技巧3：
  list = [];
  list.add(0);
  list.add('');
  list.add(null);

  if (list[0] == null || list[0] == '' || list[0] == 0) {
    print('list[0] is empty');
  }

  if ([null, '', 0].contains(list[0])) {
    print('list[0] is empty');
  }
}
