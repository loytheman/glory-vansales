import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.salesInvoice.dart';
import 'package:m360_app_corpsec/services/business_central_service.dart';
import 'package:stacked/stacked.dart';

class SalesInvoiceDetailViewModel extends ReactiveViewModel {
  // final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  SalesInvoice? salesInvoice;

  SalesInvoiceDetailViewModel(this.salesInvoice);

  Future<void> refreshData() async {
    setBusy(true);

    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      salesInvoice = await _bcService.getSalesInvoiceDetail(salesInvoice!.id);
      Utils.log(salesInvoice);
    } catch (e) {
      Utils.err("SalesInvoiceDetailViewModel refreshData error $e");
    }

    setBusy(false);
  }
}
