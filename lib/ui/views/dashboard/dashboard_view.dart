import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/common/theme.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:m360_app_corpsec/ui/views/company/company_info_table.dart';
import 'package:m360_app_corpsec/ui/views/dashboard/dashboard_shareholder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dashboard_viewmodel.dart';
import 'package:m360_app_corpsec/helpers/store.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(DashboardViewModel viewModel) async {
    // await Future.delayed(Duration(seconds: 3));
    // //await viewModel.refreshData();
    // var b = await StoreHelper.read('use_biometric_flag');
    // if (b == null) {
    //   viewModel.showBiometricLoginDialog();
    // }
  }

  @override
  Widget builder(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    final navigationService = locator<NavigationService>();
    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    final w = SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: InkWell(
                child: Text("View company information",
                    textAlign: TextAlign.right, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                onTap: () {
                  //navigationService.navigateTo(Routes.companyView, parameters: {"tabIndex": "0"});
                  navigationService.navigateToCompanyView(tabIndex: 0);
                },
              )),
          wCompanyInfoTable(company: viewModel.company, isCompact: true),
          MyUi.hs_lg(),
          SizedBox(
              width: double.infinity,
              child: InkWell(
                child: Text("View cap table",
                    textAlign: TextAlign.right, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                onTap: () {
                  //navigationService.navigateTo(Routes.companyView, parameters: {"tabIndex": "3"});
                  navigationService.navigateToCompanyView(tabIndex: 2);
                },
              )),
          wDashboardShareholder(company: viewModel.company),
        ],
      ),
    );

    final l = Layout01Scaffold(
        body: CustomMaterialIndicator(
            triggerMode: IndicatorTriggerMode.anywhere,
            onRefresh: viewModel.refreshData,
            child: viewModel.isBusy ? MyUi.loadingList() : w));

    return l;
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();
}
