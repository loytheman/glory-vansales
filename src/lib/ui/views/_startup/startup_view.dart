import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.account.dart';
import 'package:stacked/stacked.dart';
import 'package:themed/themed.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  final TokenSet? tokenSet;
  const StartupView({Key? key, this.tokenSet}) : super(key: key);

  // @override
  // Widget builder(
  //   BuildContext context,
  //   StartupViewModel viewModel,
  //   Widget? child,
  // ) {
  //   final w = Scaffold(
  //     body: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: const AssetImage("assets/img/building.png"),
  //           fit: BoxFit.cover,
  //           colorFilter: ColorFilter.mode(
  //               Colors.black.withValues(alpha: 0.6), BlendMode.multiply),
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           DecoratedBox(
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withAlpha(200),
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Container(
  //                 padding: const EdgeInsets.all(20),
  //                 child: Column(children: [
  //                   Image.asset("assets/img/m360.png", width: 180),
  //                 ]),
  //               )),
  //           MyUi.hs_md(),
  //           if (viewModel.useBiometricFlag)
  //             ElevatedButton(
  //               onPressed: viewModel.authAction,
  //               child: const Text('Biometric Authentication'),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );

  //   return w;
  // }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (tokenSet != null) {
        viewModel.runStartupLogicWithTokenSet(tokenSet!);
      } else {
        viewModel.runStartupLogic();
      }
    });
  }

  @override
  Widget builder(BuildContext context, StartupViewModel viewModel, Widget? child) {
    void onClickLogin() async {
      // viewModel.setBusy(true);
      viewModel.authAction();
    }

    final s = Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/img/building.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.5), BlendMode.multiply),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: SizedBox(
                      width: 100,
                      child: ChangeColors(
                        brightness: 3,
                        child: Image.asset("assets/img/glory.png"),
                      )),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: Text("Hello again, welcome back", style: context.displaySmall!.copyWith(color: Colors.white)),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  width: 320,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(
                        width: viewModel.isBusy ? 260 : 250,
                        child: ElevatedButton.icon(
                            icon: viewModel.isBusy ? MyUi.loadingCirlce() : null,
                            onPressed: viewModel.isBusy ? null : onClickLogin,
                            label: viewModel.isBusy
                                ? const Text("Logging into MEYZER360")
                                : const Text("Biometric Authentication")),
                        // label: const Text("Sign In with MEYZER360")),
                      ),

                      //viewModel.onOidcLogout

                      // MyUi.hs_lg(),

                      // Row(children: [
                      //   const Expanded(child: Divider()),
                      //   Text("     or     "),
                      //   const Expanded(child: Divider()),
                      // ]),

                      MyUi.hs_md(),

                      Text("    Login with password instead", style: context.bodyMedium?.copyWith(color: Colors.white)),
                    ]),
                  ),
                ),

                //verticalSpaceLarge
              ],
            ),
          )),
    );

    return s;
  }
}
