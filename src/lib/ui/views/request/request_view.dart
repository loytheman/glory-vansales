import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:stacked/stacked.dart';

import 'request_viewmodel.dart';

class RequestView extends StackedView<RequestViewModel> {
  const RequestView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(RequestViewModel viewModel) {}

  @override
  Widget builder(BuildContext context, RequestViewModel viewModel, Widget? child) {
    final l = Layout01Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Text("Request!"),
      ),
    );

    return l;
  }

  @override
  RequestViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RequestViewModel();
}
