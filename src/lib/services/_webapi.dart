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
      print(data);
      print(opts);
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
      h['Authorization'] = u?.tokenSetApp?.accessToken ?? '';
      h['Token'] = u?.tokenSetApp?.idToken ?? '';
      // h['Authorization'] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwayI6IiNVU0VSX0FETUlOOjAxSDVXME41RDZSNkpKNU0xWkZLVlY4SzZRIiwic2siOiIjVVNFUl9BRE1JTiNNRVRBREFUQSIsImlkIjoiMDFINVcwTjVENlI2Sko1TTFaRktWVjhLNlEiLCJzdWIiOiIwMUg1VzBONUQ2UjZKSjVNMVpGS1ZWOEs2USIsImdzMHBrIjoiI1VTRVJfQURNSU4jTUVUQURBVEEiLCJnczBzayI6IiNVU0VSX0FETUlOI1RJTUVTVEFNUDoyMDI0LTEyLTE4VDA3OjU3OjE5LjQxOFoiLCJnczFwayI6IiNVU0VSX0FETUlOOm11bmhpbi5vb2lAbWV5emVyYnVzaW5lc3MuY29tIiwiZ3Mxc2siOiIjVVNFUl9BRE1JTiNNRVRBREFUQSIsImVtYWlsIjoibXVuaGluLm9vaUBtZXl6ZXJidXNpbmVzcy5jb20iLCJmaXJzdE5hbWUiOiJNdW4gSGluIiwicm9sZSI6InN1cGVyYWRtaW4iLCJkZXBhcnRtZW50IjpbImNvcnBzZWMiLCJhdWRpdCIsImJvbmEiXSwiYWRtaW5Sb2xlIjoiaW50bHxjb3Jwc2VjOnN1cGVyYWRtaW58Y29ycHNlYyxhdWRpdCxib25hfCwwMUowUTc4N0hGNEtKRlZKMlhLNVEyMjg4OCIsImxhc3ROYW1lIjoiT29pIiwibW9iaWxlIjoiMTY4MTE1OTY3NTYiLCJtb2JpbGVDb3VudHJ5Q29kZSI6Iis2MCIsIm1vYmlsZUZ1bGwiOiIrNjAxNjgxMTU5Njc1NiIsInN0YXR1cyI6ImVuYWJsZWQiLCJhY2NvdW50U3RhdHVzIjoibm9ybWFsIiwidXBkYXRlZEJ5Ijp7ImxvY2F0aW9uRGF0YSI6eyJjb3VudHJ5IjoiTVkiLCJyZWdpb24iOiIxMCIsImNpdHkiOiJTdWJhbmcgSmF5YSIsImxhdGl0dWRlIjozLjE0MDIsImxvbmdpdHVkZSI6MTAxLjYwNzJ9LCJpcCI6IjE3NS4xMzYuMjQ4LjEzNyIsIm5hbWUiOiJNdW4gSGluIE9vaSIsImNsaWVudEluZm8iOnsiZGV2aWNlVHlwZSI6ImRlc2t0b3AiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUiLCJicm93c2VyVmVyc2lvbiI6IjEzMS4wLjAuMCJ9LCJ1c2VySWQiOiIwMUg1VzBONUQ2UjZKSjVNMVpGS1ZWOEs2USIsImVtYWlsIjoibXVuaGluLm9vaUBtZXl6ZXJidXNpbmVzcy5jb20iLCJtb2JpbGVGdWxsIjoiKzYwMTY4MTE1OTY3NTYifSwiYXVkaXRTdHJlYW1JZCI6IjAxSkQ2NTlaNTNBUzM1QUVEVjE1ODZSUDQ4Iiwia2V5d29yZFNlYXJjaCI6Im11biBoaW4gb29pIG11bmhpbi5vb2lAbWV5emVyYnVzaW5lc3MuY29tIiwiX3R5cGUiOiJVc2VyQWRtaW4iLCJjcmVhdGVkQXQiOiIyMDI0LTA4LTA2VDAxOjQ4OjExLjY3OVoiLCJ1cGRhdGVkQXQiOiIyMDI0LTEyLTE4VDA3OjU3OjE5LjQxOFoiLCJpYXQiOjE3MzQ1MDg3MTQsImV4cCI6MTczNTcxODMxNH0.LBQpolVWae8gAfnqOlVzYsOxfvC1xJKeyjuaVMHAEHs";
      // h['Token'] = "eyjhbgcioijiuzi1niisinr5cci6ikpxvcj9.eyjzdwiioiiwmug1vzbonuq2ujzksjvnmvpgs1zwoes2usisimlhdci6mtcznduwodcxncwizxhwijoxnzm1nze4mze0fq.3qkhj2ncesfpc3irroybic9h_ydzqfpkmnedqnl09_4";
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

  // static String getPreviewUrl(String key, String sessionAccessToken) {
  //   //final url = "${u}/site/preview/${key}?token=${token}";
  //   final url = "${WebApi.baseUrl}/site/preview/$key?token=$sessionAccessToken";
  //   return url;
  // }

  static Map<String, String> getAuthHeader() {
    final u = _authenticationService.user;
    var h = {'Content-Type': 'application/json; charset=UTF-8'};
    h['Authorization'] = u?.tokenSetApp?.accessToken ?? '';
    h['Token'] = u?.tokenSetApp?.idToken ?? '';
    // h['Authorization'] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwayI6IiNVU0VSX0FETUlOOjAxSDVXME41RDZSNkpKNU0xWkZLVlY4SzZRIiwic2siOiIjVVNFUl9BRE1JTiNNRVRBREFUQSIsImlkIjoiMDFINVcwTjVENlI2Sko1TTFaRktWVjhLNlEiLCJzdWIiOiIwMUg1VzBONUQ2UjZKSjVNMVpGS1ZWOEs2USIsImdzMHBrIjoiI1VTRVJfQURNSU4jTUVUQURBVEEiLCJnczBzayI6IiNVU0VSX0FETUlOI1RJTUVTVEFNUDoyMDI0LTEyLTE4VDA3OjU3OjE5LjQxOFoiLCJnczFwayI6IiNVU0VSX0FETUlOOm11bmhpbi5vb2lAbWV5emVyYnVzaW5lc3MuY29tIiwiZ3Mxc2siOiIjVVNFUl9BRE1JTiNNRVRBREFUQSIsImVtYWlsIjoibXVuaGluLm9vaUBtZXl6ZXJidXNpbmVzcy5jb20iLCJmaXJzdE5hbWUiOiJNdW4gSGluIiwicm9sZSI6InN1cGVyYWRtaW4iLCJkZXBhcnRtZW50IjpbImNvcnBzZWMiLCJhdWRpdCIsImJvbmEiXSwiYWRtaW5Sb2xlIjoiaW50bHxjb3Jwc2VjOnN1cGVyYWRtaW58Y29ycHNlYyxhdWRpdCxib25hfCwwMUowUTc4N0hGNEtKRlZKMlhLNVEyMjg4OCIsImxhc3ROYW1lIjoiT29pIiwibW9iaWxlIjoiMTY4MTE1OTY3NTYiLCJtb2JpbGVDb3VudHJ5Q29kZSI6Iis2MCIsIm1vYmlsZUZ1bGwiOiIrNjAxNjgxMTU5Njc1NiIsInN0YXR1cyI6ImVuYWJsZWQiLCJhY2NvdW50U3RhdHVzIjoibm9ybWFsIiwidXBkYXRlZEJ5Ijp7ImxvY2F0aW9uRGF0YSI6eyJjb3VudHJ5IjoiTVkiLCJyZWdpb24iOiIxMCIsImNpdHkiOiJTdWJhbmcgSmF5YSIsImxhdGl0dWRlIjozLjE0MDIsImxvbmdpdHVkZSI6MTAxLjYwNzJ9LCJpcCI6IjE3NS4xMzYuMjQ4LjEzNyIsIm5hbWUiOiJNdW4gSGluIE9vaSIsImNsaWVudEluZm8iOnsiZGV2aWNlVHlwZSI6ImRlc2t0b3AiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUiLCJicm93c2VyVmVyc2lvbiI6IjEzMS4wLjAuMCJ9LCJ1c2VySWQiOiIwMUg1VzBONUQ2UjZKSjVNMVpGS1ZWOEs2USIsImVtYWlsIjoibXVuaGluLm9vaUBtZXl6ZXJidXNpbmVzcy5jb20iLCJtb2JpbGVGdWxsIjoiKzYwMTY4MTE1OTY3NTYifSwiYXVkaXRTdHJlYW1JZCI6IjAxSkQ2NTlaNTNBUzM1QUVEVjE1ODZSUDQ4Iiwia2V5d29yZFNlYXJjaCI6Im11biBoaW4gb29pIG11bmhpbi5vb2lAbWV5emVyYnVzaW5lc3MuY29tIiwiX3R5cGUiOiJVc2VyQWRtaW4iLCJjcmVhdGVkQXQiOiIyMDI0LTA4LTA2VDAxOjQ4OjExLjY3OVoiLCJ1cGRhdGVkQXQiOiIyMDI0LTEyLTE4VDA3OjU3OjE5LjQxOFoiLCJpYXQiOjE3MzQ1MDg3MTQsImV4cCI6MTczNTcxODMxNH0.LBQpolVWae8gAfnqOlVzYsOxfvC1xJKeyjuaVMHAEHs";
    // h['Token'] = "eyjhbgcioijiuzi1niisinr5cci6ikpxvcj9.eyjzdwiioiiwmug1vzbonuq2ujzksjvnmvpgs1zwoes2usisimlhdci6mtcznduwodcxncwizxhwijoxnzm1nze4mze0fq.3qkhj2ncesfpc3irroybic9h_ydzqfpkmnedqnl09_4";
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
