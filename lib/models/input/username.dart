import 'package:formz/formz.dart';

enum UsernameValidationError { invalid, short, empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final _userRegex = RegExp(r'^[a-zA-Z0-9]*$');

  UsernameValidationError? get displayError => pure ? null : super.error;

  @override
  UsernameValidationError? validator(String? value) {
    return (value ?? '').isEmpty
        ? UsernameValidationError.empty
        : _userRegex.hasMatch(value ?? '')
            ? (value ?? '').length < 3
                ? UsernameValidationError.short
                : null
            : UsernameValidationError.invalid;
  }
}
