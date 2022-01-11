import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, auth, unauth }

class AuthData extends Equatable {
  final AuthStatus status;
  final int code;
  const AuthData({required this.status, required this.code});

  @override
  List<Object?> get props => [status, code];
}
