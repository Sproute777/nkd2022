import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, auth, unauth }

class AuthData extends Equatable {
  final AuthStatus status;
  final Exception? exception;

  const AuthData({required this.status, this.exception});

  @override
  List<Object?> get props => [status, exception];
}
