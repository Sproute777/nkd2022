import 'package:formz/formz.dart';

enum ItemTextValidationError { empty, short }

class ItemText extends FormzInput<String, ItemTextValidationError> {
  const ItemText.pure() : super.pure('');
  const ItemText.dirty([String value = '']) : super.dirty(value);

  ItemTextValidationError? get displayError => pure ? null : super.error;

  @override
  ItemTextValidationError? validator(String? value) {
    return (value ?? '').isEmpty
        ? ItemTextValidationError.empty
        : (value ?? '').length < 3
            ? ItemTextValidationError.short
            : null;
  }
}
