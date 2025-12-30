import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/app/app.dialogs.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/theme.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/models/model.salesInvoice.dart';
import 'package:glory_vansales_app/ui/components/pagination_load_more.dart';
import 'package:glory_vansales_app/ui/views/_layout.dart';
import 'package:glory_vansales_app/ui/views/sales_invoice/sales_invoice_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../helpers/utils.dart';
import 'sales_invoice_viewmodel.dart';

class SalesInvoiceView extends StackedView<SalesInvoiceViewModel> {
  static final _navigationService = locator<NavigationService>();
  static final _dialogService = locator<DialogService>();

  const SalesInvoiceView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SalesInvoiceViewModel viewModel) async {
    await viewModel.refreshData();
  }

  void gotoDetail(dynamic s) {
    _navigationService.navigateToSalesInvoiceDetailView(salesInvoice: s);
  }

  

  @override
  Widget builder(BuildContext context, SalesInvoiceViewModel viewModel, Widget? child) {
    final myStyle = Theme.of(context).extension<MyCustomStyle>();



    final l = Layout01Scaffold(
        body: Column(
      children: [
        InkWell(
                  child: Text("  Log out  ", style: context.bodyLarge?.copyWith(color: myStyle?.logoutColor)),
                  onTap: () => {
                        _dialogService.showCustomDialog(
                            barrierDismissible: true,
                            variant: DialogType.calenderDatePicker,
                            // title: "date",
                            // description: 'Do you really want to log out?',
                            // data: {
                            //   "yesFunc": null,
                            //   "noFunc": null,
                            // }
                            )
                      }),
        wPaginationLoadMore(
            createContentFunc: wSalesInvoiceList.createContentFunc,
            list: viewModel.salesInvoiceList,
            onTapFunc: gotoDetail,
            onRefreshFunc: viewModel.refreshData,
            onLoadMoreFunc: viewModel.loadMore),
      ],
    ));

    // final l = Layout01Scaffold(
    //     body: CustomRefreshIndicator(
    //         trigger: IndicatorTrigger.bothEdges,
    //         onRefresh: viewModel.refreshData,
    //         child: w,
    //         builder: (context, child, controller)  {
    //           return child;
    //         },
    //       )
    //     );

    return l;
  }

  @override
  SalesInvoiceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SalesInvoiceViewModel();
}
