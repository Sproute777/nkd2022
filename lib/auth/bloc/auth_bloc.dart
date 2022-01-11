import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/auth_data.dart';
import '../repository/auth_repository.dart';
import '../models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  late StreamSubscription<AuthData> _authStatusSubscription;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    on<AuthDataChanged>(_onAuthDataChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription =
        _authRepository.status.listen((repo) => add(AuthDataChanged(
              repo.status,
            )));
  }

  void _onAuthDataChanged(
      AuthDataChanged event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthStatus.unauth:
        return emit(const AuthState.unautheticated());
      case AuthStatus.auth:
        return emit(const AuthState.authenticated());
      default:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) {
    _authRepository.logOut();
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }
}
