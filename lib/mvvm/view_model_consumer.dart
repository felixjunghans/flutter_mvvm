import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/base_view_model.dart';
import 'package:provider/provider.dart';

/// ViewModelConsumer<T>
///
/// Consumes the Provider<T> of the current Context
abstract class ViewModelConsumer<T extends BaseViewModel>
    extends StatelessWidget {
  @protected
  Widget builder(BuildContext context, T viewModel, Widget child);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: builder,
    );
  }
}
