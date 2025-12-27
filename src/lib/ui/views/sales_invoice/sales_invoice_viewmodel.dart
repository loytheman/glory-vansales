import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.salesInvoice.dart';
import 'package:m360_app_corpsec/services/business_central_service.dart';
import 'package:stacked/stacked.dart';

class SalesInvoiceViewModel extends ReactiveViewModel {
  // final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  List<SalesInvoice> salesInvoiceList = [];

  Future<void> refreshData() async {
    setBusy(true);
    salesInvoiceList = [];

    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      salesInvoiceList = await _bcService.getAllPostedSalesInvoice();
      Utils.log(salesInvoiceList);
    } catch (e) {
      Utils.err("SalesInvoiceViewModel refreshData error $e");
    }

    setBusy(false);
  }

}
