// ignore_for_file: constant_identifier_names

class ErrorType {
  static const BAD_REQUEST = "bad_request";
  static const INVALID_CREDENTIALS = "invalid_credentials";
  static const INVALID_INDEX = "invalid_index";
  static const JWT_EXPIRED = "jwt_expired";
  static const JWT_INVALID = "jwt_invalid";
  static const MISSING_API_CREDENTIALS = "missing_api_credentials";
  static const MISSING_CREDENTIALS = "missing_credentials";
  static const MISSING_REFRESH_TOKEN = "missing_refresh_token";
  static const NO_PERMISSION = "no_permission";
  static const NOT_FOUND = "not_found";
  static const REFRESH_TOKEN_EXPIRED = "refresh_token_expired";
  static const REFRESH_TOKEN_INVALID = "refresh_token_invalid";
  static const TOKEN_EXPIRED = "token_expired";
  static const UPLOAD_ERROR = "upload_error";
  static const NOT_HANDLED = "not_handled";
  static const VALIDATION_ERROR = "validation_error";
  static const OIDC_ERROR = "oidc_error";
}

class ErrorMessage {
  static const EMAIL_NOT_FOUND = "The email address provided is not associated with any account.";
  static const INVALID_CREDENTIALS = "The provided credentials are invalid.";
  static const INVALID_INDEX = "The provided index is outside the permissible range.";
  static const ITEM_NOT_FOUND = "The item you are trying to access does not exist.";
  static const JWT_EXPIRED = "The JWT token provided has expired.";
  static const JWT_INVALID = "The provided JWT is invalid. Unauthorized access.";
  static const KYC_ALREADY_VERIFIED = "The provided entity is already kyc verified.";
  static const KYC_NOT_REQUIRED = "KYC not required for company.";
  static const MISSING_API_CREDENTIALS = "Missing access token or ID token.";
  //static const MISSING_CREDENTIALS = "CompanyId is required.";
  static const MISSING_REFRESH_TOKEN = "Refresh token is missing from cookies. Unauthorized access.";
  static const NO_PERMISSION = "You do not have permission to perform this action.";
  static const NOT_FOUND = "The requested resource couldn't be found.";
  static const TOKEN_EXPIRED = "Invalid or expired token.";
  static const TRY_DIFFERENT_EMAIL = "The email address provided is already in use.";
  static const UPLOAD_ERROR = "Failed to upload one or more documents.";
  static const VALIDATION_ERROR = "There are validation errors. Please correct and resubmit.";
  static const UNKNOWN_ERROR = "An unknown error has occurred. Please try again later.";
}

class WebApiError {
  static const VALIDATION_ERROR = "validation_error";
  // MISSING_CREDENTIALS: "missing_credentials";
  static const INVALID_CREDENTIALS = "invalid_credentials";
  static const INVALID_CODE = "invalid_code";
  static const INVALID_SESSION = "invalid_session";
  static const USER_EXISTS = "user_exists";
  static const USER_NOT_VERIFIED = "user_not_verified";
  static const USER_DISABLED = "user_disabled";
  static const TOKEN_EXPIRED = "token_expired";
  static const EXCEEDED_MAX_ATTEMPT = "exceeded_max_attempt";
  static const SERVICE_UNAVAILABLE = "service_unavailable";
  static const REFRESH_TOKEN_EXPIRED = "refresh_token_expired";
  static const REFRESH_TOKEN_INVALID = "refresh_token_invalid";
  static const JWT_EXPIRED = "jwt_expired";
  static const JWT_INVALID = "jwt_invalid";
  static const MISSING_REFRESH_TOKEN = "missing_refresh_token";
}

class EventType {
  static const NONE = "none";
  static const REFRESH = "refresh";

  static const RETURN_TO_AUTH_CODE_LOGIN_FLOW = "return_to_auth_code_login_flow";
}

class StoreKey {
  static const ACCESS_TOKEN = "accessToken";
  static const ID_TOKEN = "idToken";
  static const REFRESH_TOKEN = "refreshToken";
  static const EXP = "exp";

  static const OIDC_ACCESS_TOKEN = "oidc_accessToken";
  static const OIDC_ID_TOKEN = "oidc_idToken";
  static const OIDC_REFRESH_TOKEN = "oidc_refreshToken";
  static const OIDC_EXP = "oidc_exp";

  static const PREF_COMPANY_ID = "pref_company_id";
  static const PREF_COMPANY_NAME = "pref_company_name";
  static const PREF_COMPANY_REG_NO = "pref_company_reg_no";

  static const USE_BIOMETRIC_FLAG = "use_biometric_flag";

  //static const PREF_FCM_TOKEN = "pref_fcm_token";
}

class ChartColor {
  static final set1 = [0xFF3154D0, 0xFF647AEB, 0xFFC8CDF8, 0xFFEFF0FD];
  static final set2 = [
    0xFF0F62E6, 0xFF87B1F3, 0xFFCFE0FA, 0xFFf1f6ff,
    //0xFFF59937, 0xFFffce9a, 0xFFffe8d0, 0xFFffeedd, 0xFFfff6ed
  ];
}

class MemberType {
  //officers
  static const DIRECTOR = "director";
  static const NOMINEE_DIRECTOR = "nominee director";
  static const SECRETARY = "secretary";
  static const MANAGING_DIRECTOR = "managing director";
  static const PUBLIC_ACCOUNTANT_EMPLOYEE = "public accountant employee";
  static const CEO = "ceo";
  static const CHAIRMAN = "chairman";
  //other
  static const CONTACT = "contact";
  static const AUDITOR = "auditor";
  static const MANAGER = "manager";
  static const CONTROLLER = "controller";
  static const REPRESENTATIVE = "representative";

  //const officerTypes = [ "director",  "nominee director", "secretary", "managing director", "public accountant employee", "ceo", "chairman" ];
  static const officerTypes = [
    DIRECTOR,
    NOMINEE_DIRECTOR,
    SECRETARY,
    MANAGING_DIRECTOR,
    PUBLIC_ACCOUNTANT_EMPLOYEE,
    CEO,
    CHAIRMAN
  ];
}
