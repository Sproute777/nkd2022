import 'package:formz/formz.dart';

enum PasswordValidationError { short, invalid, empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
      // RegExp(r'^(?=.*[A-Za-z])(?=.*\d)\S{8,}$');
      RegExp(r'^[a-zA-Z0-9]*$');

  PasswordValidationError? get displayError => pure ? null : super.error;

  @override
  PasswordValidationError? validator(String? value) {
    return (value ?? '').isEmpty
        ? PasswordValidationError.empty
        : _passwordRegex.hasMatch(value ?? '')
            ? (value ?? '').length < 8
                ? PasswordValidationError.short
                : null
            : PasswordValidationError.invalid;
  }
}
