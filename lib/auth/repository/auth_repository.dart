import 'dart:async';
import 'package:bloc_app/utils/server_exception.dart';
import 'package:hive/hive.dart';
import '../api/auth_api_client.dart';
import '../models/auth_data.dart';

//   armada
//   FSH6zBZ0p9yH
class AuthRepository {
  AuthRepository({AuthApiClient? apiClient})
      : _apiClient = apiClient ?? AuthApiClient();

  final AuthApiClient _apiClient;
  final _controller = StreamController<AuthData>.broadcast();

  Stream<AuthData> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    yield await _checkToken();
    yield* _controller.stream.asBroadcastStream();
  }

  Future<AuthData> _checkToken() async {
    var token = Hive.box('api_box').get('token');
    if (token != null) {
      return const AuthData(status: AuthStatus.auth);
    }
    return const AuthData(status: AuthStatus.unauth);
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiClient.login(
        username: username,
        password: password,
      );
      if (response.statusCode != 200) {
        await Hive.box('api_box').put('token', null);
        _controller.add(const AuthData(
          status: AuthStatus.unauth,
        ));
        throw ServerException(message: response.statusCode);
      }

      await Hive.box('api_box').put('token', response.data['token']);
      return _controller.add(const AuthData(status: AuthStatus.auth));
    } catch (e) {
      throw ServerException(error: e);
    }
  }

  void logOut() async {
    await Hive.box('api_box').put('token', null);
    _controller.add(const AuthData(
      status: AuthStatus.unauth,
    ));
  }

  void dispose() {
    _controller.close();
    _apiClient.close();
  }
}
