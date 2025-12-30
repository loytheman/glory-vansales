import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/constants.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/helpers/life_cycle.dart';
import 'package:glory_vansales_app/helpers/validators.dart';
import 'package:glory_vansales_app/ui/views/login/login_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:themed/themed.dart';

import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'email',
    validator: Validator.validateEmail,
  ),
  FormTextField(
    name: 'password',
    validator: Validator.validatePassword,
  ),
])

// loynote: lifecycle ref:
// https://github.com/Stacked-Org/stacked/issues/413

class LoginView extends StackedView<LoginViewModel> with $LoginView, WidgetsBindingObserver {
  final bool? useBiometricFlag;
  const LoginView({Key? key, this.useBiometricFlag}) : super(key: key);
  @override
  void onViewModelReady(LoginViewModel viewModel) {
    // print(useBiometricFlag);
    syncFormWithViewModel(viewModel);
    viewModel.setValidationMessages({});

    viewModel.emailValue = "cto@lycho.me";
    viewModel.passwordValue = "";

    WidgetsBinding.instance.addObserver(this);

    LifeCycleHelper.getStream().listen((state) {
      // Utils.log(">>>>>????? $state");
      if (state == AppLifecycleState.resumed) {
        viewModel.setBusy(false);
      } else if (state == EventType.RETURN_TO_AUTH_CODE_LOGIN_FLOW) {
        viewModel.setBusy(true);
      }
    });
  }

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    void onClickLogin() async {
      viewModel.setBusy(true);
      viewModel.onOidcLogin();
    }

    final s = Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: const AssetImage("assets/img/building.png"),
              image: const AssetImage("assets/img/vans-04.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment(0.0, 0),
              colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.5), BlendMode.multiply),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 150,
                    child: ChangeColors(
                      brightness: 3,
                      child: Image.asset("assets/img/glory.png"),
                    )),

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
                        width: 250,
                        child: ElevatedButton.icon(
                            icon: viewModel.isBusy ? MyUi.loadingCirlce() : null,
                            onPressed: viewModel.isBusy || viewModel.hasFormError ? null : onClickLogin,
                            label: const Text("Sign In to Business Central")),
                      ),

                      //viewModel.onOidcLogout

                      // MyUi.hs_lg(),

                      // Row(children: [
                      //   const Expanded(child: Divider()),
                      //   Text("     or     "),
                      //   const Expanded(child: Divider()),
                      // ]),

                      MyUi.hs_md(),

                      Text("    Register for new account", style: context.bodyMedium?.copyWith(color: Colors.white)),
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

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onDispose(LoginViewModel viewModel) async {
    WidgetsBinding.instance.removeObserver(this);
    await LifeCycleHelper.closeStream();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    LifeCycleHelper.addStream(state);

    if (state == AppLifecycleState.resumed) {
      //Utils.log("CCCB");
    }
    // super.didChangeAppLifecycleState(state);
  }
}
