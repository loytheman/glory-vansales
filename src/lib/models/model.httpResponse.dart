import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:glory_vansales_app/helpers/utils.dart';



class ApiResponse {
  late int? statusCode; //Not Implemented
  //late Map<String, dynamic> jsonData;
  late String status = "";
  late String message = "";
  late List stack = [];
  late String code = "";
  late dynamic data;

  //ResponseValidationError({required this.status, required this.message, required this.stack, required this.code, required this.data});
  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> jsonData, {int? statusCode}) {
    final c = ApiResponse();

    c.statusCode = statusCode;
    c.status = jsonData['status'] ?? statusCode.toString();
    // c.message = jsonData['message'] ??= "";
    // c.stack = jsonData['stack'] ??= [];
    // c.code = jsonData['code'] ??= "";
    // c.data = jsonData['data'] ??= {};
    // c.data = jsonData['value'] ??= {};
    //loynote: fucking bc response not standardise
    c.data = jsonData['value'] ??= jsonData;

    return c;
  }
}

class ApiException extends DioException {
  //final String type = "ApiException";
  late int statusCode = 666;
  @override
  // ignore: overridden_fields
  late String message = "";
  late String code = "";
  late Map<String, dynamic> data = {};

  ApiException({
    required super.requestOptions,
    required super.response,
  }) {
    //var e = ApiException(requestOptions:requestOptions, response:response);
    Map<String, dynamic> m = response?.data;
    statusCode = response?.statusCode as int;
    message = m["message"] as String;
    code = m["code"] as String;
    data = {};
    if (m['data'] != null) {
      data = m["data"] as Map<String, dynamic>;
    }
  }
}

class ValidationException implements Exception {
  final String type = "ValidationException";
  late String message = "";
  late List<ValidationError> validatationErrors = [];

  //constructor
  ValidationException();

  // factory ValidationException.fromApiResponse(ApiResponse ar) {
  //   final e = ValidationException();
  //   final d = ar.data['validation'];
  //   final j = json.decode(d);
  //   e.message = ar.message;
  //   e.validatationErrors =
  //       (List<ValidationError>.from(j.map((x) => ValidationError.fromJson(x))));

  //   return e;
  // }

  factory ValidationException.fromApiException(ApiException ae) {
    final e = ValidationException();
    String d = ae.data['validation'] ?? '';
    final j = json.decode(d);
    e.message = ae.message;
    e.validatationErrors = (List<ValidationError>.from(j.map((x) => ValidationError.fromJson(x))));

    return e;
  }

  @override
  String toString() {
    if (message.isEmpty) return "ValidationException";
    return "ValidationException: $message";
  }

  List<ValidationError> getErrors() {
    // log(validatationErrors);
    return validatationErrors;
  }

  Map<String, String?> mapErrors() {
    Map<String, String?> m = {};
    var l = validatationErrors;
    for (var v in l) {
      m[v.field] = v.message;
    }
    return m;
  }
}

class ValidationError {
  final String field;
  final String message;

  ValidationError({required this.field, required this.message});

  factory ValidationError.fromJson(Map<String, dynamic> data) => ValidationError(
        field: data['field'],
        message: data['message'],
      );
}




class FilterQuery {
  List<String> filterList = [];

  FilterQuery();

  FilterQuery.fromList(List<String> l) {
    filterList = l;
  }

  void filter({required String field, required String value}) {
    String s = "$field eq '$value'";
    filterList.add(s);
  }

  void filterDate({required String field, required String startDate, String? endDate}) {
    String s = "$field ge $startDate";
    if (endDate != null) {
      s += " and $field le $endDate";
    }
    filterList.add(s);
  }

  String getString() {
    String filterStr = "?\$filter=";
    for (int i = 0; i< filterList.length; i++) {
      String s = filterList[i];
      Utils.log(s);
      if (i == 0) {
        filterStr += "$s ";
      } else {
        filterStr += "and $s ";
      }
      
    }    
    return filterStr;
  }
}
