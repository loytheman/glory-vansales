import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/helpers/store.dart';
import 'package:glory_vansales_app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class BiometricLoginDialogModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();

  Future<void> useBiometric(bool value) async {
    setBusy(true);
    if (value) {
      await _authenticationService.biometricAuthAction();
      if (_authenticationService.isLocalAuthenticated) {
        _authenticationService.setUseBiometricAction(value);
      }
      return;
    }
    _authenticationService.setUseBiometricAction(value);
    setBusy(false);
  }
}
