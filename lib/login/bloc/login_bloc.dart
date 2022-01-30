import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../auth/repository/auth_repository.dart';
import '../models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginObscureChanged>(_onObscureChanged);
    on<StatusCodeChanged>(_onStatusCodeChanged);
    // _subsAuthRepository = _authRepository.status.listen((data) {
    //   add(StatusCodeChanged(data.code));
    // });
  }
  // StreamSubscription? _subsAuthRepository;
  final AuthRepository _authRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onObscureChanged(LoginObscureChanged event, Emitter<LoginState> emit) {
    emit(event.bul == true
        ? state.copyWith(isObscure: false, isChecked: true)
        : state.copyWith(isObscure: true, isChecked: false));
  }

  void _onStatusCodeChanged(StatusCodeChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(statusCode: event.code));
  }

  @override
  Future<void> close() async {
    // _subsAuthRepository?.cancel();
    return super.close();
  }
}
