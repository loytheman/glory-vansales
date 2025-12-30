import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.dialogs.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.salesOrder.dart';
import 'package:glory_vansales_app/ui/components/pagination_load_more.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:glory_vansales_app/ui/views/sales_order/sales_order_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../helpers/utils.dart';
import '../sales_order/sales_order_viewmodel.dart';

class SalesOrderView extends StackedView<SalesOrderViewModel> {
  static final _navigationService = locator<NavigationService>();
  static final _dialogService = locator<DialogService>();

  const SalesOrderView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SalesOrderViewModel viewModel) async {
    await viewModel.refreshData();
  }

  void gotoDetail(dynamic s) {
    _navigationService.navigateToSalesOrderDetailView(salesOrder: s);
  }

  @override
  Widget builder(BuildContext context, SalesOrderViewModel viewModel, Widget? child) {
    final myStyle = Theme.of(context).extension<MyCustomStyle>();

    final DateTime today = DateTime.now();

    final l = Layout01Scaffold(
        body: Column(
        children: [
          // InkWell(
          //     child: Text("  select dates  ", style: context.bodyLarge?.copyWith(color: myStyle?.logoutColor)),
          //     onTap: () => {
          //           _dialogService.showCustomDialog(
          //             barrierDismissible: true, 
          //             variant: DialogType.calenderDatePicker, 
          //             data: {"selectedDates": [today],}),
          //         }
          // ),
          wPaginationLoadMore(
              createContentFunc: wSalesOrderList.createContentFunc,
              skeletonRow: MyUi.loadingCard(),
              list: viewModel.SalesOrderList,
              onTapFunc: gotoDetail,
              onRefreshFunc: viewModel.refreshData,
              onLoadMoreFunc: viewModel.loadMore
          ),
        ],
    ));


    return l;
  }

  @override
  SalesOrderViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SalesOrderViewModel();
}
