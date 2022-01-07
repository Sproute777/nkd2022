part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class StatusCodeChanged extends LoginEvent{
  const StatusCodeChanged(this.code);
  final int? code;
}

class LoginObscureChanged extends LoginEvent {
  const LoginObscureChanged(this.bul);
  final bool bul;
  @override
  List<Object> get props => [bul];
}
