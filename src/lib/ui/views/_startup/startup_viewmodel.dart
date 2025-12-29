import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:glory_vansales_app/helpers/store.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  bool get useBiometricFlag => _useBiometricFlag;
  bool _useBiometricFlag = false;

  Future<void> runStartupLogic() async {
    setBusy(true);
    await _authenticationService.init();
    final ts = await _authenticationService.getLoginViaStore();
    if (ts == null) {
      _navigationService.navigateTo(Routes.loginView,
          arguments: LoginViewArguments(useBiometricFlag: _useBiometricFlag), transition: TransitionsBuilders.fadeIn);
    } else {
      await runStartupLogicWithTokenSet(ts);
    }
    setBusy(false);
  }

  void authAction() async {
    await runStartupLogic();
  }

  Future<bool> checkBiometrics() async {
    await _authenticationService.biometricAuthAction(reason: 'Please authenticate to access the app');
    if (!_authenticationService.isLocalAuthenticated) return false;
    return true;
  }

  // auth callback
  Future<void> runStartupLogicWithTokenSet(ts) async {
    setBusy(true);
    var useBiometricFlag = await StoreHelper.read('use_biometric_flag');
    // login with biometric 'yes'
    if (useBiometricFlag == 'yes') {
      _useBiometricFlag = true;
      notifyListeners();
      final c = await checkBiometrics();
      if (!c) return;
    }
    // clean state
    if (useBiometricFlag == null) {
      await _navigationService.navigateTo(
        Routes.biometricPreferenceView,
        transition: TransitionsBuilders.slideBottom,
      );
    }
    // login with biometric 'no'
    await _authenticationService.afterLogin(ts);
    //await _navigationService.navigateTo(Routes.dashboardView, transition: TransitionsBuilders.fadeIn);
    await _navigationService.navigateTo(Routes.salesInvoiceView, transition: TransitionsBuilders.fadeIn);
    setBusy(false);
  }
}
