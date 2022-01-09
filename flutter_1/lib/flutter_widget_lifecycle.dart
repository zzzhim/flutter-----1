import 'package:flutter/material.dart';

// 生命周期
// 初始化
// createState initState
// 更新期间
// didChangeDependencies build didUpdateWidget
// 销毁
// deactivate dispose
class WidgetLifecycle extends StatefulWidget {
  const WidgetLifecycle({Key? key}) : super(key: key);

  // 当我们构建一个新的 StatefulWidget 时，这时会立即调用 createState()
  // 这个方法是必须覆盖的
  @override
  _WidgetLifecycle createState() => _WidgetLifecycle();
}

class _WidgetLifecycle extends State<WidgetLifecycle> {
  // 这是创建widget 时调用的除了构造方法外的第一个方法
  // 类似于Android的：onCreate() 与 iOS的 viewDidLoad()
  // 在这个方法中通常会做一些初始化工作，比如channel的初始化，监听器的初始化等
  @override
  void initState() {
    print('--------initState--------');
    // TODO: implement initState
    super.initState();
  }

  // 当依赖的State对象改变时会调用
  @override
  void didChangeDependencies() {
    print('--------didChangeDependencies--------');
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  // 这是一个必须要实现的方法，在这里实现要呈现的页面内容
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // 这是一个不常用到的生命周期方法，当父组件需要重新绘制时才会调用
  @override
  void didUpdateWidget(covariant WidgetLifecycle oldWidget) {
    print('--------didUpdateWidget--------');
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  // 很少使用，在组件被移除时调用在dispose之前调用
  @override
  void deactivate() {
    print('--------deactivate--------');
    // TODO: implement deactivate
    super.deactivate();
  }

  // 组件被销毁时调用
  // 通常在该方法中执行一些资源的释放工作比如，监听器的卸载，channel的销毁等 
  @override
  void dispose() {
    print('--------dispose--------');
    // TODO: implement dispose
    super.dispose();
  }
}
