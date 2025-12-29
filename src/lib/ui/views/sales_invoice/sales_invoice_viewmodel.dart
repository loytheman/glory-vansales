import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/helpers/store.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.salesInvoice.dart';
import 'package:glory_vansales_app/services/_webapi.dart';
import 'package:glory_vansales_app/services/business_central_service.dart';
import 'package:stacked/stacked.dart';

class SalesInvoiceViewModel extends ReactiveViewModel {
  // final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  List<SalesInvoice> salesInvoiceList = [];
  bool loadMoreFlag = false;
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
    salesInvoiceList = [];

    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      var f = FilterQuery();
      f.filterField(field:'customerNumber', value:'10000');
      // f.filterDate(field:'invoiceDate', startDate:'2025-11-01', endDate: '2025-11-21');
      salesInvoiceList = await _bcService.getAllPostedSalesInvoice(filter: f);
      // Utils.log(salesInvoiceList);
    } catch (e) {
      Utils.err("SalesInvoiceViewModel refreshData error $e");
    }
    setBusy(false);
  }

  Future<void> loadMore() async {
    setBusy(true);
    try {
      var f = FilterQuery();
      f.filterField(field:'customerNumber', value:'10000');
      // f.filterDate(field:'invoiceDate', startDate:'2025-11-01', endDate: '2025-11-21');
      pageSkip += 1;
      f.setPage(skip: pageSkip);
      
      var l = await _bcService.getAllPostedSalesInvoice(filter: f);
      salesInvoiceList.addAll(l);
    } catch (e) {
      Utils.err("SalesInvoiceViewModel load more error $e");
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
