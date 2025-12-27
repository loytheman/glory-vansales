// ignore_for_file: unused_catch_clause

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';
import 'package:m360_app_corpsec/app/app.router.dart';
import 'package:m360_app_corpsec/common/config.dart';
import 'package:m360_app_corpsec/common/constants.dart';
import 'package:m360_app_corpsec/helpers/shareFunc.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:m360_app_corpsec/models/model.httpResponse.dart';
import 'package:m360_app_corpsec/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:m360_app_corpsec/helpers/store.dart';

class WebApi {
  //static final WebApi _singleton = WebApi._();
  static final _authenticationService = locator<AuthenticationService>();
  static final _navigationService = locator<NavigationService>();
  static String baseUrl = Config.API_BASE_URL;
  static Dio dio = Dio(BaseOptions());
  static Dio dioRefresh = Dio(BaseOptions());
  static Dio dioRetry = Dio(BaseOptions());

  static init() {
    dio.interceptors.add(DioInterceptor());
    dioRefresh.interceptors.add(DioInterceptor());
    dioRetry.interceptors.add(DioInterceptor());

    if (Config.inStageEnv()) {
      final adapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        },
      );
      dio.httpClientAdapter = adapter;
      dioRefresh.httpClientAdapter = adapter;
      dioRetry.httpClientAdapter = adapter;
    }

    return dio;
  }

  static Future<Response> call([
    String method = "GET",
    String endpoint = "/",
    Map data = const {},
    Map<String, String> headers = const {},
    ResponseType resType = ResponseType.json,
  ]) async {
    // ignore: no_leading_underscores_for_local_identifiers
    String _baseUrl = Config.API_BASE_URL;

    endpoint = endpoint.startsWith("https://") ? endpoint : _baseUrl + endpoint;

    final opts = Options(
      method: method,
      headers: headers,
      responseType: resType,
    );

    //loynote: services need to handle error from web call. rtard.
    try {
      //CLIENT_STANDARD
      Dio client = dio;
      // print(data);
      // print(opts);
      final r = await client.request(endpoint, data: data, options: opts);
      return r;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> callApi([
    String method = "GET",
    String endpoint = "/",
    Map data = const {},
    Map<String, String> headers = const {},
    ResponseType resType = ResponseType.json,
  ]) async {
    final u = _authenticationService.user;
    var h = {'Content-Type': 'application/json; charset=UTF-8'};
    if (u?.isLogin() ?? false) {
      h['Authorization'] = 'Bearer ${u?.tokenSetApp?.accessToken}';
    }
    final mergeHeaders = <String, String>{};
    mergeHeaders.addAll(h);
    mergeHeaders.addAll(headers);

    try {
      final r = await call(method, endpoint, data, mergeHeaders);
      final ar = ApiResponse.fromJson(r.data, statusCode: r.statusCode);
      return ar;
    } on ApiException catch (e) {
      if (e.code == ErrorType.JWT_EXPIRED) {
        //loynote: auto refresh tokenSet.
        //ref: https://medium.com/flutter-community/dio-jwt-in-flutter-solution-of-async-hell-fbde4759b261
        await _authenticationService.loginViaRefreshToken();
        mergeHeaders['Authorization'] = "Bearer ${u?.tokenSetApp?.accessToken}";
        // mergeHeaders['Token'] = u?.tokenSetApp?.idToken ?? '';
        final r = await callApi(method, endpoint, data, mergeHeaders);
        return r;
      }
      if (e.code == ErrorType.REFRESH_TOKEN_EXPIRED ||
          e.code == ErrorType.REFRESH_TOKEN_INVALID ||
          e.code == ErrorType.MISSING_REFRESH_TOKEN) {
        final flag = await StoreHelper.read(StoreKey.USE_BIOMETRIC_FLAG);
        await StoreHelper.clearStorage();
        if (flag != null && flag == 'no') {
          StoreHelper.delete(StoreKey.USE_BIOMETRIC_FLAG);
        }
        _navigationService.navigateTo(Routes.loginView);
      } else if (e.code == ErrorType.MISSING_API_CREDENTIALS) {
        ShareFunc.showToast("${ErrorMessage.MISSING_API_CREDENTIALS}: Please login again.");
        _navigationService.navigateTo(Routes.loginView);
      } else if (e.code == ErrorType.NO_PERMISSION) {
        ShareFunc.showToast(ErrorMessage.NO_PERMISSION);
        _navigationService.navigateTo(Routes.loginView);
      }
      rethrow;
    }
  }

  static Map<String, String> getAuthHeader() {
    final u = _authenticationService.user;
    var h = {'Content-Type': 'application/json; charset=UTF-8'};
    h['Authorization'] = u?.tokenSetApp?.accessToken ?? '';
    return h;
  }
}

class DioInterceptor extends Interceptor {
  //Dio dio = Dio(BaseOptions(baseUrl: "base-api-url"));
  //final _authenticationService = locator<AuthenticationService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Utils.log('INTERCEPT >>>>> REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //Utils.log('INTERCEPT >>>>> RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Utils.err('INTERCEPT >>>>> ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    Utils.err('err detail: ${err.response}');
    final data = err.response?.data;

    String m = "Error";

    if (data != null && data.containsKey("status") && data.containsKey("message") && data.containsKey("code")) {
      //loynote: this true, means is from our custom API format.
      data["statusCode"] = err.response?.statusCode;
      final ae = ApiException(requestOptions: err.requestOptions, response: err.response);
      super.onError(ae, handler);
    } else {
      m = 'Error response not in right format';
      if (data != null && data.containsKey("error") && data.containsKey("error_description")) {
        m = '${data["error"]}: ${data["error_description"]}';
      }
      super.onError(err, handler);
    }
    Utils.err('Dio Error: $m');
    ShareFunc.showToast(m);
  }
}
