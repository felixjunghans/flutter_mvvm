import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/base_view_model.dart';
import 'package:provider/provider.dart';

/// ViewModelConsumerState<T>
///
/// Consumes the Provider<T> of the current Context
abstract class ViewModelConsumerState<T extends StatefulWidget,
    T2 extends BaseViewModel> extends State<T> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @protected
  void init();

  @protected
  Widget builder(BuildContext context, T2 viewModel, Widget child);

  Widget build(BuildContext context) {
    return Consumer<T2>(
      builder: builder,
    );
  }
}
