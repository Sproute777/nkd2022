import 'dart:async';

import 'package:dio/dio.dart';

const String kbaseUrl = 'https://trello.backend.tests.nekidaem.ru';
const String _kbaseApiPath = 'api/v1';

/// Create user , refresh token , login in
const String klogin = '/$_kbaseApiPath/users/login/';

/// Get , post , update '/cards/$id/ , delete '/cards/$id/
const String kcards = '/$_kbaseApiPath/cards/';

class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options
      ..baseUrl = kbaseUrl
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      };

    _dio.interceptors
      ..add(InterceptorsWrapper(
        onResponse: (resp, handler) {
          return handler.next(resp);
        },
      ))
      ..add(LogInterceptor(
        responseHeader: true,
        responseBody: true,
        request: true,
        requestBody: true,
        requestHeader: true,
      ));
  }

  final Dio _dio;

  Future<Response> get(
    String url, {
    required String token,
  }) async {
    var response = await _dio.get(
      url,
      options: Options(headers: {'Authorization': 'JWT $token'}),
    );
    return response;
  }

  Future<Response> post(
    String url, {
    required Map<String, dynamic> data,
    required String token,
  }) async {
    var response = await _dio.post(
      url,
      data: data,
      options: Options(headers: {'Authorization': 'JWT $token'}),
    );
    return response;
  }

  Future<Response> update(
    String url, {
    required Map<String, dynamic> data,
    required String token,
  }) async {
    var response = await _dio.patch(
      url,
      data: data,
      options: Options(headers: {'Authorization': 'JWT $token'}),
    );
    return response;
  }

  Future<Response> delete(
    String url, {
    required String token,
  }) async {
    var response = await _dio.delete(
      url,
      options: Options(headers: {'Authorization': 'JWT $token'}),
    );
    return response;
  }

  void close() {
    _dio.close();
  }
}
