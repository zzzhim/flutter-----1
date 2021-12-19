class Student extends Person {
  // 定义类的变量
  String? _school; // 通过下划线来标识私有字段（变量）
  String? city;
  String? country;
  String? name;
  // 构造方法
  // 通过this._school 初始化自由参数
  // name,age交给父类进行初始化
  // city 可选参数
  // country 默认参数
  Student(this._school, String? name, int? age,
      {this.city, this.country = 'China'})
      : // 初始化列表：除了调用父类构造器，在子类构造器方法体之前，你也可以初始化实例变量，不同的初始化变量之间用逗号分隔
        name = '$country.$city',
        // 如果父类没有默认构造方法（无参的构造方法），则需要在初始化列表会中调用父类的构造方法进行初始化
        super(name, age) {
    print('构造方法体不是必须的');
  }

  // 命名构造方法: [类名+.+方法名]
  // 使用命名构造方法为类实现多个构造方法
  Student.cover(Student stu) : super(stu.name, stu.age) {
    print('命名构造方法');
  }

  // 命名工厂构造方法：factory [类型+.+方法名]
  // 它可以有返回值，而且不需要将类的final变量作为参数，是提供一种灵活获取类对象的方式。
  factory Student.stu(Student stu) {
    return Student(stu._school, stu.name, stu.age);
  }
}

// 工厂构造方法：
// 不仅仅是构造方法，更是一种模式
// 有时候为了返回一个之前已经创建的缓存对象，原始的构造方法已经不能满足要求
// 那么可以使用工厂模式来定义构造方法
class Logger {
  static Logger? _cache;
  factory Logger() {
    _cache ??= Logger._internal();

    return _cache!;
  }

  Logger._internal();

  void log(String msg) {
    print(msg);
  }
}

// 定义一个Dart类，所有的类都继承自Object
class Person {
  String? name;
  int? age;
  // 标准的构造方法
  Person(this.name, this.age); // 初始化变量

  @override
  String toString() {
    return 'name: $name, age:$age';
  }
}
