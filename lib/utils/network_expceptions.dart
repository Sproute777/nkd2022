import 'package:dio/dio.dart';
import 'dio_error_keys.dart';

class DataException implements Exception {
  DataException({required this.message});

  DataException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = DioErrorKeys.errorRequestCancelled;
        break;
      case DioErrorType.connectTimeout:
        message = DioErrorKeys.errorConnectionTimeout;
        break;
      case DioErrorType.receiveTimeout:
        message = DioErrorKeys.errorReceiveTimeout;
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response!.statusCode!);
        break;
      case DioErrorType.sendTimeout:
        message = DioErrorKeys.errorSendTimeout;
        break;
      default:
        message = DioErrorKeys.errorInternetConnection;
        break;
    }
  }

  String message = "";

  String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return DioErrorKeys.errorBadRequest;
      case 404:
        return DioErrorKeys.errorRequestNotFound;
      case 500:
        return DioErrorKeys.errorIntenalServer;
      default:
        return DioErrorKeys.errorSomethingWentWrong;
    }
  }

  @override
  String toString() => message;
}
