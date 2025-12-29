import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
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

    // final w = SingleChildScrollView(
    //   physics: const AlwaysScrollableScrollPhysics(),
    //   child: Column(
    //     children: [
    //       viewModel.isBusy ? MyUi.loadingList() : wSalesInvoiceList(list: viewModel.salesInvoiceList, onTapFunc: gotoDetail),
    //     ],
    //   ),
    // );

    final l = Layout01Scaffold(
        body: wPaginationLoadMore(
            list: viewModel.salesInvoiceList,
            onRefreshFunc: viewModel.refreshData,
            onLoadMoreFunc: viewModel.loadMore));

    // final l = Layout01Scaffold(
    //     body: CustomMaterialIndicator(
    //         // triggerMode: IndicatorTriggerMode.anywhere,
    //         leadingScrollIndicatorVisible:false,
    //         trailingScrollIndicatorVisible: false,
    //         trigger: IndicatorTrigger.bothEdges,
    //         onRefresh: viewModel.getData,
    //         // onRefresh: () async => {  Utils.log("refresh") },
    //         indicatorBuilder:(context, controller) {
    //           var indicator = Icon(Icons.refresh);
    //           viewModel.loadMoreFlag = false;
    //           if (controller.edge == IndicatorEdge.trailing) {
    //             indicator = Icon(Icons.arrow_upward);
    //             viewModel.loadMoreFlag = true;
    //           }
    //           return indicator;
    //         },
    //         child: w,

    //         )
    //   );

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
