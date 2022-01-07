import 'package:bloc_app/login/bloc/login_bloc.dart';
import 'package:bloc_app/login/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                 SnackBar(content: Text('failure ${state.statusCode}')),
              );}
          if (state.status.isSubmissionSuccess) {
            if(state.statusCode == 0) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                 SnackBar(content: Text('${state.statusCode}')),
              );
          }
        
        },
        child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _UsernameInput(),
                  _PasswordInput(),
                  _CheckBox(),
                  _LoginButton()
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: e,
                        ))
                    .toList())));
  }
}

class _UsernameInput extends StatelessWidget {
  String? _usernameError(BuildContext context, Username username) {
    final error = username.displayError;
    if (error == null) return null;
    if (error == UsernameValidationError.empty) {
      return "user can't be empty";
    } else if (error == UsernameValidationError.invalid) {
      return "validate simbols a-z, A-Z, 0-9 ";
    } else if (error == UsernameValidationError.short) {
      return "too short username ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          textAlign: TextAlign.center,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.tealAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              hintText: 'Username',
              errorText: _usernameError(context, state.username),
              hintStyle: const TextStyle(color: Colors.grey)),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  String? _passwordError(BuildContext context, Password password) {
    final error = password.displayError;
    if (error == null) return null;
    if (error == PasswordValidationError.empty) {
      return "password can't be empty";
    } else if (error == PasswordValidationError.invalid) {
      return "valided simbols a-z, A-Z, 0-9 ";
    } else if (error == PasswordValidationError.short) {
      return "at least 8 characters a-z, A-Z, 0-9 ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isObscure != current.isObscure,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          textAlign: TextAlign.center,
          obscureText: state.isObscure,
          decoration: InputDecoration(
              hintText: 'password',
              errorText: _passwordError(context, state.password),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.tealAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red),
              ),
              hintStyle: const TextStyle(color: Colors.grey)),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class _CheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isChecked != current.isChecked,
      builder: (context, state) {
        return Row(children: [
          Checkbox(
            checkColor: Colors.black,
            value: state.isChecked,
            onChanged: (bool? value) {
              if (value != null) {
                context.read<LoginBloc>().add(LoginObscureChanged((value)));
              }
            },
          ),
          const Text('show password')
        ]);
      },
    );
  }
}
