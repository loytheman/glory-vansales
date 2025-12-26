// ignore_for_file: non_constant_identifier_names

import 'package:m360_app_corpsec/helpers/utils.dart';

class Config {
  //oidc
  static String MS_URL = "https://login.microsoftonline.com/";
  static String TENANT_ID = "d62e4ed3-ef4a-42a3-8978-7fde68b5c61b";
  static String SCOPE = "https://api.businesscentral.dynamics.com/.default openid profile offline_access";
  static late String MODE;
  static late String DISCOVERY_URL;
  static late String AUTH_URL;
  static late String TOKEN_URL;
  static late String END_SESSION_URL;
  static late String CLIENT_ID;
  static late String CLIENT_SECRET;
  static late String REDIRECT_URL;
  static late String LOGOUT_URL;
  static late String POST_LOGOUT_REDIRECT_URL;

  //api
  //https://api.businesscentral.dynamics.com/v2.0/d62e4ed3-ef4a-42a3-8978-7fde68b5c61b/Staging/api/v2.0/$metadata#companies(c3505205-7bd0-f011-8bce-6045bd74ddca)/customers
  static String MS_API_URL = "https://api.businesscentral.dynamics.com/v2.0/";
  static late String API_BASE_URL;
  static late String CENTRAL_API_BASE_URL;

  static bool inStageEnv() {
    return MODE != 'prod';
  }

  static initMode(String mode) {
    String env = "Staging";
    if (mode == "stg") {
      MODE = "stg";
      // DISCOVERY_URL = "https://account.meyzer.xyz/.well-known/openid-configuration";
      DISCOVERY_URL = "";
      AUTH_URL = "$MS_URL/$TENANT_ID/oauth2/v2.0/authorize";
      TOKEN_URL = "$MS_URL/$TENANT_ID/oauth2/v2.0/token";
      // END_SESSION_URL = "https://login.microsoftonline.com/<TenantID>/oauth2/v2.0/logout?post_logout_redirect_uri=<RedirectURL>";
      CLIENT_ID = "f3d2bf52-c3ca-4efb-a748-32e8a448c794";
      CLIENT_SECRET = "MeR8Q~vFwpFzlWIDnbix_uHqpb2w.nNGltCQfbq~";
      REDIRECT_URL = "https://glory-vansales.lyhco.me/auth-callback";
      // LOGOUT_URL = "https://account.meyzer.xyz/session/end";
      POST_LOGOUT_REDIRECT_URL = "https://localhost/post-logout";
      END_SESSION_URL = "$MS_URL/$TENANT_ID/oauth2/v2.0/logout?post_logout_redirect_uri=$POST_LOGOUT_REDIRECT_URL";
      API_BASE_URL = '$MS_API_URL/$TENANT_ID/$env/api/v2.0';
    } else if (mode == "sit") {
      MODE = "sit";

    } else if (mode == "prod") {
      MODE = "prod";

    }
  }

  static debug() {
    Utils.log("MODE: $MODE");
    Utils.log("DISCOVERY_URL: $DISCOVERY_URL");
    Utils.log("CLIENT_ID: $CLIENT_ID");
    Utils.log("REDIRECT_URL: $REDIRECT_URL");
    Utils.log("POST_LOGOUT_REDIRECT_URL: $POST_LOGOUT_REDIRECT_URL");
    Utils.log("API_BASE_URL: $API_BASE_URL");
  }

  // static const MODE = String.fromEnvironment('MODE');
}

// class ConfigStg {
//   static const DISCOVERY_URL = "https://account.meyzer.xyz/.well-known/openid-configuration";
//   static const CLIENT_ID = "mobile-corpsec";
//   static const REDIRECT_URL = "https://central.meyzer.xyz/callback";
//   static const POST_LOGOUT_REDIRECT_URL = "https://central.meyzer.xyz/postlogout";
// }
