import 'package:flutter/material.dart';

// 如何获取Flutter应用维度生命周期
// WudgetsBindingObserver：是一个Widgets绑定观察期，通过它我们可以监听应用的生命周期、语言等变化
class AppLifecycle extends StatefulWidget {
  const AppLifecycle({Key? key}) : super(key: key);

  @override
  _AppLifecycle createState() => _AppLifecycle();
}

class _AppLifecycle extends State<AppLifecycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter应用生命周期'),
        leading: BackButton(),
      ),
      body: Container(
        child: Text('Flutter 生命周期'),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    print('state = $state');

    if (state == AppLifecycleState.paused) {
      print('App进入后台');
    } else if (state == AppLifecycleState.resumed) {
      print('App进入前台');
    } else if (state == AppLifecycleState.inactive) {
      // 不常用：应用程序处于非活动状态，并且未接收用户输入时调用，比如：接电话
    }
    // else if(state == AppLifecycleState?.suspending) {
    // 不常用：应用挂起
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }
}
