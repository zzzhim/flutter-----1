import 'package:flutter/material.dart';

// 加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({
    Key? key,
    required this.child,
    required this.isLoading,
    this.cover = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!cover && !isLoading) {
      return Stack(
        children: <Widget>[
          child,
          isLoading
              ? _loadingView
              : Container(
                  width: 0,
                  height: 0,
                ),
        ],
      );
    } else {
      return _loadingView;
    }
  }

  Widget get _loadingView {
    return const Center(child: CircularProgressIndicator());
  }
}
