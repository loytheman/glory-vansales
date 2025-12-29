import 'package:glory_vansales_app/app/app.locator.dart';
import 'package:glory_vansales_app/app/app.router.dart';
import 'package:glory_vansales_app/common/constants.dart';
import 'package:glory_vansales_app/helpers/mixins.dart';
import 'package:glory_vansales_app/helpers/shareFunc.dart';
import 'package:glory_vansales_app/models/model.httpResponse.dart';
import 'package:glory_vansales_app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel with FormMixin {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  bool hasFormError = false;

  @override
  setFormStatus() {
    hasFormError = formCheckHasError(fieldsValidationMessages);
  }

  void onLogin() async {
    setBusy(true);
    notifyListeners();

    try {
      await _authenticationService.loginViaEmail(formValueMap);
    } on ApiException catch (e) {
      if (e.code == ErrorType.INVALID_CREDENTIALS) {
        Map<String, String> e = {"password": "Invalid Credentials"};
        setValidationMessages(e);
      } else if (e.code == ErrorType.VALIDATION_ERROR) {
        final v = ValidationException.fromApiException(e);
        setValidationMessages(v.mapErrors());
      } else {
        ShareFunc.showToast(ErrorMessage.UNKNOWN_ERROR);
      }
    }

    setBusy(false);
    notifyListeners();

    if (_authenticationService.isLogin()) {
      _navigationService.replaceWith(Routes.dashboardView);
    }
  }

  void onOidcLogin() async {
    try {
      await _authenticationService.loginViaOidc();
      // _navigationService.navigateTo(Routes.startupView);
    } catch (e) {
      print(e);
    }
  }

  void onOidcLogout() async {
    //Utils.log("onOidcLogout");
    await _authenticationService.logoutOidc();
  }
}
