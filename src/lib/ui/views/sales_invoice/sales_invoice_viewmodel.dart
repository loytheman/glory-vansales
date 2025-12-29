import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/helpers/store.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.httpResponse.dart';
import 'package:glory_vansales_app/models/model.salesInvoice.dart';
import 'package:glory_vansales_app/services/business_central_service.dart';
import 'package:stacked/stacked.dart';

class SalesInvoiceViewModel extends ReactiveViewModel {
  // final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  List<SalesInvoice> salesInvoiceList = [];

  Future<void> refreshData() async {
    // await StoreHelper.clearCredential();

    setBusy(true);
    salesInvoiceList = [];

    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      var f = FilterQuery();
      f.filter(field:'customerNumber', value:'10000');
      f.filterDate(field:'invoiceDate', startDate:'2025-11-01', endDate: '2025-11-21');
      salesInvoiceList = await _bcService.getAllPostedSalesInvoice(filter: f);
      Utils.log(salesInvoiceList);
    } catch (e) {
      Utils.err("SalesInvoiceViewModel refreshData error $e");
    }

    setBusy(false);
  }
}
