import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/helpers/shareFunc.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:stacked/stacked.dart';

import 'dev_debug_viewmodel.dart';

class DevDebugView extends StackedView<DevDebugViewModel> {
  const DevDebugView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(DevDebugViewModel viewModel) async {
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, DevDebugViewModel viewModel, Widget? child) {
    ///Utils.log("knnknnknnknn");

    final l = Layout01Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Developer Setting", style: context.bodyLarge).bold(),
        MyUi.hs_md(),
        Text("FCM Token").bold(),
        InkWell(
            child: Text(viewModel.fcmToken ?? "-"),
            onTap: () {
              Clipboard.setData(ClipboardData(text: viewModel.fcmToken ?? "-"));
              ShareFunc.showToast("copied to clipboard");
            }),
        MyUi.hs_md(),
        Text("Access Token").bold(),
        InkWell(
          child: Text(viewModel.accessToken ?? "-"),
        ),
        MyUi.hs_md(),
        Text("Expired At").bold(),
        InkWell(
          child: Text(viewModel.exp ?? "-"),
        ),
        MyUi.hs_md(),
        Row(
          children: [
            Text("Refresh Token").bold(),
            IconButton(
                onPressed: viewModel.deleteRefreshToken,
                color: Colors.red,
                iconSize: 18,
                icon: const Icon(Icons.delete)),
          ],
        ),
        InkWell(
            child: Text(viewModel.refreshToken ?? "-"),
            onTap: () {
              Clipboard.setData(ClipboardData(text: viewModel.refreshToken ?? "-"));
              ShareFunc.showToast("copied to clipboard");
            }),
      ],
    ));

    return l;
  }

  @override
  DevDebugViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DevDebugViewModel();
}
