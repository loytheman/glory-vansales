import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/models/model.account.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  Account? user;
  bool get useBiometricFlag => _useBiometricFlag;
  bool _useBiometricFlag = false;

  Future<void> init() async {
    user = _authenticationService.user;
    // print(user);
    var b = await StoreHelper.read('use_biometric_flag');
    if (b == 'yes') _useBiometricFlag = true;
    notifyListeners();
    // final oidcTs = await _authenticationService.getOidcTokenWithRefreshToken();
    // print(oidcTs);
    TokenSet? oidcTs = await TokenSet.retreiveOIDCSecure();
    // if(oidcTs == null) {
    //  oidcTs = await _authenticationService.getOidcTokenWithRefreshToken();
    // }
    final ts = await _authenticationService.loginCentralWithOidcToken(oidcTs!);
    print(ts.idToken);
    user = Account.fromTokenSet(ts);
    // print(user.TokenSetApp?.accessToken);
    // await ts.saveSecure();

  }

  void useBiometric() async {
    if (!_useBiometricFlag) {
      final result = await _navigationService.navigateTo(
        Routes.biometricPreferenceView,
        transition: TransitionsBuilders.slideBottom,
      );
      if (result) {
        _useBiometricFlag = result;
      }
    } else {
      await _authenticationService.biometricAuthAction();
      if (_authenticationService.isLocalAuthenticated) {
        _useBiometricFlag = !_useBiometricFlag;
        await _authenticationService.setUseBiometricAction(_useBiometricFlag);
      }
    }
    await init();
  }
}
