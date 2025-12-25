import 'package:m360_app_central/main.dart' as central;
import 'package:m360_app_corpsec/app/app.dialogs.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/main.dart' as corpsec;
import 'package:m360_app_corpsec/services/test_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

class CentralViewModel extends BaseViewModel {
  bool vmBusy = false;
  final _nav = locator<NavigationService>();
  final _dialog = locator<DialogService>();
  final _test = locator<TestService>(instanceName: 'corpsec');

  @override
  void dispose() async {
    print('Central Module is disposed');
    // await StackedLocator.instance.popScope();
    super.dispose();
    await corpsec.reInitRoot();
  }

  Future<void> init() async {
    // StackedLocator.instance.pushNewScope(
    //     scopeName: 'central',
    //     dispose: () async {
    //       // await locator.reset();
    //       await corpsec.reInitRoot();
    //     });
    // print('run here or it');
    // vmBusy = true;
    // await central.main();
    // vmBusy = false;
  }

  void toTimeline() {
    _nav.navigateTo(Routes.timelineView);
  }

  void showCompanySelector() {
    _dialog.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.companySelector,
      title: 'foo',
      description: 'bar',
    );
  }

  void showDialog() {
    _dialog.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked multiple stars on Github',
    );
  }

  void testService() {
    _test.log();
  }
}
