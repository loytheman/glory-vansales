import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.customer.dart';
import 'package:m360_app_corpsec/services/customer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _dialogService = locator<DialogService>();
  final _customerService = locator<CustomerService>();
  List<Customer> customerList = [];

  Future<void> refreshData() async {
    setBusy(true);
    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      customerList = await _customerService.getAllCustomers();
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
