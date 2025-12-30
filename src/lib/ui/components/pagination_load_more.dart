// ignore_for_file: camel_case_types

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glory_vansales_app/common/ui.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.salesInvoice.dart';
import 'package:glory_vansales_app/ui/views/sales_invoice/sales_invoice_card.dart';
import 'package:smart_text_widget/smart_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


class wPaginationLoadMoreModel extends ReactiveViewModel {
  List<dynamic> list;
  Future<void> Function() onRefreshFunc;
  Future<void> Function() onLoadMoreFunc;
  bool loadMoreFlag = false;
  int counter = 0;

  wPaginationLoadMoreModel(this.list, this.onRefreshFunc, this.onLoadMoreFunc);

  Future<void> getData() async {
    counter++;
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (loadMoreFlag) {
      await onLoadMoreFunc();
    } else {
      await onRefreshFunc();
    }
    // notifyListeners();
    setBusy(false);
  }
}


class wPaginationLoadMore extends StackedView<wPaginationLoadMoreModel> {
  final Future<void> Function() onRefreshFunc;
  final Future<void> Function() onLoadMoreFunc;
  final Widget Function(List<dynamic> list, Function(dynamic s)? onTapFunc) createContentFunc;
  final List<dynamic> list;
  final void Function(dynamic s)? onTapFunc;

  const wPaginationLoadMore({super.key, required this.createContentFunc, required this.list, required this.onTapFunc, 
    required this.onRefreshFunc, required this.onLoadMoreFunc});


  @override
  Widget builder( BuildContext context, wPaginationLoadMoreModel viewModel, Widget? child) {

            var c = createContentFunc(list, onTapFunc);
            // var c = SingleChildScrollView(
            //   physics: const AlwaysScrollableScrollPhysics(),
            //   child: Column(
            //     children: [
            //       TextButton(
            //         // onPressed: () => { viewModel.loadMoreFlag = true},
            //         onPressed: () => { },
            //         child: const Text("NO"),
            //       ),
            //       // Text("loadMoreFlag: ${viewModel.loadMoreFlag} ${viewModel.counter}"), 
            //       viewModel.isBusy && !viewModel.loadMoreFlag
            //         ? MyUi.loadingList() : wSalesInvoiceList(list: viewModel.list as List<SalesInvoice>, onTapFunc: gotoDetail),
            //       // wSalesInvoiceList(list: viewModel.list as List<SalesInvoice>)
            //       if (viewModel.loadMoreFlag) ...[MyUi.loadingList()]
            //       ],
            //   ),
            // );

            Widget w = CustomMaterialIndicator(
              // triggerMode: IndicatorTriggerMode.anywhere,
              leadingScrollIndicatorVisible: false,
              trailingScrollIndicatorVisible: false,
              trigger: IndicatorTrigger.bothEdges,
              onRefresh: viewModel.getData,
              indicatorBuilder: (context, controller) {
                var indicator = Icon(Icons.refresh);
                viewModel.loadMoreFlag = false;
                if (controller.edge == IndicatorEdge.trailing) {
                  indicator = Icon(Icons.arrow_upward);
                  viewModel.loadMoreFlag = true;
                }
                return indicator;
              },
              child: c,
            );

            return w;

  }

  @override
  wPaginationLoadMoreModel viewModelBuilder(BuildContext context,) => wPaginationLoadMoreModel(list, onRefreshFunc, onLoadMoreFunc);
}


