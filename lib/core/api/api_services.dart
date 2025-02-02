import 'package:dio/dio.dart';

abstract class ApiServices {
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic> queryParameters,
  });

  Future<Response> post({
    required String endPoint,
    Map<String, dynamic> queryParameters,
    required dynamic data,
  });
  Future<Response> put({
    required String endPoint,
    Map<String, dynamic> queryParameters,
    required dynamic data,
  });
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic> queryParameters,
    dynamic data,
  });

  void setBaseUrl({required baseUrl});
  void setHeaders({
    required Map<String, dynamic> headers,
  });
}
