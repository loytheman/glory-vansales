import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/helpers/shareFunc.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class DeepLinkHelper {
  static final _authenticationService = locator<AuthenticationService>();
  static final _navigationService = locator<NavigationService>();

  static final _appLinks = AppLinks();
  static StreamSubscription? _sub;

  static void init() {
    //stopListen();
    _sub = _appLinks.uriLinkStream.listen((uri) async {
      Utils.log("App link path: ${uri.path}");
      if (uri.path == "/auth-callback") {
        final code = uri.queryParameters["code"] ??= "xxx";
        // Utils.log(">>>>> callback code $code");
        try {
          ShareFunc.showToast("logging in ...");
          // LifeCycleHelper.addStreamEvent(EventType.RETURN_TO_AUTH_CODE_LOGIN_FLOW);
          final ts = await _authenticationService.returnToAuthCodeLoginFlow(code);
          // LifeCycleHelper.addStreamEvent(EventType.RETURN_TO_AUTH_CODE_LOGIN_FLOW);
          // _navigationService.navigateTo(Routes.startupView, tokenSet: ts);
          _navigationService.navigateToStartupView(
            tokenSet: ts,
          );
        } catch (e) {
          Utils.log("Error in applink callback - $e");
        }
      } else if (uri.path == "/post-logout") {
        ShareFunc.showToast("Logout successfully");
      }
    });
  }

  static void dispose() {
    _sub?.cancel();
  }
}
