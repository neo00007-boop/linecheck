import 'package:flutter/material.dart';
import 'package:linecheck/common/base_provider_model.dart';
import 'package:linecheck/common/routes_life_aware_state.dart';
import 'package:provider/provider.dart';

//需要状态管理 则继承
abstract class ProviderWidgetState<T extends StatefulWidget, VM extends BaseViewModel> extends LifecycleAwareWidget<T> with AutomaticKeepAliveClientMixin {
  late VM _viewModel;

  VM get viewModel {
    return _viewModel;
  }

  Widget? _child; //页面刷新局部不需要刷新区域

  IconButton backButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }

  @override
  void onPageCreate() {
    super.onPageCreate();
    _viewModel = createViewModel();
    _child = createChildWidget();
  }

  @override
  Widget build(BuildContext context) {
    if (isAutomaticKeepAliveClientEnabled()) {
      super.build(context);
    }
    return ChangeNotifierProvider<VM>.value(
      value: _viewModel,
      child: Consumer<VM>(
        child: _child,
        builder: (context, model, child) {
          return buildWidget(context, model, child);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => isAutomaticKeepAliveClientEnabled();

  //切换tab后保留tab的状态，避免initState方法重复调用
  bool isAutomaticKeepAliveClientEnabled() {
    return false;
  }

  //需要重写返回mode
  VM createViewModel();

  //需要重写返回页面的布局
  Widget buildWidget(BuildContext context, VM model, Widget? child);

  //构造不可变得widget部分   可选择重写
  Widget? createChildWidget() {
    return null;
  }
}
