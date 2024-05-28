import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child; // 加载完成后显示的内容
  final bool isLoading; // 是否正在加载中
  final bool cover; // Stack方式进度条浮动在当前界面上 还是替换当前界面

  const LoadingContainer(
      {super.key,
      required this.child,
      required this.isLoading,
      this.cover = false});

  get _loadingView => const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      );

  get coverView => Stack(
        // 堆叠效果
        children: [child, isLoading ? _loadingView : Container()],
      );

  get normalView => isLoading ? _loadingView : child;

  @override
  Widget build(BuildContext context) {
    return cover ? coverView : normalView;
  }
}
