import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/auth.dart';
import 'login/login.dart';
import 'complex/complex.dart';
import 'splash/splash_page.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ComplexRepository complexRepository;
  const App({
    Key? key,
    required this.authRepository,
    required this.userRepository,
    required this.complexRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authRepository,
        ),
        RepositoryProvider.value(
          value: complexRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                    authRepository: authRepository,
                    userRepository: userRepository,
                  )..add(AuthInitial())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.auth:
                _navigator.pushAndRemoveUntil<void>(
                    ComplexPage.route(), (route) => false);
                break;
              case AuthStatus.unauth:
                _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
