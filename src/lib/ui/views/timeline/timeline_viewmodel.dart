import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/models/model.company.dart';
import 'package:glory_vansales_app/services/company_service.dart';
import 'package:stacked/stacked.dart';

class TimelineViewModel extends ReactiveViewModel {
  int counter = 0;
  final _companyService = locator<CompanyService>();
  Company? get company => _companyService.currentCompany;
  List<Timeline> timeline = [];

  Future<void> init() async {
    _companyService.addListener(refreshData);
    await refreshData();
  }

  Future<void> refreshData() async {
    setBusy(true);
    if (company?.id != null) {
      timeline = await _companyService.getDashboardTimeline(company!.id!);
    }

    //company?.id ??
    // notifyListeners();
    setBusy(false);
  }

  Future<void> increment() async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 3));
    setBusy(false);
    counter++;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_companyService];
}
