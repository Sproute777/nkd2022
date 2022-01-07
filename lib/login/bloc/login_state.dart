part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isObscure = true,
    this.isChecked = false,
    this.statusCode = 0,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final bool isObscure;
  final bool isChecked;
  final int statusCode;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? isObscure,
    bool? isChecked,
    int? statusCode,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
      isChecked: isChecked ?? this.isChecked,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object> get props => [status, username, password, isObscure, isChecked, statusCode];
}
