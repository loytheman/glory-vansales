import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends ReactiveViewModel {
  final _dialogService = locator<DialogService>();
  final _companyService = locator<CompanyService>();
  Company? get company => _companyService.currentCompany;

  Future<void> refreshData() async {
    setBusy(true);
    // await Future.delayed(const Duration(milliseconds: 30));
    try {
      if (company != null && company?.id != null) {
        final c = await _companyService.getCompany(company!.id!);
        _companyService.setCurrentCompany(company: c);
      }
    } catch (e) {
      Utils.err("DashboardViewModel refreshData error $e");
    }

    setBusy(false);
  }

  void showCompanySelector() {
    _dialogService.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.companySelector,
      title: 'foo',
      description: 'bar',
    );
  }

  void showBiometricLoginDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.biometricLogin,
    );
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_companyService];
}
