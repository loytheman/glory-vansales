// ignore_for_file: non_constant_identifier_names

import 'package:m360_app_corpsec/helpers/utils.dart';

class Config {
  //oidc
  static late String MODE;
  static late String DISCOVERY_URL;
  static late String CLIENT_ID;
  static late String REDIRECT_URL;
  static late String LOGOUT_URL;
  static late String POST_LOGOUT_REDIRECT_URL;

  //api
  static late String API_BASE_URL;
  static late String CENTRAL_API_BASE_URL;

  static bool inStageEnv() {
    return MODE != 'prod';
  }

  static initMode(String mode) {
    if (mode == "stg") {
      MODE = "stg";
      DISCOVERY_URL = "https://account.meyzer.xyz/.well-known/openid-configuration";
      //oidcConnect: handshake error
      //DISCOVERY_URL = "https://127.0.0.1:3002/.well-known/openid-configuration";
      CLIENT_ID = "mobile-corpsec";
      REDIRECT_URL = "https://corpsec.meyzer.xyz/auth-callback";
      LOGOUT_URL = "https://account.meyzer.xyz/session/end";
      //loynote: should we have a delicate domain to handle mobile deep link post login?
      POST_LOGOUT_REDIRECT_URL = "https://corpsec.meyzer.xyz/post-logout";
      API_BASE_URL = 'https://api.corpsec.meyzer.xyz/v1';
      // API_BASE_URL = 'https://localhost:3004/v1';
      CENTRAL_API_BASE_URL = 'https://api.central.meyzer.xyz/v1';
      // CENTRAL_API_BASE_URL = 'https://localhost:3005/v1';
      //API_BASE_URL = "https://127.0.0.1:3004/v1";
    } else if (mode == "sit") {
      MODE = "sit";
      DISCOVERY_URL = "https://account.meyzer360.rocks/.well-known/openid-configuration";
      CLIENT_ID = "mobile-corpsec";
      REDIRECT_URL = "https://central.meyzer360.rocks/callback";
      LOGOUT_URL = "https://account.meyzer360.rocks/session/end";
      POST_LOGOUT_REDIRECT_URL = "https://corpsec.meyzer360.rocks/post-logout";
      API_BASE_URL = 'https://api.corpsec.meyzer360.rocks/v1';
      CENTRAL_API_BASE_URL = 'https://api.central.meyzer360.rocks/v1';
    } else if (mode == "prod") {
      MODE = "prod";
      DISCOVERY_URL = "https://account.meyzer360.com/.well-known/openid-configuration";
      CLIENT_ID = "mobile-corpsec";
      REDIRECT_URL = "https://central.meyzer360.com/callback";
      LOGOUT_URL = "https://account.meyzer360.com/session/end";
      POST_LOGOUT_REDIRECT_URL = "https://corpsec.meyzer360.com/post-logout";
      API_BASE_URL = 'https://api.corpsec.meyzer360.com/v1';
      CENTRAL_API_BASE_URL = 'https://api.central.meyzer360.com/v1';
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
