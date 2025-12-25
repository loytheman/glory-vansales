import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/ui/common/app_colors.dart';
import 'package:m360_app_corpsec/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'biometric_login_dialog_model.dart';

const double _graphicSize = 60;

class BiometricLoginDialog extends StackedView<BiometricLoginDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BiometricLoginDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BiometricLoginDialogModel viewModel,
    Widget? child,
  ) {
    void useBiometricFn(bool value) async {
      await viewModel.useBiometric(value);
      if (!viewModel.isBusy) completer(DialogResponse(confirmed: true));
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title, description, and graphic
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'Enable Biometric Login?',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: kcMediumGrey,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 200, 230, 201),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    CupertinoIcons.checkmark_shield_fill,
                    size: 30,
                    color: Colors.black45,
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            // Row with "No" and "Yes" buttons
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () => {
                      {useBiometricFn(false)}
                    },
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black45, // Background color for "No"
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: CupertinoButton(
                    onPressed: () => {useBiometricFn(true)},
                    padding: EdgeInsets.zero,
                    color: Colors.amber, // Background color for "Yes"
                    borderRadius: BorderRadius.circular(10),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  BiometricLoginDialogModel viewModelBuilder(BuildContext context) => BiometricLoginDialogModel();
}
