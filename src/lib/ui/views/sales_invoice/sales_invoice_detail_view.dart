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

import 'sales_invoice_detail_viewmodel.dart';

class SalesInvoiceDetailView extends StackedView<SalesInvoiceDetailViewModel> {
  // static final _navigationService = locator<NavigationService>();
  final SalesInvoice salesInvoice;
  const SalesInvoiceDetailView({Key? key, required this.salesInvoice}) : super(key: key);

  @override
  void onViewModelReady(SalesInvoiceDetailViewModel viewModel) async {
    await viewModel.refreshData();
  }

  @override
  Widget builder( BuildContext context, SalesInvoiceDetailViewModel viewModel, Widget? child ) {

    List<Widget> rows = [];
    List<SalesInvoiceLine>? list = viewModel.salesInvoice?.salesInvoiceLine_arr;
    list = list ?? [];
    
    
    for (var r in list) {
      final w = Text(r.description);
      rows.add(w);

    }
    final w = Column(children: [
      MyUi.hs_lg(),
      Text('Invoice ${salesInvoice.number}'),
      ...rows
      ]);
    
    final l = Layout01Scaffold(
        leading: "back-btn", title: salesInvoice.customerName, 
        body: viewModel.isBusy ? MyUi.loadingList() : w,
        padding: EdgeInsets.all(0));

    return l;
  }

  @override
  SalesInvoiceDetailViewModel viewModelBuilder(BuildContext context,) =>
      SalesInvoiceDetailViewModel(salesInvoice);
}
