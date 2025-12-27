import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:m360_app_corpsec/common/theme.dart';
import 'package:m360_app_corpsec/common/ui.dart';
import 'package:m360_app_corpsec/ui/views/_layout.dart';
import 'package:m360_app_corpsec/ui/views/sales_invoice/sales_invoice_card.dart';
import 'package:stacked/stacked.dart';

import 'sales_invoice_viewmodel.dart';

class SalesInvoiceView extends StackedView<SalesInvoiceViewModel> {
  const SalesInvoiceView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SalesInvoiceViewModel viewModel) async {
    await viewModel.refreshData();
  }

  @override
  Widget builder( BuildContext context, SalesInvoiceViewModel viewModel, Widget? child) {
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
          viewModel.isBusy ? MyUi.loadingList() : wSalesInvoiceList(list: viewModel.salesInvoiceList),
        ],
      ),
    );

    final l = Layout01Scaffold(
        body: CustomMaterialIndicator(
            triggerMode: IndicatorTriggerMode.anywhere, onRefresh: viewModel.refreshData, child: w));

    return l;
  }

  @override
  SalesInvoiceViewModel viewModelBuilder(BuildContext context,) => SalesInvoiceViewModel();
}
