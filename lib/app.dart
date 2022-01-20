import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'auth/auth.dart';
import 'l10n/l10n.dart';
import 'login/login.dart';
import 'complex/complex.dart';
import 'splash/splash_page.dart';

class App extends StatelessWidget {
  final AuthRepository authRepository;
  final ComplexRepository complexRepository;
  const App({
    Key? key,
    required this.authRepository,
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
              lazy: false,
              create: (_) => AuthBloc(
                    authRepository: authRepository,
                  )),
          BlocProvider<ComplexListBloc>(
            create: (_) => ComplexListBloc(repository: complexRepository)
              ..add(LoadComplexList()),
          ),
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      // locale:  Locale("ru"),
      supportedLocales: L10n.all,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.auth:
                _navigator.pushAndRemoveUntil<void>(
                    ComplexPage.route(), (route) => false);
                break;

              default:
                _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(), (route) => false);
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
