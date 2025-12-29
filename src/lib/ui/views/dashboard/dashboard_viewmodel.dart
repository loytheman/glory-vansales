import 'package:glory_vansales_app/app/app.dialogs.dart';
import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/helpers/utils.dart';
import 'package:glory_vansales_app/models/model.customer.dart';
import 'package:glory_vansales_app/services/business_central_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _dialogService = locator<DialogService>();
  final _bcService = locator<BusinessCentralService>();
  List<Customer> customerList = [];

  Future<void> refreshData() async {
    setBusy(true);
    customerList = [];

    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      customerList = await _bcService.getAllCustomers();
      Utils.log(customerList);
    } catch (e) {
      Utils.err("DashboardViewModel refreshData error $e");
    }

    //showBiometricLoginDialog();
    setBusy(false);
  }

  void showBiometricLoginDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.biometricLogin,
    );
  }
}
