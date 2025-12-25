import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:stacked/stacked.dart';

class DocumentViewModel extends ReactiveViewModel {
  final _companyService = locator<CompanyService>();
  Company? get company => _companyService.currentCompany;
  List<Document> documentList = [];

  Future<void> init() async {
    _companyService.addListener(refreshData);
    await refreshData();
  }

  Future<void> refreshData() async {
    setBusy(true);
    if (company?.id != null) {
      documentList = await _companyService.getDocuments(company!.id!);
    }
    Utils.log("Document refreshData");
    setBusy(false);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_companyService];
}
