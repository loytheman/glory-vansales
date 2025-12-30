import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/helpers/store.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.salesOrder.dart';
import 'package:glory_vansales_app/services/_webapi.dart';
import 'package:glory_vansales_app/services/business_central_service.dart';
import 'package:stacked/stacked.dart';

class SalesOrderViewModel extends ReactiveViewModel {
  // final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  List<SalesOrder> SalesOrderList = [];
  bool loadMoreFlag = false;
  FilterQuery fq = FilterQuery();
  int pageSkip = 0;

  Future<void> getData() async {
    if (loadMoreFlag) {
      await loadMore();
    } else {
      await refreshData();
    }
  }

  Future<void> refreshData() async {
    // await StoreHelper.clearCredential();
    setBusy(true);
    SalesOrderList = [];
    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      fq.reset();
      // fq.filterField(field: 'customerNumber', value: '10000');
      // fq.filterDate(field:'orderDate', startDate:'2025-11-01', endDate: '2025-11-21');
      SalesOrderList = await _bcService.getAllPostedSalesOrder(filter: fq);
    } catch (e) {
      Utils.err("SalesOrderViewModel refreshData error $e");
    }
    setBusy(false);
  }

  Future<void> loadMore() async {
    setBusy(true);
    try {
      fq.loadNextPage();
      var l = await _bcService.getAllPostedSalesOrder(filter: fq);
      SalesOrderList.addAll(l);
    } catch (e) {
      Utils.err("SalesOrderViewModel load more error $e");
    }
    setBusy(false);
  }

  Future<void> handleRefreshOrFetch(IndicatorTrigger trigger) async {
    if (trigger == IndicatorTrigger.leadingEdge) {
      // Action for leading edge (e.g., pull down to refresh new data)
      print("Leading edge action triggered (refresh)");
      await Future.delayed(const Duration(seconds: 2));
      // Update your state/data
    } else if (trigger == IndicatorTrigger.trailingEdge) {
      // Action for trailing edge (e.g., pull up to load more data)
      print("Trailing edge action triggered (load more)");
      await Future.delayed(const Duration(seconds: 2));
      // Update your state/data
    }
  }
}
