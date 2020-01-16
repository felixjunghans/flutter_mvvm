import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/view_model_provider.dart';
import 'package:flutter_mvvm/template/view/widgets/template_screen.dart';
import 'package:flutter_mvvm/template/view_model/template_view_model.dart';

/// Template
///
/// TODO insert Screen description here
///
/// Extends [ViewModelProvider]
/// to automatically bind the [TemplateViewModel]
/// to all Widgets inside [Template]
class Template extends StatefulWidget {
  /// route name of the Screen
  static const String routeName = "/template";

  /// initialize Screen to use with MaterialApp routes
  static WidgetBuilder routeInitializer = (_) => Template();

  @override
  State<StatefulWidget> createState() {
    return _TemplateState();
  }
}

class _TemplateState
    extends ViewModelProviderState<Template, TemplateViewModel> {
  /// Initializes the ViewModel for this screen.
  final TemplateViewModel templateViewModel = TemplateViewModel();

  @override
  Widget content(BuildContext context) => TemplateScreen();

  @override
  TemplateViewModel bindViewModel(BuildContext context) => templateViewModel;

  @override
  void dispose() {
    super.dispose();

    templateViewModel.dispose();
  }
}
