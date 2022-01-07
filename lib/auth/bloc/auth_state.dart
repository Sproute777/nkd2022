part of 'auth_bloc.dart';



class AuthState extends Equatable {
  final AuthStatus status;

  final User user;
  const AuthState._({
    this.status = AuthStatus.unknown,

    this.user = User.empty,
  });

  const AuthState.unknown() : this._();

  // const AuthState.submitting() : this._(status: AuthStatus.submiting);

  const AuthState.authenticated( User user,)
      : this._(status: AuthStatus.auth, user: user);

  const AuthState.unautheticated() : this._(status: AuthStatus.unauth);

  @override
  List<Object> get props => [status, user ];

  
}
