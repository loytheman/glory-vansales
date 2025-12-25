import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:stacked/stacked.dart';

import 'biometric_preference_viewmodel.dart';

class BiometricPreferenceView extends StackedView<BiometricPreferenceViewModel> {
  const BiometricPreferenceView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BiometricPreferenceViewModel viewModel,
    Widget? child,
  ) {
    final headerStyle = context.titleLarge;
    final bodyStyle = context.bodyMedium?.copyWith(color: Colors.grey);
    Color priColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 240),
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 220, 216),
                    borderRadius: BorderRadius.all(
                      Radius.circular(120 / 2),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.fingerprint,
                      size: 60,
                      // color: Colors.blue.shade900,
                      color: priColor,
                    ),
                    onPressed: () {
                      // Handle fingerprint tap
                    },
                  ),
                ),
                SizedBox(height: 14),
                Text('Enable Biometric Login', style: headerStyle),
                const SizedBox(height: 8),
                Text(
                  'Do you want to enable biometric authentication for more secure login?',
                  textAlign: TextAlign.center,
                  style: bodyStyle,
                ),
              ],
            ),
            // Buttons at the bottom
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: 
                    FilledButton.icon(
                      icon: viewModel.isBusy ? MyUi.loadingCirlce() : null,
                      onPressed: viewModel.isBusy ? null : ()=>viewModel.useBiometric(true),
                      label: const Text("Enable Now")),
                  // label: const Text("Sign In with MEYZER360")),
                ),
                MyUi.hs_md(),
                SizedBox(
                  width: double.infinity,
                  child: 
                    OutlinedButton.icon(
                      icon: viewModel.isBusy ? MyUi.loadingCirlce() : null,
                      onPressed: viewModel.isBusy ? null : ()=>viewModel.useBiometric(false),
                      label: const Text("Maybe Later")),
                ),
                MyUi.hs_lg(),
              ],
            ),
          ],
        )),
      )),
    );
  }

  @override
  BiometricPreferenceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BiometricPreferenceViewModel();
}
