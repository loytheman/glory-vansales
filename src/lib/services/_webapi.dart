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
      // h['Authorization'] = 'Bearer ${u?.tokenSetApp?.accessToken}';
      h['Authorization'] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6InJ0c0ZULWItN0x1WTdEVlllU05LY0lKN1ZuYyIsImtpZCI6InJ0c0ZULWItN0x1WTdEVlllU05LY0lKN1ZuYyJ9.eyJhdWQiOiJodHRwczovL2FwaS5idXNpbmVzc2NlbnRyYWwuZHluYW1pY3MuY29tIiwiaXNzIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvZDYyZTRlZDMtZWY0YS00MmEzLTg5NzgtN2ZkZTY4YjVjNjFiLyIsImlhdCI6MTc2Njc1NjkyMywibmJmIjoxNzY2NzU2OTIzLCJleHAiOjE3NjY3NjI0NTIsImFjciI6IjEiLCJhaW8iOiJBWlFBYS84YUFBQUF6NEVtV21aN05PVnRGMXZCU2hHalNzZm5xc2JwbVd1dE5ZZUF6VytnODcyWDQ4V1VPbnZIbGI5QlpicTRpb3pGdVVZcTIyVktxVW9oUHdGNlpzUFlEL0hKYlNHOFZNczdDZUMvRUl2ZTFDMlJMRU5nTmcyRy9GeGZXZTFmVmNUUWFKVks2WlVxREhnU2lqVnM3ODQ0NHU3QktiTkQrS0owZEU4cEl6VnZFRk1RV0l4MmRZMkZzNXJUdW13UHhobEsiLCJhbXIiOlsicHdkIiwibWZhIl0sImFwcGlkIjoiZjNkMmJmNTItYzNjYS00ZWZiLWE3NDgtMzJlOGE0NDhjNzk0IiwiYXBwaWRhY3IiOiIxIiwiZmFtaWx5X25hbWUiOiJMb3kiLCJnaXZlbl9uYW1lIjoiWW9rZSBIb3ciLCJpZHR5cCI6InVzZXIiLCJpcGFkZHIiOiI0OS4yNDUuNTAuMTc1IiwibmFtZSI6Illva2UgSG93IExveSIsIm9pZCI6IjU3MjgxOGQ0LTc0NDUtNGE3NS1iYjY0LTYyNGE2NjM1ZjYyNCIsInB1aWQiOiIxMDAzMjAwNTVGQTE3MEQ0IiwicmgiOiIxLkFXWUEwMDR1MWtydm8wS0plSF9lYUxYR0d6M3ZiWmxzczFOQmhnZW1fVHdCdUotakFDZG1BQS4iLCJzY3AiOiIuM2ZlMjNiNWMtYWY3My00MDY2LWE5MzAtMWFhZjdiYmIzN2QwIiwic2lkIjoiMDBiYjFhODktYTRjMi1kNGZlLTU3ZWQtMmVmMDE0MWIxZjU2Iiwic3ViIjoiMFFDZWhZRGJNTy0tdTJXYWprSW1IWWF1VEtrMHhtc2llT0RhVmRWOUhoVSIsInRpZCI6ImQ2MmU0ZWQzLWVmNGEtNDJhMy04OTc4LTdmZGU2OGI1YzYxYiIsInVuaXF1ZV9uYW1lIjoiY3RvQGx5aGNvLm1lIiwidXBuIjoiY3RvQGx5aGNvLm1lIiwidXRpIjoiZUdCMWdXUUJpa2FwOW9jVzB6Ty1BQSIsInZlciI6IjEuMCIsIndpZHMiOlsiNjJlOTAzOTQtNjlmNS00MjM3LTkxOTAtMDEyMTc3MTQ1ZTEwIiwiYjc5ZmJmNGQtM2VmOS00Njg5LTgxNDMtNzZiMTk0ZTg1NTA5Il0sInhtc19hY3RfZmN0IjoiMyA5IiwieG1zX2Z0ZCI6InlBME1OZHREeHRKLTF1by1oTW9vUzFsd3FNMEdBQ1pQTnVFU0IzVVV0X01CWVhWemRISmhiR2xoWldGemRDMWtjMjF6IiwieG1zX2lkcmVsIjoiMjYgMSIsInhtc19zdWJfZmN0IjoiMyAxMCJ9.U-o2y41ZafdkH7FEx8FPRHgwKrxwaMnd6Xm0eOM2DyGZqECGNRwD4f_3IZ4y8O6E1r4c_QwfFzOqB1eI5Rkqyt9QsMKQtpLho4xlhEA0feWLzIxjGRq85vEkiW7W8lP_-HzAKbdfh3DvE8-iXeI-XSa7Uh5kv1uWwfbgGcIcagYS75qnF3gu9Y18QrRU9Mbpx7Nz2gTgXIgX2JSm6IhsyOUBGv5YZ87xyrBwy_1w14hCSxdxr4tJZXhu1u18IgF1W8BuBbWt7yXJcCaSrWPlaNPDfGgSgOoxyyLD6oCVPqIkQ8kX0kQbrNYbi0_mSWksUh2nxrQwfqWgmmo5YKcwNQ";
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

    if (data != null && data.containsKey("status") && data.containsKey("message") && data.containsKey("code")) {
      //loynote: this true, means is from our custom API format.
      data["statusCode"] = err.response?.statusCode;
      final ae = ApiException(requestOptions: err.requestOptions, response: err.response);
      super.onError(ae, handler);
    } else {
      Utils.err('Error response not in right format');
      Utils.err('ERROR CODE: ${err.error}');
      super.onError(err, handler);
    }
  }
}
