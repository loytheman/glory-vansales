import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/helpers/store.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.httpResponse.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Account {
  late String userId = "";
  late String name = "";
  late String firstName = "";
  late String lastName = "";
  late String mobileFull = "";
  late String displayPicture = "";
  late String email = "";
  late String mobileNumber = "";
  late String mobileCountryCode = "";
  late bool kycVerified = false;
  //late List<CompanyAccess> companyAccess;

  TokenSet? tokenSetApp;
  TokenSet? tokenSetOidc;

  // String? fcmToken;

  //constructor
  Account();

  factory Account.fromMock() {
    final c = Account();
    c.userId = BoneMock.chars(32);
    c.firstName = BoneMock.name;
    c.lastName = BoneMock.name;
    c.mobileFull = "";
    return c;
  }

  factory Account.fromTokenSet(TokenSet? ts) {
    final a = Account();
    a.tokenSetApp = ts;
    if (ts != null) {
      // final t1 = JWT.decode(ts.accessToken);
      final t2 = JWT.decode(ts.idToken);
      final payload = t2.payload;
      // final payload = {};

      a.userId = payload["sub"];
      a.name = payload["name"];
      // a.mobileFull = payload["mobileFull"];
      // a.firstName = payload["firstName"];
      // a.lastName = payload["lastName"];
      // a.displayPicture = payload["displayPicture"];
      // a.email = payload["email"];
      // a.mobileNumber = payload["mobile"];
      // a.mobileCountryCode = payload["mobileCountryCode"];
    }

    return a;
  }

  bool isLogin() {
    return (tokenSetApp != null);
  }
}

class TokenSet {
  final String accessToken;
  final String idToken;
  String? refreshToken;
  String? exp;

  TokenSet({required this.accessToken, required this.idToken, this.refreshToken, this.exp});

  factory TokenSet.fromApiResponseLogin(ApiResponse ar) {
    final a = JWT.decode(ar.data['accessToken']);
    final e = a.payload["exp"];
    final c = TokenSet(
      accessToken: ar.data['accessToken'],
      idToken: ar.data['idToken'],
      refreshToken: ar.data['refreshToken'],
      exp: e.toString(),
    );
    return c;
  }

  Future<void> saveSecure() async {
    await StoreHelper.write(StoreKey.ACCESS_TOKEN, accessToken);
    await StoreHelper.write(StoreKey.ID_TOKEN, idToken ?? '');
    await StoreHelper.write(StoreKey.REFRESH_TOKEN, refreshToken ?? '');
    await StoreHelper.write(StoreKey.EXP, exp ?? '');
  }

  Future<void> saveOIDCSecure() async {
    print('saveOIDCSecure');
    print(refreshToken);
    await StoreHelper.write(StoreKey.OIDC_ACCESS_TOKEN, accessToken);
    await StoreHelper.write(StoreKey.OIDC_ID_TOKEN, idToken ?? '');
    await StoreHelper.write(StoreKey.OIDC_REFRESH_TOKEN, refreshToken ?? '');
    await StoreHelper.write(StoreKey.OIDC_EXP, exp ?? '');
  }

  static Future<TokenSet?> retreiveSecure() async {
    final a = await StoreHelper.read(StoreKey.ACCESS_TOKEN);
    final b = await StoreHelper.read(StoreKey.ID_TOKEN);
    final c = await StoreHelper.read(StoreKey.REFRESH_TOKEN);
    final e = await StoreHelper.read(StoreKey.EXP);
    TokenSet? ts;
    try {
      ts = TokenSet(accessToken: a!, idToken: b!, refreshToken: c!, exp: e!);
    } catch (e) {
      Utils.log("no previous oidc login");
    }
    return ts;
  }

  static Future<TokenSet?> retreiveOIDCSecure() async {
    final a = await StoreHelper.read(StoreKey.OIDC_ACCESS_TOKEN);
    final b = await StoreHelper.read(StoreKey.OIDC_ID_TOKEN);
    final c = await StoreHelper.read(StoreKey.OIDC_REFRESH_TOKEN);
    final e = await StoreHelper.read(StoreKey.OIDC_EXP);
    TokenSet? ts;
    try {
      ts = TokenSet(accessToken: a!, idToken: b!, refreshToken: c!, exp: e!);
    } catch (e) {
      Utils.log("no previous oidc login");
    }
    return ts;
  }
}

// company access stuffs mainly for central?
// class CompanyAccess {
//   late String companyId = "";
//   late String baseRole = "";
//   late String moduleAccess = "";
//   late String registeredNumber = "";
//   late String companyName = "";

//   CompanyAccess();

//   factory CompanyAccess.fromMap(m) {
//     final c = CompanyAccess();
//     c.companyId = m.companyId;
//     c.baseRole = m.baseRole;
//     c.moduleAccess = m.moduleAccess;
//     c.registeredNumber = m.registeredNumber;
//     c.companyName = m.companyName;
//     return c;
//   }
// }

// class ModuleAccess {
//   late String module = "";
//   late String access = "";
// }
