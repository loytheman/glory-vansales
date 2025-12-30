import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.salesOrder.dart';
import 'package:glory_vansales_app/services/business_central_service.dart';
import 'package:stacked/stacked.dart';

class SalesOrderDetailViewModel extends ReactiveViewModel {
  // final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  SalesOrder? salesOrder;

  SalesOrderDetailViewModel(this.salesOrder);

  Future<void> refreshData() async {
    setBusy(true);

    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      salesOrder = await _bcService.getSalesOrderDetail(salesOrder!.id);
      Utils.log(salesOrder);
    } catch (e) {
      Utils.err("SalesOrderDetailViewModel refreshData error $e");
    }

    setBusy(false);
  }
}
