import 'package:bloc_app/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/repository/auth_repository.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocProvider(
              create: (context) {
                return LoginBloc(authRepository: RepositoryProvider.of<AuthRepository>(context));
              },
              child: const LoginForm(),
            )));
  }
}
