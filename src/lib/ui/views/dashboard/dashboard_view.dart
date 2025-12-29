import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:glory_vansales_app/ui/views/company/company_info_table.dart';
import 'package:glory_vansales_app/ui/views/customer/customer_card.dart';
import 'package:glory_vansales_app/ui/views/dashboard/dashboard_shareholder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dashboard_viewmodel.dart';
import 'package:glory_vansales_app/helpers/store.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(DashboardViewModel viewModel) async {
    await viewModel.refreshData();
    // await Future.delayed(Duration(seconds: 3));
    // //await viewModel.refreshData();
    // var b = await StoreHelper.read('use_biometric_flag');
    // if (b == null) {
    //   viewModel.showBiometricLoginDialog();
    // }
  }

  @override
  Widget builder(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    // final navigationService = locator<NavigationService>();
    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    final w = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: InkWell(
                child: Text("Refresh customer information",
                    textAlign: TextAlign.right, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
                onTap: () {
                  viewModel.refreshData();
                  //navigationService.navigateTo(Routes.companyView, parameters: {"tabIndex": "0"});
                },
              )),
          MyUi.hs_lg(),
          viewModel.isBusy ? MyUi.loadingList() : wCustomerList(list: viewModel.customerList),
        ],
      ),
    );

    final l = Layout01Scaffold(
        body: CustomMaterialIndicator(
            triggerMode: IndicatorTriggerMode.anywhere, onRefresh: viewModel.refreshData, child: w));

    return l;
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();
}
