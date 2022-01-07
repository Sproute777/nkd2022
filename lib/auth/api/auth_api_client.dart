import 'dart:async';

import 'package:dio/dio.dart';

const String kbaseUrl = 'https://trello.backend.tests.nekidaem.ru';
const String _kbaseApiPath = 'api/v1';

/// Create user , refresh token , login in
const String klogin = '/$_kbaseApiPath/users/login/';

/// Get , post , update '/cards/$id/ , delete '/cards/$id/
const String kcards = '/$_kbaseApiPath/cards/';

class AuthApiClient {
  AuthApiClient({Dio? dio})
      : _dio = dio ?? Dio() {
          _dio.options
          ..baseUrl = kbaseUrl
          ..validateStatus = (int? status){
           return status != null && status > 0;
         };
       
       _dio.interceptors
         ..add(InterceptorsWrapper(      
           onResponse: (resp, handler){          
             return handler.next(resp);
           },        
         ))
         ..add(LogInterceptor(
           responseHeader: true,
           responseBody: true,
         ));        
      }

  final Dio _dio ;

  Future<Response> login({
    required String username,
    required String password,
    }) async {
     var _formData = {
    'username': username,
    'password': password
    };
    var response = await _dio.post(klogin,data: _formData, );
    return response;

  }

  void close(){
    _dio.close();
  }
}