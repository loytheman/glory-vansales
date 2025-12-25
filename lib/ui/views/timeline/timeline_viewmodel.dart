import 'package:m360_app_corpsec/services/test_service.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/models/model.company.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

class TimelineViewModel extends ReactiveViewModel {
  int counter = 0;
  final _companyService = locator<CompanyService>();
  final _testService = locator<TestService>(instanceName: 'corpsec');
  Company? get company => _companyService.currentCompany;
  List<Timeline> timeline = [];

  Future<void> init() async {
    // await  StackedLocator.instance.popScopesTill('root');
    // await StackedLocator.instance.popScope();
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

  void test() {
    _testService.log();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_companyService];
}
