class ServerException implements Exception {
  final int? message;
  final Object? error;

  ServerException({this.message, this.error});

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";

    switch (message) {
      case 400:
      case 401:
      case 402:
      case 403:
      case 404:
        return 'Not find data';

      default:
    }
    return "message $message , error $error";
  }
}
