import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ViewModelConsumerState<T>
///
/// Consumes the Provider<T> of the current Context
abstract class ViewModelConsumerState<T extends StatefulWidget>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @protected
  Widget init();

  @protected
  Widget builder(BuildContext context, T viewModel, Widget child);

  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: builder,
    );
  }
}
