// ignore_for_file: unused_catch_clause, non_constant_identifier_names
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:local_auth/local_auth.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/common/config.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/helpers/mixins.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.account.dart';
import 'package:m360_app_corpsec/models/model.httpResponse.dart';
import 'package:m360_app_corpsec/services/_webapi.dart';
import 'package:m360_app_corpsec/services/company_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticationService with ApiServiceMixin {
  final _navigationService = locator<NavigationService>();
  // final _companyService = locator<CompanyService>();
  Account? user;

  final discoveryUrl = Config.DISCOVERY_URL;
  final clientId = Config.CLIENT_ID;
  final clientSecret = Config.CLIENT_SECRET;
  final redirectUrl = Config.REDIRECT_URL;
  final scope = Config.SCOPE;
  // final scopes = ['profile', "openid", "permissions"];
  // final logoutUrl = Config.LOGOUT_URL;
  final postLogoutRedirectUrl = Config.POST_LOGOUT_REDIRECT_URL;
  
  OpenIdConfig? openIdConfig;

  final LocalAuthentication _auth = LocalAuthentication();
  bool get isLocalAuthenticated => _isLocalAuthenticated;
  bool _isLocalAuthenticated = false;

  Future<void> init() async {
    // openIdConfig = OpenIdConfig.fromDiscoveryUrl(discoveryUrl);
    // await openIdConfig?.getConfiguration();
    final a = Config.AUTH_URL;
    final t = Config.TOKEN_URL;
    final e = Config.END_SESSION_URL;
    openIdConfig = OpenIdConfig.fromUrl(a, t, e);
  }

  bool isLogin() {
    return user?.isLogin() ?? false;
  }

  Future<TokenSet?> getLoginViaStore() async {
    TokenSet? ts = await TokenSet.retreiveSecure();
    if (ts != null) {
      int? expiryTimestamp = int.tryParse(ts.exp ?? "");
      if (expiryTimestamp != null) {
        bool isExpired =
            DateTime.now().millisecondsSinceEpoch ~/ 1000 >= expiryTimestamp;
        if (isExpired) {
          // expired token, need to refresh
          // final t = await loginViaRefreshToken();
          final t = getOidcTokenWithRefreshToken();
          return t;
        } else {
          return ts;
        }
      }
    }
    return null;
  }

  Future<void> loginViaOidc() async {
    setBusy(true);

    String qs = Uri(queryParameters: {
      'client_id': clientId,
      'client_secret': clientSecret,
      'response_type': 'code',
      'redirect_uri': redirectUrl,
      //'code_challenge': '',
      //'code_challenge_method': 'S256',
      // 'scope': scopes.join(" "),
      'scope': scope,
    }).query;

    final url = "${openIdConfig?.authorizationEndpoint}?$qs";
    //loynote: open external browser and will redirect to callback will be handled by startup deep link service
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    )) {
      setBusy(false);
      throw Exception('Could not launch $url');
    }
  }

  Future<TokenSet> returnToAuthCodeLoginFlow(String code) async {
    final oidcTs = await _exchangeCodeForOidcToken(code);
    //loynote: skipping intermediary server for now
    // final ts = await _loginWithOidcToken(oidcTs);
    user?.tokenSetOidc = oidcTs;
    // ts.saveSecure();
    // return ts;
    return oidcTs;
  }

  Future<TokenSet> _exchangeCodeForOidcToken(String code) async {
    setBusy(true);

    Map<String, String> data = {
      'client_id': clientId,
      'client_secret': clientSecret,
      'grant_type': 'authorization_code',
      'redirect_uri': redirectUrl,
      'code': code,
      //'code_verifier': "S",
      'scope': scope,
    };
    final h = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final url = openIdConfig?.tokenEndpoint;
    final r = await WebApi.call("POST", url!, data, h);
    if (r.statusCode == 200) {
      final a = JWT.decode(r.data['access_token']);
      final e = a.payload["exp"];
      final ts = TokenSet(
          accessToken: r.data['access_token'],
          idToken: r.data['id_token'],
          refreshToken: r.data['refresh_token'],
          exp: e.toString(),
          // exp: r.data['expires_in'],
        );
      ts.saveOIDCSecure();
      return ts;
    }

    throw ErrorType.OIDC_ERROR;
  }

  // use RefreshToken to get new access token as access token would be expired in 5 minutes
  Future<TokenSet> getOidcTokenWithRefreshToken() async {
    setBusy(true);
    // final rt = await StoreHelper.read(StoreKey.REFRESH_TOKEN);
    var ort = await StoreHelper.read(StoreKey.OIDC_REFRESH_TOKEN);
    if (ort != null) {
      Map<String, String> data = {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'refresh_token',
        'refresh_token': ort,
        'scope': scope,
        'consent': 'none',
      };
      final h = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final url = openIdConfig?.tokenEndpoint;
      final r = await WebApi.call("POST", url!, data, h);
      if (r.statusCode == 200) {
        final a = JWT.decode(r.data['access_token']);
        final e = a.payload["exp"];
        final ts = TokenSet(
            accessToken: r.data['access_token'],
            idToken: r.data['id_token'],
            refreshToken: r.data['refresh_token'],
            exp: e.toString());
        ts.saveOIDCSecure();
        return ts;
      }
    }

    throw ErrorType.OIDC_ERROR;
  }

  Future<TokenSet> loginCentralWithOidcToken(TokenSet tr) async {
    return _loginWithOidcToken(tr);
  }

  Future<TokenSet> _loginWithOidcToken(TokenSet tr) async {
    setBusy(true);
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': tr.accessToken,
      'Token': tr.idToken,
    };
    String endpoint = "/auth/oidc-login";
    final ar = await WebApi.callApi("POST", endpoint, {}, headers);

    // ShareFunc.cancelToast();
    // ShareFunc.showToast("login ok");

    final ts = TokenSet.fromApiResponseLogin(ar);
    setBusy(false);
    return ts;
    // await _afterLogin(ts);
  }

  Future<void> loginViaEmail(Map data) async {
    setBusy(true);

    try {
      final ar = await WebApi.callApi("POST", "/admin/sign-in", data);
      final ts = TokenSet.fromApiResponseLogin(ar);
      await _afterLogin(ts);
    } on ApiException catch (e) {
      rethrow;
    }

    setBusy(false);
  }

  Future<TokenSet> loginViaRefreshToken() async {
    final h = {'Cookie': 'rf2=${user?.tokenSetApp?.refreshToken}'};
    //useAutoRefreshClientFlag
    final ar = await WebApi.callApi("POST", "/auth/refresh-token", {}, h);
    final ts = TokenSet.fromApiResponseLogin(ar);
    //_afterLogin(ts);
    user = Account.fromTokenSet(ts);
    //Utils.log(user?.tokenSetApp?.refreshToken);
    return ts;
  }

  Future<void> logout() async {
    setBusy(true);
    //await Future.delayed(const Duration(seconds: 1));
    await logoutOidc();
    await _afterLogout();
    setBusy(false);
  }

  Future<void> logoutOidc() async {
    final logoutUrl = openIdConfig?.endSessionEndpoint;

    //const url = "https://account.meyzer.xyz/session/end?client_id=mobile-corpsec&post_logout_redirect_uri=https://central.meyzer.xyz/postlogout";
    final url =
        "$logoutUrl?client_id=$clientId&post_logout_redirect_uri=$postLogoutRedirectUrl";
    //loynote: open external browser and will redirect to post logout
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      setBusy(false);
      throw Exception('Could not launch $url');
    }
  }

  Future<void> registerDeviceToken(String deviceToken) async {
    setBusy(true);
    final userId = user?.userId;
    var data = {"deviceToken": deviceToken};

    try {
      if (userId == null) throw "no user!";
      //https://api.corpsec.meyzer.xyz/v1/account/device-token
      final ar = await WebApi.callApi("PATCH", "/account/device-token", data);
      // Utils.log(">>>>>> $ar");
    } on ApiException catch (e) {
      print('calling registerDeviceToken Api Exception, $e');
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
    } catch (e) {
      print('Unexpected error occurred: $e');
    }

    setBusy(false);
  }

  Future<void> afterLogin(TokenSet ts) async {
    await _afterLogin(ts);
  }

  Future<void> _afterLogin(TokenSet ts) async {
    user = Account.fromTokenSet(ts);
    // Utils.log("_afterLogin: $user");
    await ts.saveSecure();
    // _navigationService.replaceWith(Routes.dashboardView);
    // final l = await _companyService.getAllCompany();
    // final c = await StoreHelper.readPrefCompany();
    // Utils.log("_afterLogin: pref company $c");
    // if (c != null) {
    //   _companyService.setCurrentCompany(companyId: c.id);
    // } else if (l.isNotEmpty) {
    //   _companyService.setCurrentCompany(companyId: l[0].id);
    // } else {
    //   Utils.err("_afterLogin error: no companies selected");
    // }

    // await registerDeviceToken(PushHelper.fcmToken);
  }

  Future<void> _afterLogout() async {
    await StoreHelper.clearCredential();
    _navigationService.replaceWith(Routes.loginView);
  }

  Future<void> biometricAuthAction({String reason = ' '}) async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    // print(canAuthenticateWithBiometrics);
    if (canAuthenticateWithBiometrics) {
      final List<BiometricType> availableBiometrics =
          await _auth.getAvailableBiometrics();
      print(availableBiometrics);
      // if (availableBiometrics.isNotEmpty) {
      //   // Some biometrics are enrolled.
      // }

      // if (availableBiometrics.contains(BiometricType.strong) ||
      //     availableBiometrics.contains(BiometricType.face)) {
      //   // Specific types of biometrics are available.
      //   // Use checks like this with caution!
      // }
      try {
        final bool didLocalAuthenticate = await _auth.authenticate(
            localizedReason: reason,
            options: const AuthenticationOptions(
              biometricOnly: true,
            ));
        _isLocalAuthenticated = didLocalAuthenticate;
      } catch (e) {
        print(e);
      }
    } else {
      _isLocalAuthenticated = false;
    }
    // notifyListeners();
  }

  Future<void> setUseBiometricAction(bool value) async {
    if (value) {
      await StoreHelper.write('use_biometric_flag', 'yes');
    } else {
      StoreHelper.write('use_biometric_flag', 'no');
    }
  }
}

class OpenIdConfig {
  late final String discoveryUrl;
  String? authorizationEndpoint;
  String? tokenEndpoint;
  String? endSessionEndpoint;
  OpenIdConfig();


  factory OpenIdConfig.fromDiscoveryUrl(String url) {
    final cfg = OpenIdConfig();
    cfg.discoveryUrl = url;
    return cfg;
  }

  factory OpenIdConfig.fromUrl(String a, String t, String e) {
    final cfg = OpenIdConfig();
    cfg.authorizationEndpoint = a;
    cfg.tokenEndpoint = t;
    cfg.endSessionEndpoint = e;
    return cfg;
  }

  Future<void> getConfiguration() async {
    try {
      final r = await WebApi.call("GET", discoveryUrl);
      authorizationEndpoint = r.data["authorization_endpoint"];
      endSessionEndpoint = r.data["end_session_endpoint"];
      tokenEndpoint = r.data["token_endpoint"];
    } catch (e) {
      Utils.err("Error in OpenId connect discovery: $e");
    }
  }
}

//loynote: adb test deep links. no underscores!!! for custom scheme!

// adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE  -d "com.meyzer.myfirstapp/auth.callback"'
// adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE  -d "https://glory-vansales.lyhco.me/auth-callback"'

//flutter build apk
//adb install app-release.apk
//adb uninstall com.meyzer360.app_corpsec
//adb shell am force-stop com.meyzer360.app_corpsec
//adb shell am force-stop com.android.chrome
//adb shell am start -n com.meyzer360.app_corpsec/com.meyzer.myfirstapp.MainActivity
//adb reverse tcp:3002 tcp:3002
//adb reverse tcp:3004 tcp:3004
// adb reverse tcp:3005 tcp:3005

//for assetlinks.json, use [android studio -> tools --> app link assistant] to generate
//put in s3://site.central.meyzer360/site/.well-known/
