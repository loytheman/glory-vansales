import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/services/company_service.dart';
import 'package:stacked/stacked.dart';

class CompanySelectorDialogModel extends BaseViewModel {
  final _companyService = locator<CompanyService>();
  List<Company> mockCompanyArr = List.filled(7, Company.fromMock());
  List<Company> get companyArr => _companyService.companyArr;

  Future<void> refreshData() async {
    setBusy(true);
    await _companyService.getAllCompany();
    setBusy(false);
  }

  void onSelectCompany(Company c) async {
    await _companyService.setCurrentCompany(companyId: c.id!);
  }
}
