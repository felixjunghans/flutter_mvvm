import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/base_view_model.dart';
import 'package:provider/provider.dart';

abstract class ViewModelProviderState<T extends StatefulWidget,
    T2 extends BaseViewModel> extends State<T> {
  @protected
  Widget content(BuildContext context);

  @protected
  T2 bindViewModel(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Provider<T2>(
      create: bindViewModel,
      child: content(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
