import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.salesInvoice.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:glory_vansales_app/ui/views/sales_invoice/sales_invoice_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'sales_invoice_viewmodel.dart';

class SalesInvoiceView extends StackedView<SalesInvoiceViewModel> {
  static final _navigationService = locator<NavigationService>();
  
  
  const SalesInvoiceView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SalesInvoiceViewModel viewModel) async {
    await viewModel.refreshData();
  }

  void gotoDetail(SalesInvoice s) {
    _navigationService.navigateToSalesInvoiceDetailView(salesInvoice: s);
  }

  @override
  Widget builder(BuildContext context, SalesInvoiceViewModel viewModel, Widget? child) {
    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    final w = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          // SizedBox(
          //     width: double.infinity,
          //     child: InkWell(
          //       child: Text("Refresh salse invoice information",
          //           textAlign: TextAlign.right, style: context.bodyMedium?.copyWith(color: myStyle?.linkColor)),
          //       onTap: () {
          //         viewModel.refreshData();
          //         //navigationService.navigateTo(Routes.companyView, parameters: {"tabIndex": "0"});
          //       },
          //     )),
          // MyUi.hs_lg(),
          viewModel.isBusy ? MyUi.loadingList() : wSalesInvoiceList(list: viewModel.salesInvoiceList, onTapFunc: gotoDetail),
        ],
      ),
    );

    final l = Layout01Scaffold(
        body: CustomMaterialIndicator(
            triggerMode: IndicatorTriggerMode.anywhere, onRefresh: viewModel.refreshData, child: w));

    return l;
  }

  @override
  SalesInvoiceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SalesInvoiceViewModel();
}
