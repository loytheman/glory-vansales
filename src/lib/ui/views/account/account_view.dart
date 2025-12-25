import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/common/theme.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'account_viewmodel.dart';

class AccountView extends StackedView<AccountViewModel> {
  const AccountView({Key? key}) : super(key: key);

  static final _authenticationService = locator<AuthenticationService>();
  static final _dialogService = locator<DialogService>();

  @override
  void onViewModelReady(AccountViewModel viewModel) async {
    await viewModel.init();
  }

  @override
  Widget builder(BuildContext context, AccountViewModel viewModel, Widget? child) {
    final u = viewModel.user;
    final kycVerified = u?.kycVerified ?? false;

    final websiteUrl = "https://central.meyzer.xyz?redirect=profile";

    final headerStyle = context.bodySmall?.copyWith(color: Colors.grey);
    final bodyStyle = context.bodyLarge;
    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    Widget avatar;
    if (u?.displayPicture != null) {
      avatar = CircleAvatar(radius: 54, backgroundImage: NetworkImage(u!.displayPicture));
    } else {
      final str = "${u?.firstName[0]}${u?.lastName[0]}";
      avatar = CircleAvatar(radius: 54, backgroundColor: Colors.blue.shade100, child: Text(str).fontSize(48));
    }

    final l = Layout01Scaffold(
        leading: "back-btn",
        title: Text("Account", overflow: TextOverflow.ellipsis, maxLines: 1, style: context.titleLarge),
        trailing: Container(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyUi.hs_md(),
            Container(
              alignment: Alignment.center,
              child: avatar,
            ),
            MyUi.hs_md(),
            Text("Name", style: headerStyle),
            MyUi.hs_2xs(),
            Text("${u?.firstName ?? ''} ${u?.lastName ?? ''} ", style: bodyStyle),
            MyUi.hr(),
            Text("Email", style: headerStyle),
            MyUi.hs_2xs(),
            Text(u?.email ?? "", style: bodyStyle),
            MyUi.hr(),
            Text("Mobile", style: headerStyle),
            MyUi.hs_2xs(),
            Text(u?.mobileFull ?? "", style: bodyStyle),
            MyUi.hr(),
            Text("Account Password", style: headerStyle),
            MyUi.hs_2xs(),
            Text("********", style: bodyStyle),
            MyUi.hr(),
            Text("eKYC Status", style: headerStyle),
            MyUi.hs_2xs(),
            Text(kycVerified ? "Verified" : "Not Verified", style: bodyStyle),
            MyUi.hr(),
            Text("Biometric Authentication", style: headerStyle),
            MyUi.hs_2xs(),
            Switch(
              value: viewModel.useBiometricFlag,
              onChanged: (bool value) async {
                viewModel.useBiometric();
              },
            ),
            MyUi.hr(),
            MyUi.hs_md(),
            Spacer(),
            Center(
              child: InkWell(
                  child: Text("  Log out  ", style: context.bodyLarge?.copyWith(color: myStyle?.logoutColor)),
                  onTap: () => {
                        _dialogService.showCustomDialog(
                            barrierDismissible: true,
                            variant: DialogType.confirmation,
                            title: "LOGOUT",
                            description: 'Do you really want to log out?',
                            data: {
                              "yesFunc": onClickLogout,
                              "noFunc": null,
                            })
                      }),
            ),
            Container(
              height: 148,
            ),
          ],
        ));

    return l;
  }

  void onClickLogout() {
    _authenticationService.logout();
  }

  @override
  AccountViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AccountViewModel();
}
