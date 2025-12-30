import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.salesOrder.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:glory_vansales_app/ui/views/sales_order/sales_order_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../sales_order/sales_order_detail_viewmodel.dart';

class SalesOrderDetailView extends StackedView<SalesOrderDetailViewModel> {
  // static final _navigationService = locator<NavigationService>();
  final SalesOrder salesOrder;
  const SalesOrderDetailView({Key? key, required this.salesOrder}) : super(key: key);

  @override
  void onViewModelReady(SalesOrderDetailViewModel viewModel) async {
    await viewModel.refreshData();
  }

  @override
  Widget builder(BuildContext context, SalesOrderDetailViewModel viewModel, Widget? child) {
    List<Widget> rows = [];
    List<SalesOrderLine>? list = viewModel.salesOrder?.salesOrderLine_arr;
    list = list ?? [];

    for (var r in list) {
      final w = Text(r.description);
      rows.add(w);
    }
    final w = Column(children: [MyUi.hs_lg(), Text('Sales Order ${salesOrder.number}'), ...rows]);

    final l = Layout01Scaffold(
        leading: "back-btn",
        title: salesOrder.customerName,
        body: viewModel.isBusy ? MyUi.loadingList() : w,
        padding: EdgeInsets.all(0));

    return l;
  }

  @override
  SalesOrderDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SalesOrderDetailViewModel(salesOrder);
}
