import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/base_view_model.dart';
import 'package:provider/provider.dart';

abstract class ViewModelProvider<T extends BaseViewModel>
    extends StatelessWidget {
  @protected
  Widget content(BuildContext context);

  @protected
  T bindViewModel(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: bindViewModel,
      child: content(context),
    );
  }
}
