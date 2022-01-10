import 'package:formz/formz.dart';

enum CardTextValidationError { empty, short }

class CardText extends FormzInput<String, CardTextValidationError> {
  const CardText.pure() : super.pure('');
  const CardText.dirty([String value = '']) : super.dirty(value);

  CardTextValidationError? get displayError => pure ? null : super.error;

  @override
  CardTextValidationError? validator(String? value) {
    return (value ?? '').isEmpty
        ? CardTextValidationError.empty
        : (value ?? '').length < 3
            ? CardTextValidationError.short
            : null;
  }
}
