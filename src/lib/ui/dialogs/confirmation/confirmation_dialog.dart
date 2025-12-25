import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'confirmation_dialog_model.dart';

class ConfirmationDialog extends StackedView<ConfirmationDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmationDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, ConfirmationDialogModel viewModel, Widget? child) {
    String title = request.title ?? "Confirmation";
    String desc = request.description ?? "Do you really want to continue?";

    void onClickYes() async {
      request.data["yesFunc"]?.call();
    }

    void onClickNo() async {
      request.data["noFunc"]?.call() ?? Navigator.pop(context);
    }

    final d = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        constraints: const BoxConstraints(minHeight: 200, minWidth: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.titleLarge),
            Text(desc, style: context.bodyLarge),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                width: 80,
                child: TextButton(
                  onPressed: onClickNo,
                  child: const Text("NO"),
                ),
              ),
              MyUi.vs_sm(),
              SizedBox(
                width: 80,
                child: FilledButton(
                  onPressed: onClickYes,
                  child: const Text("YES"),
                ),
              ),
            ])
          ],
        ),
      ),
    );

    return d;
  }

  @override
  ConfirmationDialogModel viewModelBuilder(BuildContext context) => ConfirmationDialogModel();
}
