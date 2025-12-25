import 'package:flutter/services.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:m360_app_corpsec/services/test_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:m360_app_corpsec/helpers/store.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  
  // final _testService = locator<TestService>();
  bool get useBiometricFlag => _useBiometricFlag;
  bool _useBiometricFlag = false;

  /**
   * todo: testing
   */
  int _counter = 0;
  String get counterLabel => 'Parent Counter is: $_counter';
  final channel = const MethodChannel('channel1');
  StartupViewModel() {
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'child_push':
          _counter = call.arguments;
          notifyListeners();
          return "child_push ok!";
        case 'child_pull':
          return _counter;

        default:
          throw MissingPluginException('Not implemented');
      }
    });
  }
  /** */

  Future<void> runStartupLogic() async {
    setBusy(true);
    // _testService.log();
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
    await _navigationService.navigateTo(Routes.dashboardView, transition: TransitionsBuilders.fadeIn);
    setBusy(false);
  }
}
