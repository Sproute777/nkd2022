import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../item_update.dart';

class ItemUpdateForm extends StatelessWidget {
  final String text;
  const ItemUpdateForm(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _TextInput(text),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[_ReturnButton(), _CompleteButton()])
        ],
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final String initialValue;
  const _TextInput(this.initialValue, {Key? key}) : super(key: key);
  String? _textError(BuildContext context, ItemText cardText) {
    final error = cardText.displayError;
    if (error == null) return null;
    if (error == ItemTextValidationError.empty) {
      return "text can't be empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemUpdateBloc, ItemUpdateState>(
      buildWhen: (previous, current) => previous.text != current.text,
      builder: (context, state) {
        return TextFormField(
          initialValue: initialValue,
          onChanged: (text) =>
              context.read<ItemUpdateBloc>().add(ItemUpdateTextChanged(text)),
          textAlign: TextAlign.center,
          maxLength: 100,
          maxLines: 3,
          decoration: InputDecoration(
              hintText: 'text',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.tealAccent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
              errorText: _textError(context, state.text),
              hintStyle: const TextStyle(color: Colors.grey)),
        );
      },
    );
  }
}

class _CompleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemUpdateBloc, ItemUpdateState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('create'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<ItemUpdateBloc>().add(ItemTextCompleted());
                        Navigator.of(context).pop();
                      }
                    : null,
              );
      },
    );
  }
}

class _ReturnButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
