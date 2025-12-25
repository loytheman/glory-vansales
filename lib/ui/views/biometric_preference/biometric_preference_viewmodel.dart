import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BiometricPreferenceViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  bool? _useBiometricFlag;

  void useBiometric(bool value) async {
    if (value) {
      await _authenticationService.biometricAuthAction();
      if (_authenticationService.isLocalAuthenticated) {
        _useBiometricFlag = true;
        await _authenticationService.setUseBiometricAction(value);
      }
    } else {
      _useBiometricFlag = false;
      await _authenticationService.setUseBiometricAction(value);
    }
    // var useBiometricFlag = await StoreHelper.read('use_biometric_flag');

    if (_useBiometricFlag != null) {
      _navigationService.back(result: value);
    }
    // maybe later set it to 'no/maybe later'
  }
}
