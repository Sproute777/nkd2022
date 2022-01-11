import 'dart:async';
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
    _checkToken();
  }

  Future<AuthData> _checkToken() async {
    var token = Hive.box('api_box').get('token');
    if (token != null) {
      return const AuthData(status: AuthStatus.auth, code: 0);
    }
    return const AuthData(status: AuthStatus.unauth, code: 0);
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final response = await _apiClient.login(
      username: username,
      password: password,
    );
    if (response.statusCode != 200) {
      await Hive.box('api_box').put('token', null);
      return _controller.add(
          AuthData(status: AuthStatus.unauth, code: response.statusCode ?? 0));
    } else {
      await Hive.box('api_box').put('token', response.data['token']);
      return _controller
          .add(const AuthData(status: AuthStatus.auth, code: 200));
    }
  }

  void logOut() {
    _controller.add(const AuthData(status: AuthStatus.unauth, code: 0));
  }

  void dispose() {
    _controller.close();
    _apiClient.close();
  }
}
