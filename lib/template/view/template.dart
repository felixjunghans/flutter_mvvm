import 'package:flutter/material.dart';
import 'package:flutter_mvvm/mvvm/base_view_model.dart';
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
class Template extends ViewModelProvider<BaseViewModel> {
  final TemplateViewModel templateViewModel = TemplateViewModel();

  @override
  Widget content(BuildContext context) {
    return TemplateScreen();
  }

  @override
  TemplateViewModel bindViewModel(BuildContext context) {
    return templateViewModel;
  }

  @override
  void dispose() {
    templateViewModel.dispose();
  }
}
