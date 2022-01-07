import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/auth_data.dart';
import '../repository/auth_repository.dart';
import '../repository/user_repository.dart';
import '../models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthData> _authStatusSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthInitial>(_onAuthInitial);
    on<AuthDataChanged>(_onAuthDataChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.status.listen((repo) => 
        add(AuthDataChanged(repo.status,)));
  }

  void _onAuthInitial(AuthInitial event, Emitter<AuthState> emit) async {
    _authRepository.checkToken();
  }

  void _onAuthDataChanged(
      AuthDataChanged event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthStatus.unauth:
        return emit( const AuthState.unautheticated());
      case AuthStatus.auth:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthState.authenticated(user)
            : const AuthState.unautheticated());
      default:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) {
    _authRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }
}
