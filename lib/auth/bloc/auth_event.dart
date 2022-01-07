part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthDataChanged extends AuthEvent {
  const AuthDataChanged( this.status );
  final AuthStatus status;
 
  @override
  List<Object> get props => [status];
}

class AuthInitial extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}
