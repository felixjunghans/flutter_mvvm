import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/base_view_model.dart';
import 'package:provider/provider.dart';

/// ViewModelConsumerState<T>
///
/// Consumes the Provider<T> of the current Context
abstract class ViewModelConsumerState<T extends StatefulWidget,
    T2 extends BaseViewModel> extends State<T> {
  T2 get viewModel => Provider.of<T2>(context);

  @override
  void initState() {
    super.initState();

    postInit(() {
      T2 viewModel = Provider.of<T2>(context);
      init(viewModel);
    });
  }

  @protected
  void init(T2 viewModel);

  @protected
  Widget builder(BuildContext context, T2 viewModel, Widget child);

  Widget build(BuildContext context) {
    return Consumer<T2>(
      builder: builder,
    );
  }
}

extension StateExtension<T extends StatefulWidget> on State<T> {
  Stream<bool> waitForStateLoading() async* {
    while (!mounted) {
      yield false;
    }
    yield true;
  }

  Future<void> postInit(VoidCallback action) async {
    await for (bool isLoaded in waitForStateLoading()) {}
    action();
  }
}
