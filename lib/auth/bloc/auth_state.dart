part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState._({
    this.status = AuthStatus.unknown,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated() : this._(status: AuthStatus.auth);

  const AuthState.unautheticated() : this._(status: AuthStatus.unauth);

  @override
  List<Object> get props => [status];
}
